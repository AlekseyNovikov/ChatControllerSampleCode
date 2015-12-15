//
//  NSAttributedString+NTVSizeCalculation.m
//  ntv-ios-2
//
//  Created by Николай Довгань on 23/08/15.
//  Copyright (c) 2015 NTV. All rights reserved.
//

#import "NSAttributedString+YMTSizeCalculation.h"

static CGSize ymt_size_raised_to_nearest_integer(CGSize size)
{
	CGFloat width = CGFLOAT_IS_DOUBLE ? ceil(size.width) : ceilf(size.width);
	CGFloat height = CGFLOAT_IS_DOUBLE ? ceil(size.height) : ceilf(size.height);
	return CGSizeMake(width, height);
}

@implementation NSAttributedString (YMTSizeCalculation)

- (CGSize)ymt_sizeForWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode
{
	return [self ymt_sizeConstrainedToSize:CGSizeMake(width, 0.0) lineBreakMode:lineBreakMode];
}

- (CGSize)ymt_sizeConstrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
	CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
	return ymt_size_raised_to_nearest_integer(rect.size);
}

@end
