//
//  UIView+MDBorders.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 28/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "UIView+MDBorders.h"

@implementation UIView (MDBorders)

+ (void)addTopBorderToView:(UIView *)view lineWidth:(CGFloat)width color:(UIColor *)color
{
	CALayer *topBorder = [CALayer layer];
	topBorder.borderColor = [color CGColor];
	topBorder.borderWidth = width;
	topBorder.frame = CGRectMake(0, -width, CGRectGetWidth(view.frame), width);

	[view.layer addSublayer:topBorder];
}

@end
