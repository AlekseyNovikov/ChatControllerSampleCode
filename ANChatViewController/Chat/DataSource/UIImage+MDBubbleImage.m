//
//  UIImage+MDBubbleImage.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 28/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "UIImage+MDBubbleImage.h"


@implementation UIImage (MDBubbleImage)

+ (UIImage *)bubbleImageForCellType:(MDMessageType)type
					   positionType:(MDChatViewModelMessagePositionType)positionType
						   selected:(BOOL)isSelected
{
	NSMutableString *baseBubbleName;
	if (type == MDMessageTypeIncoming) {
		baseBubbleName  = [@"in-msg-bubble-" mutableCopy];
	} else if (type == MDMessageTypeOutgoing) {
		baseBubbleName = [@"out-msg-bubble-" mutableCopy];
	}

	if (isSelected) {
		[baseBubbleName appendString:@"selected-"];
	}

	NSString *imageSuffix;
	switch (positionType) {
		case MDChatViewModelMessagePositionTypeTop:
			imageSuffix = @"top";
			break;
		case MDChatViewModelMessagePositionTypeMidle:
			imageSuffix = @"midle";
			break;
		case MDChatViewModelMessagePositionTypeBottom:
			imageSuffix = @"bottom";
		case MDChatViewModelMessagePositionTypeNone:
			break;
	}

	[baseBubbleName appendString:imageSuffix];

	return [UIImage imageNamed:baseBubbleName];
}

+ (UIImage *)roundedWhiteImageWithShadow
{
	return [[UIImage imageNamed:@"rounded_background_with_shadow"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
}

+ (UIImage *)buttonBackground
{
	return [[UIImage imageNamed:@"button"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
}

+ (UIImage *)buttonBackgroundSelected
{
	return [[UIImage imageNamed:@"button_pressed"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
}

@end
