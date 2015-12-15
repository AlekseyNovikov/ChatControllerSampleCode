//
//  UIFont+MDApplicationFonts.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 01/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (MDApplicationFonts)

+ (UIFont *)chatMessageTextFont;
+ (UIFont *)chatLinkTextFont;
+ (UIFont *)chatDateTimeTextFont;
+ (UIFont *)chatMessageStatusTextFont;

+ (UIFont *)inputMessageTextFont;

+ (UIFont *)navigationBarFont;
+ (UIFont *)navigationBarButtonFont;
+ (UIFont *)recommendationFont;

@end
