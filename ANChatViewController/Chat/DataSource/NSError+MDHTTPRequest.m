//
//  NSError+MDHTTPRequest.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 26/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "NSError+MDHTTPRequest.h"

NSString *const MDHTTPRequestErrorDomain = @"com.moidoctor.error.request";

@implementation NSError (MDHTTPRequest)

+(NSError *)md_errorWithCode:(NSInteger)code userInfo:(NSDictionary *)userInfo
{
    return [[NSError alloc] initWithDomain:MDHTTPRequestErrorDomain
                                      code:code
                                  userInfo:userInfo];
}

+(NSError *)md_errorWithCode:(NSInteger)code message:(NSString *)errorMessage
{
    NSDictionary *userInfo = nil;
    if (errorMessage != nil) userInfo = @{NSLocalizedDescriptionKey : errorMessage};
    return [self md_errorWithCode:code userInfo:userInfo];
}

+ (NSError *)md_errorFromJSONDictionary:(NSDictionary *)JSONDictionary
{
    NSDictionary *userInfo = nil;
    NSInteger code = [JSONDictionary[MDResponceJSONKeySuccess] integerValue];
    NSString *message = [JSONDictionary[MDResponceJSONKeyMessage] stringValue];
    if (message != nil) userInfo = @{NSLocalizedDescriptionKey : message};
    return [self md_errorWithCode:code userInfo:userInfo];
}

@end
