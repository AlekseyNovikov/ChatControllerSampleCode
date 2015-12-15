//
//  MDUserManager.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 17/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDUser.h"
@class MDUser;
@class MDDoctor;
@class MDChildren;
@class MDChatManager;
@class MDHTTPRequest;

@interface MDUserManager : NSObject

+ (MDUserManager *)sharedManager;

@property(nonatomic, strong) MDUser *user;
@property(nonatomic, strong) MDDoctor *currentDoctor;
//@property(nonatomic, strong) MDTariff *currentTariff;
@property(nonatomic, strong) MDChatManager *chatManager;

- (void)createChatManager;
- (void)createUserWithTocken:(NSString *)authTocken;
- (void)configureUserWithInfo:(NSDictionary *)userInfo;


/// Registration
- (MDHTTPRequest *)getSmsCodeWithPhoneNumber:(NSString *)phoneNumber
								  completion:(void (^)(MDHTTPRequest *request, NSError *error))completion;

- (MDHTTPRequest *)loginWithSMSCode:(NSString *)smsCode
						phoneNumber:(NSString *)phoneNumber
						 completion:(void (^)(BOOL codeValid, MDHTTPRequest *request, NSError *error))completion;

- (MDHTTPRequest *)registerUserWithData:(NSDictionary *)userData
							 completion:(void (^)(MDUser *user, MDHTTPRequest *request, NSError *error))completion;


@end
