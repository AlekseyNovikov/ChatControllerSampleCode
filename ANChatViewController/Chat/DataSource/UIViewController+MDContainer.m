//
//  UIViewController+MDContainer.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 23/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "UIViewController+MDContainer.h"

@implementation UIViewController (MDContainer)
- (void)displayContentController:(UIViewController*)content inContainer:(UIView *)container
{
    [self addChildViewController:content];
    [self.view addSubview:content.view];
    [content didMoveToParentViewController:self];
}
@end
