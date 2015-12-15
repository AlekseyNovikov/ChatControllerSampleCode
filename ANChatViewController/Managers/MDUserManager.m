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

//#import "MDNetworkManager.h"

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

//- (void)createUserWithTocken:(NSString *)authTocken
//{
//	MDUser *user = [[MDUser alloc] init];
//	user.authTocken = authTocken;
//	self.user = user;
//
//}
//
//- (void)configureUserWithInfo:(NSDictionary *)userInfo
//{
//	if (self.user) {
//		[EKMapper fillObject:self.user fromExternalRepresentation:userInfo withMapping:[MDUser objectMapping]];
//		[MDUser saveUser:self.user];
//	}
//}


#pragma mark - Getters

- (MDDoctor *)currentDoctor
{
	return self.user.doctor;
}

#pragma mark - Registration
- (void)getSmsCodeWithPhoneNumber:(NSString *)phoneNumber
								  completion:(void (^)(NSError *))completion
{
    //clientAPI  request
   if(completion != nil) completion(nil);
}

- (void)loginWithSMSCode:(NSString *)smsCode
						phoneNumber:(NSString *)phoneNumber
						 completion:(void (^)(BOOL codeValid, NSError *))completion
{
    //clientAPI  request get succes login
    if ([smsCode isEqualToString:@"1237"]) {
       if(completion != nil) completion(YES, nil);
    }else
    {
       if(completion != nil) completion(NO, nil);
    }
    
}

- (void)registerUserWithData:(NSDictionary *)userData
							 completion:(void (^)(NSError *))completion
{
    //clientAPI  request get user Info

   if(completion != nil) completion(nil);
}


@end
