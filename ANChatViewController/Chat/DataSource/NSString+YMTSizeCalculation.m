//
//  NSString+YMTSizeCalculation.m
//  YandexMarket
//
//  Created by Dmitry Nesterenko on 29.09.14.
//  Copyright (c) 2014 e-legion. All rights reserved.
//

#import "NSString+YMTSizeCalculation.h"

static CGSize ymt_size_raised_to_nearest_integer(CGSize size)
{
	CGFloat width = CGFLOAT_IS_DOUBLE ? ceil(size.width) : ceilf(size.width);
	CGFloat height = CGFLOAT_IS_DOUBLE ? ceil(size.height) : ceilf(size.height);
	return CGSizeMake(width, height);
}

@implementation NSString (YMTSizeCalculation)

- (CGSize)ymt_sizeWithFont:(UIFont *)font
{
	NSMutableDictionary *attributes = [NSMutableDictionary new];
	if (font)
		attributes[NSFontAttributeName] = font;

	CGSize size = [self sizeWithAttributes:attributes];
	return ymt_size_raised_to_nearest_integer(size);
}

- (CGSize)ymt_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode
{
	return [self ymt_sizeWithFont:font constrainedToSize:CGSizeMake(width, 0.0) lineBreakMode:lineBreakMode];
}

- (CGSize)ymt_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
	NSMutableDictionary *attributes = [NSMutableDictionary new];

	// font
	if (font)
		attributes[NSFontAttributeName] = font;

	// linebreak mode
	NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
	paragraphStyle.lineBreakMode = lineBreakMode;
	attributes[NSParagraphStyleAttributeName] = paragraphStyle;

	CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
	return ymt_size_raised_to_nearest_integer(rect.size);
}

@end
