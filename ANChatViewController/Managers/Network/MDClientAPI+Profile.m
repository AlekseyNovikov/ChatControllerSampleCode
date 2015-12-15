//
//  MDClientAPI+Profile.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 23/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDClientAPI.h"

static NSString *const MDRequestURLStringGETUserProfile = @"userProfile";
static NSString *const MDRequestURLStringPOSTUserProfile = @"userProfile?auth_key=%@";



@implementation MDClientAPI (Profile)

- (MDHTTPRequest *)getUserProfileData:(MDHTTPRequestSuccess)success
							  failure:(MDHTTPRequestFailure)failure
{
    NSDictionary *paramsDict = @{
        MDUserGETParameterToken : [MDUserManager sharedManager].user.authTocken
    };
	return [self requestWithURLString:MDRequestURLStringGETUserProfile
					HTTPRequestMethod:kSJGHTTPRequestMethodGet
						   parameters:paramsDict
							  success:success
							  failure:failure];
}

- (MDHTTPRequest *)updateUserProfileWithData:(NSDictionary *)userData
									 success:(MDHTTPRequestSuccess)success
									 failure:(MDHTTPRequestFailure)failure
{
	NSString *URLString = [NSString stringWithFormat:MDRequestURLStringPOSTUserProfile, [MDUserManager sharedManager].user.authTocken];

	return [self requestWithURLString:URLString
					HTTPRequestMethod:kSJGHTTPRequestMethodPost
						   parameters:userData
							  success:success
							  failure:failure];
}

@end
