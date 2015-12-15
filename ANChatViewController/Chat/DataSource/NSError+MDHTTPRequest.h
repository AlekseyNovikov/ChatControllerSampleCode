//
//  NSError+MDHTTPRequest.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 26/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "NSError+SJGHTTPRequest.h"

extern NSString *const MDHTTPrequestErrorDomain;

typedef NS_ENUM (NSInteger, MDHTTPRequestError)
{
	MDHTTPRequestErrorLocation = 1,
	MDHTTPRequestErrorSmsServer = 2,
	MDHTTPRequestErrorUnknown = 3,
};

@interface NSError (MDHTTPRequest)

+ (NSError *)md_errorWithCode:(NSInteger)code userInfo:(NSDictionary *)userInfo;
+ (NSError *)md_errorWithCode:(NSInteger)code message:(NSString *)errorMessage;
+ (NSError *)md_errorFromJSONDictionary:(NSDictionary *)JSONDictionary;

@end
