//
//  MDClientAPI+Chat.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 20/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDClientAPI.h"

static NSString *const MDRequestURLStringGETMessages = @"messages";
static NSString *const MDRequestURLStringPOSTSendMessage = @"sendMessage?auth_key=%@";

static NSString *const TempAuthTocken = @"LrBm4ChJldmnQrYrPKLxozH5W08WOQz2";

@implementation MDClientAPI (Chat)

- (MDHTTPRequest *)getMessagesStarted:(NSInteger)lastMessageID
							  success:(MDHTTPRequestSuccess)success
							  failure:(MDHTTPRequestFailure)failure
{
	NSDictionary *paramsDict = @{
		MDUserGETParameterToken : [MDUserManager sharedManager].user.authTocken /*TempAuthTocken*/,
		MDChatGETParameterPrevMessageID : @(lastMessageID)
	};
	return [self requestWithURLString:MDRequestURLStringGETMessages
					HTTPRequestMethod:kSJGHTTPRequestMethodGet
						   parameters:paramsDict
							  success:success
							  failure:failure];
}

- (MDHTTPRequest *)getMessagesStarted:(NSInteger)lastMessageID
								count:(NSInteger)countOfMessages
							  success:(MDHTTPRequestSuccess)success
							  failure:(MDHTTPRequestFailure)failure
{
	NSMutableDictionary *paramsDict = [@{
										   MDUserGETParameterToken : [MDUserManager sharedManager].user.authTocken /*TempAuthTocken*/,
										   MDChatGETParameterPrevMessageID : @(lastMessageID),
										   MDChatGETParameterMessagesCount : @(countOfMessages)
									   } mutableCopy];
	if (lastMessageID == 0) {
		[paramsDict removeObjectForKey:MDChatGETParameterPrevMessageID];
	}
	if (countOfMessages < 0) {
		[paramsDict removeObjectForKey:MDChatGETParameterMessagesCount];
	}
	return [self requestWithURLString:MDRequestURLStringGETMessages
					HTTPRequestMethod:kSJGHTTPRequestMethodGet
						   parameters:paramsDict
							  success:success
							  failure:failure];
}

- (MDHTTPRequest *)sendMessage:(NSDictionary *)messageDict
					   success:(MDHTTPRequestSuccess)success
					   failure:(MDHTTPRequestFailure)failure
{
	NSString *URLString = [NSString stringWithFormat:MDRequestURLStringPOSTSendMessage, [MDUserManager sharedManager].user.authTocken/*TempAuthTocken*/];
	return [self requestWithURLString:URLString
					HTTPRequestMethod:kSJGHTTPRequestMethodPost
						   parameters:messageDict
							  success:success
							  failure:failure];
}
@end
