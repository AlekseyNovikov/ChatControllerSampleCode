//
//  MDModelManager.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 03/12/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDModelManager.h"

@implementation MDModelManager

#pragma mark - Singleton

+ (MDModelManager *)sharedManager
{
	static MDModelManager *__sharedManager = nil;
	static dispatch_once_t onceTocken;
	dispatch_once(&onceTocken, ^{
		__sharedManager = [[MDModelManager alloc] init];
	});
	return __sharedManager;
}


#pragma mark - Public

+ (dispatch_queue_t)modelOperationsQueue
{
	static dispatch_queue_t __modelOperationQueue = NULL;
	if (__modelOperationQueue == NULL) {
		__modelOperationQueue = dispatch_queue_create("com.moidoc.mdmodel.operationsqueue", NULL);
	}
	return __modelOperationQueue;
}

+ (void)performModelOperation:(void (^)(void))operationBlock
				   completion:(void (^)(void))completionBlock
{
	dispatch_async([self modelOperationsQueue], ^{
		if (operationBlock != nil) operationBlock();
		if (completionBlock != nil) [NSThread sjg_performBlockInMainThread:completionBlock];
	});
}

- (void)performModelOperation:(void (^)(void))operationBlock
				   completion:(void (^)(void))completionBlock
{
	[self.class performModelOperation:operationBlock
						   completion:completionBlock];
}
@end
