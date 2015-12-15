//
//  MDNetworkManager.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 16/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDNetworkManager.h"

static NSString * const baseApiURL = @"https://moidoc.com/api/";

static NSString *authTocken;

@interface MDNetworkManager ()

@property (nonatomic, strong, readwrite) MDClientAPI *clientAPI;

@end

@implementation MDNetworkManager

#pragma mark - Singleton
+ (MDNetworkManager *)sharedManager
{
	static MDNetworkManager *__networkManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
        __networkManager = [[MDNetworkManager alloc] init];
	});
	return __networkManager;
}

- (void)md_initialize
{
	NSURL *baseUrl = [NSURL URLWithString:baseApiURL];
	self.clientAPI = [[MDClientAPI alloc]initWithBaseURL:baseUrl];

}

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self md_initialize];
		[self md_configureClients];
	}
	return self;
}

- (void)md_configureClients
{
    self.clientAPI.responseSerializer = [AFJSONResponseSerializer serializer];
//    self.clientAPI.requestSerializer = [AFJSONRequestSerializer serializer];
}


@end
