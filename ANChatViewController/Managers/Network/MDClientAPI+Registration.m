
//  MDClientAPI+Registration.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 17/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDClientAPI.h"

static NSString *const MDRequestURLStringSendPassword = @"sendPassword";
static NSString *const MDRequestURLStringLoginWithSMS = @"login";
static NSString *const MDRequestURLStringRegisterUser = @"userProfile?auth_key=%@";

@implementation MDClientAPI (Registration)

- (MDHTTPRequest *)getSmsCodeWithPhoneNumber:(NSString *)phoneNumber
									 success:(MDHTTPRequestSuccess)success
									 failure:(MDHTTPRequestFailure)failure
{
	NSString *URLString = MDRequestURLStringSendPassword;
	NSDictionary *paramsDict = @{
		MDUserGETParameterPhone : phoneNumber
	};
	return [self requestWithURLString:URLString
					HTTPRequestMethod:kSJGHTTPRequestMethodGet
						   parameters:paramsDict
							  success:success
							  failure:failure];

}

- (MDHTTPRequest *)loginWithSMSCode:(NSString *)smsCode
						phoneNumber:(NSString *)phoneNumber
							success:(MDHTTPRequestSuccess)success
							failure:(MDHTTPRequestFailure)failure
{


	NSString *URLString = MDRequestURLStringLoginWithSMS;
	NSDictionary *paramsDict = @{
		MDUserGETParameterPhone : phoneNumber,
		MDUserGETParameterSmsPassword : smsCode
	};

	return [self requestWithURLString:URLString
					HTTPRequestMethod:kSJGHTTPRequestMethodGet
						   parameters:paramsDict
							  success:success
							  failure:failure];
}

- (MDHTTPRequest *)registerUserWithData:(NSDictionary *)userData
								success:(MDHTTPRequestSuccess)success
								failure:(MDHTTPRequestFailure)failure
{
	NSString *URLString = [NSString stringWithFormat:MDRequestURLStringRegisterUser, [MDUserManager sharedManager].user.authTocken];

	return [self requestWithURLString:URLString
					HTTPRequestMethod:kSJGHTTPRequestMethodPost
						   parameters:userData
							  success:success
							  failure:failure];

}


@end
