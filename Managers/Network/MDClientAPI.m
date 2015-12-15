//
//  MDClientAPI.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 17/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDClientAPI.h"
#import "SJGHTTPRequestManager.protected.h"

#import "NSError+MDHTTPRequest.h"

#import "MDHTTPRequest.h"

@implementation MDClientAPI


#pragma mark - Override
+ (Class)HTTPRequestClass
{
	return [MDHTTPRequest class];
}

// Base
- (MDHTTPRequest *)requestWithURLString:(NSString *)URLString
					  HTTPRequestMethod:(SJGHTTPRequestMethod)HTTPRequestMethod
							 parameters:(id)parameters
			  constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
							  autoStart:(BOOL)autoStart
								success:(MDHTTPRequestSuccess)success
								failure:(MDHTTPRequestFailure)failure
{
	MDHTTPRequest *request = (MDHTTPRequest*)[super requestWithURLString:URLString
													   HTTPRequestMethod:HTTPRequestMethod
															  parameters:parameters
											   constructingBodyWithBlock:block
															   autoStart:NO
																 success:^(SJGHTTPRequest *request, id responseObject) {
												  if ([responseObject[@"success"] integerValue] > 0) {
													  request.errorAPI = [NSError md_errorWithCode:[responseObject[@"success"] integerValue] message:responseObject[@"message"]];
												  }
												  if (success != nil) success((MDHTTPRequest*)request, responseObject);
											  } failure:^(SJGHTTPRequest *request, NSError *error) {
												  if (failure != nil) failure((MDHTTPRequest*)request, error);
											  }];
	if (autoStart) [request start];
	return request;
}

- (MDHTTPRequest *)requestWithURLString:(NSString *)URLString
					  HTTPRequestMethod:(SJGHTTPRequestMethod)HTTPRequestMethod
							 parameters:(id)parameters
							  autoStart:(BOOL)autoStart
								success:(MDHTTPRequestSuccess)success
								failure:(MDHTTPRequestFailure)failure
{
	return (MDHTTPRequest*)[super requestWithURLString:URLString
									 HTTPRequestMethod:HTTPRequestMethod
											parameters:parameters
											 autoStart:autoStart
											   success:(SJGHHTTPRequestSuccess)success
											   failure:(SJGHHTTPRequestFailure)failure];
}

- (MDHTTPRequest *)requestWithURLString:(NSString *)URLString
					  HTTPRequestMethod:(SJGHTTPRequestMethod)HTTPRequestMethod
							 parameters:(id)parameters
								success:(MDHTTPRequestSuccess)success
								failure:(MDHTTPRequestFailure)failure
{
	return (MDHTTPRequest*)[super requestWithURLString:URLString
									 HTTPRequestMethod:HTTPRequestMethod
											parameters:parameters
											   success:(SJGHHTTPRequestSuccess)success
											   failure:(SJGHHTTPRequestFailure)failure];
}

@end
