//
//  MDClientAPI.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 17/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

//#import "SJGHTTPRequestManager.h"
#import "MDHTTPRequest.h"
#import "MDUserManager.h"


typedef void (^MDHTTPRequestSuccess)(MDHTTPRequest *request, id responseObject);
typedef void (^MDHTTPRequestFailure)(MDHTTPRequest *request, NSError *error);


@interface MDClientAPI : SJGHTTPRequestManager

// Base
- (MDHTTPRequest *)requestWithURLString:(NSString *)URLString
                       HTTPRequestMethod:(SJGHTTPRequestMethod)HTTPRequestMethod
                              parameters:(id)parameters
               constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                               autoStart:(BOOL)autoStart
                                 success:(MDHTTPRequestSuccess)success
                                 failure:(MDHTTPRequestFailure)failure;

- (MDHTTPRequest *)requestWithURLString:(NSString *)URLString
                       HTTPRequestMethod:(SJGHTTPRequestMethod)HTTPRequestMethod
                              parameters:(id)parameters
                               autoStart:(BOOL)autoStart
                                 success:(MDHTTPRequestSuccess)success
                                 failure:(MDHTTPRequestFailure)failure;

- (MDHTTPRequest *)requestWithURLString:(NSString *)URLString
                       HTTPRequestMethod:(SJGHTTPRequestMethod)HTTPRequestMethod
                              parameters:(id)parameters
                                 success:(MDHTTPRequestSuccess)success
                                 failure:(MDHTTPRequestFailure)failure;

@end


#pragma mark - Registration
@interface MDClientAPI (Registration)

- (MDHTTPRequest *)getSmsCodeWithPhoneNumber:(NSString *)phoneNumber
                                    success:(MDHTTPRequestSuccess)success
                                     failure:(MDHTTPRequestFailure)failure;

- (MDHTTPRequest *)loginWithSMSCode:(NSString *)smsCode
                        phoneNumber:(NSString *)phoneNumber
                            success:(MDHTTPRequestSuccess)success
                            failure:(MDHTTPRequestFailure)failure;

- (MDHTTPRequest *)registerUserWithData:(NSDictionary *)userData
                                success:(MDHTTPRequestSuccess)success
                                failure:(MDHTTPRequestFailure)failure;

@end

#pragma mark - Chat
@interface MDClientAPI (Chat)

- (MDHTTPRequest *)getMessagesStarted:(NSInteger)lastMessageID
                              success:(MDHTTPRequestSuccess)success
                              failure:(MDHTTPRequestFailure)failure;

- (MDHTTPRequest *)getMessagesStarted:(NSInteger)lastMessageID
                                count:(NSInteger)countOfMessages
                              success:(MDHTTPRequestSuccess)success
                              failure:(MDHTTPRequestFailure)failure;


- (MDHTTPRequest *)sendMessage:(NSDictionary *)messageDict
                       success:(MDHTTPRequestSuccess)success
                       failure:(MDHTTPRequestFailure)failure;


@end


#pragma mark - Profile
@interface MDClientAPI (Profile)

- (MDHTTPRequest *)getUserProfileData:(MDHTTPRequestSuccess)success
                                failure:(MDHTTPRequestFailure)failure;

- (MDHTTPRequest *)updateUserProfileWithData:(NSDictionary *)userData
                                success:(MDHTTPRequestSuccess)success
                                failure:(MDHTTPRequestFailure)failure;
@end
