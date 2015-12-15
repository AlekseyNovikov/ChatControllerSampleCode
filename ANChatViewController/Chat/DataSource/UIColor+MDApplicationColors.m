//
//  UIColor+MDApplicationColors.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 01/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "UIColor+MDApplicationColors.h"

#define RGBA(r, g, b, a) [UIColor colorWithRed: (r) / 255.0 green: (g) / 255.0 blue: (b) / 255.0 alpha: (a)]
#define RGB(r, g, b) [UIColor colorWithRed: (r) / 255.0 green: (g) / 255.0 blue: (b) / 255.0 alpha : 1]

@implementation UIColor (MDApplicationColors)

#pragma mark ChatViewController Colors

+ (UIColor *)chatVCGradientFirstColor
{
	return [UIColor colorWithRed:232.0 / 255.0 green:237.0 / 255.0 blue:207.0 / 255.0 alpha:1];
}
+ (UIColor *)chatVCGradientLastColor
{
	return [UIColor colorWithRed:179.0 / 255.0 green:239.0 / 255.0 blue:232.0 / 255.0 alpha:1];
}

+ (UIColor *)chatInputViewTopBorderColor
{
	return RGBA(44, 62, 70, 0.2);
}

+ (UIColor *)chatInMessageTextColor
{
	return [UIColor darkAppColor];
}
+ (UIColor *)chatOutMessageTextColor
{
	return [UIColor whiteColor];
}
+ (UIColor *)chatDateTimeTextColor
{
	return [[self darkAppColor] colorWithAlphaComponent:0.5];
}
+ (UIColor *)chatMessageStatusTextColor
{
	return [[self darkAppColor] colorWithAlphaComponent:0.5];
}
+ (UIColor *)keyboardColor
{
	return RGB(84, 88, 88);
}
+ (UIColor *)darkAppColor
{
	return RGB(44, 62, 70);
}
+ (UIColor *)navigationBarColor
{
	return RGB(142, 153, 149);
}
+ (UIColor *)transfluentNavigationBarColor
{
	return RGB(135, 147, 139);
}

+ (UIColor *)inputTextViewTintColor
{
	return RGB(0, 183, 179);
}
+ (UIColor *)invalidInputColor
{
	return RGB(255, 70, 87);
}
+ (UIColor *)buttonShadowColor
{
    return RGB(44, 62, 70);
}
+ (UIColor *)lightYellowColor
{
	return RGB(247, 255, 208);
}

@end
