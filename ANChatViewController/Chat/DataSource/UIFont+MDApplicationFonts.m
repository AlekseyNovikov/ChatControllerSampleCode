//
//  UIFont+MDApplicationFonts.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 01/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "UIFont+MDApplicationFonts.h"

@implementation UIFont (MDApplicationFonts)

#pragma mark ChatViewController Fonts
+ (UIFont *)chatMessageTextFont
{
	return [UIFont fontWithName:@"AvenirNext-Regular" size:16];
}

+ (UIFont *)chatLinkTextFont
{
	return [UIFont fontWithName:@"AvenirNext-DemiBold" size:16];
}

+ (UIFont *)chatDateTimeTextFont
{
	return [UIFont fontWithName:@"AvenirNext-Medium" size:11];
}

+ (UIFont *)chatMessageStatusTextFont
{
	return [UIFont fontWithName:@"AvenirNext-Medium" size:11];
}


+ (UIFont *)inputMessageTextFont
{
	return [UIFont fontWithName:@"AvenirNext-Regular" size:14];

}

+ (UIFont *)navigationBarFont
{
	return [UIFont fontWithName:@"AvenirNext-Medium" size:18];
}

+ (UIFont *)navigationBarButtonFont
{
	return [UIFont fontWithName:@"AvenirNext-Regular" size:16];
}

+ (UIFont *)recommendationFont
{
	return [UIFont fontWithName:@"AvenirNext-Medium" size:16];
}
@end
