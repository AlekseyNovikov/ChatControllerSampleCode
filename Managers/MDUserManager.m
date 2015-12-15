//
//  MDUserManager.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 17/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDUserManager.h"
#import "MDUser.h"
#import "MDDoctor.h"
#import "MDChildren.h"
#import "MDChatManager.h"

#import <EasyMapping.h>
#import <Realm/Realm.h>

#import "MDModelManager.h"

#import "MDNetworkManager.h"

@implementation MDUserManager

#pragma mark - Singleton
+ (MDUserManager *)sharedManager
{
	static MDUserManager *__userManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		__userManager = [[MDUserManager alloc] init];
	});
	return __userManager;
}

- (void)createChatManager
{
	self.chatManager = [[MDChatManager alloc] init];
}

- (void)createUserWithTocken:(NSString *)authTocken
{
	MDUser *user = [[MDUser alloc] init];
	user.authTocken = authTocken;
	self.user = user;

}

- (void)configureUserWithInfo:(NSDictionary *)userInfo
{
	if (self.user) {
		[EKMapper fillObject:self.user fromExternalRepresentation:userInfo withMapping:[MDUser objectMapping]];
		[MDUser saveUser:self.user];
	}
}


#pragma mark - Getters

- (MDDoctor *)currentDoctor
{
	return self.user.doctor;
}

#pragma mark - Registration
- (MDHTTPRequest *)getSmsCodeWithPhoneNumber:(NSString *)phoneNumber
								  completion:(void (^)(MDHTTPRequest *, NSError *))completion
{
	return [[MDNetworkManager sharedManager].clientAPI getSmsCodeWithPhoneNumber:phoneNumber
																		 success:^(MDHTTPRequest *request, id responseObject) {
				__block NSError *error = request.errorAPI;
				[[MDModelManager sharedManager]performModelOperation:^{

				 } completion:^{
					 if (completion != nil) completion(request, error);
				 }];

			}
																		 failure:^(MDHTTPRequest *request, NSError *error) {
				if (completion != nil) completion(request, error);
			}];
}

- (MDHTTPRequest *)loginWithSMSCode:(NSString *)smsCode
						phoneNumber:(NSString *)phoneNumber
						 completion:(void (^)(BOOL codeValid, MDHTTPRequest *, NSError *))completion
{
	return [[MDNetworkManager sharedManager].clientAPI loginWithSMSCode:smsCode
															phoneNumber:phoneNumber
																success:^(MDHTTPRequest *request, id responseObject) {
				__block NSError *error = request.errorAPI;
				__block BOOL successLogin = NO;
				[[MDModelManager sharedManager] performModelOperation:^{
					 if (!error) {
						 successLogin = YES;
						 NSString *authTocken = [responseObject objectForKey:MDResponseJSONKeyAuthCode];
						 [self createUserWithTocken:authTocken];
					 }
				 } completion:^{
					 if (completion != nil) completion(successLogin, request, error);

				 }];

			} failure:^(MDHTTPRequest *request, NSError *error) {
				if (completion != nil) completion(NO, request, error);
			}];
}

- (MDHTTPRequest *)registerUserWithData:(NSDictionary *)userData
							 completion:(void (^)(MDUser *user, MDHTTPRequest *, NSError *))completion
{
	return [[MDNetworkManager sharedManager].clientAPI registerUserWithData:userData
																	success:^(MDHTTPRequest *request, id responseObject) {
				__block NSError *error = request.errorAPI;
                [[MDModelManager sharedManager] performModelOperation:^{
				[self configureUserWithInfo:responseObject[MDResponceJSONKeyUser]];
                } completion:^{
                    if (completion != nil) completion(self.user, request, error);
                }];
			} failure:^(MDHTTPRequest *request, NSError *error) {
				if (completion != nil) completion(nil, request, error);
			}];
}


@end
