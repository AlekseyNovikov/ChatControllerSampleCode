//
//  NSObject+MDBlocks.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 03/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (MDBlocks)


- (void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay;


@end
