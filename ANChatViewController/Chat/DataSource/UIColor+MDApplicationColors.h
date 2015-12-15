//
//  UIColor+MDApplicationColors.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 01/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MDApplicationColors)

+ (UIColor *)chatVCGradientFirstColor;
+ (UIColor *)chatVCGradientLastColor;

+ (UIColor *)chatInputViewTopBorderColor;

+ (UIColor *)chatInMessageTextColor;
+ (UIColor *)chatOutMessageTextColor;
+ (UIColor *)chatDateTimeTextColor;
+ (UIColor *)chatMessageStatusTextColor;

+ (UIColor *)inputTextViewTintColor;
+ (UIColor *)invalidInputColor;

+ (UIColor *)buttonShadowColor;

+ (UIColor *)lightYellowColor;

+ (UIColor *)keyboardColor;
+ (UIColor *)darkAppColor;
+ (UIColor *)transfluentNavigationBarColor;
+ (UIColor *)navigationBarColor;


@end
