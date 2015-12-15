//
//  UIView+MDBorders.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 28/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MDBorders)

+ (void)addTopBorderToView:(UIView *)view lineWidth:(CGFloat)width color:(UIColor *)color;

@end
