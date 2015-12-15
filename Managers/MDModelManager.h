//
//  MDModelManager.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 03/12/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDModelManager : NSObject

+ (MDModelManager *)sharedManager;

+ (dispatch_queue_t)modelOperationsQueue;

+ (void)performModelOperation:(void(^)(void))operationBlock
                  completion:(void(^)(void))completionBlock;

- (void)performModelOperation:(void(^)(void))operationBlock
                   completion:(void(^)(void))completionBlock;
@end
