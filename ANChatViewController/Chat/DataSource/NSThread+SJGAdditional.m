//
//  NSThread+SJGAdditional.m
//  ShowJet
//
//  Created by Vladimir Ryazanov on 27/03/15.
//  Copyright (c) 2015 Boloid. All rights reserved.
//

#import "NSThread+SJGAdditional.h"

@implementation NSThread (SJGAdditional)

+ (void)sjg_performBlockInMainThread:(void(^)(void))block
{
    if ([self isMainThread]) {
        if (block != nil) block();
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block != nil) block();
        });
    }
}

@end
