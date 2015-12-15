//
//  MDNetworkManager.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 16/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDClientAPI.h"

@class MDNetworkManager;
@protocol MDNetworkManagerDelegate <NSObject>

//new message exsist

@end

@interface MDNetworkManager : NSObject

@property (weak, nonatomic) id<MDNetworkManagerDelegate> delegate;

@property (nonatomic, strong, readonly) MDClientAPI *clientAPI;

+ (MDNetworkManager *)sharedManager;

@end
