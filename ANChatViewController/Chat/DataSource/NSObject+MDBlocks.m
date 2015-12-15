//
//  NSObject+MDBlocks.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 03/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "NSObject+MDBlocks.h"

@implementation NSObject (MDBlocks)

- (void)performBlock:(void (^)())block
{
    block();
}

- (void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay
{
    void (^block_)() = [block copy];
    [self performSelector:@selector(performBlock:) withObject:block_ afterDelay:delay];
}

@end
