//
//  NSString+YMTSizeCalculation.h
//  YandexMarket
//
//  Created by Dmitry Nesterenko on 29.09.14.
//  Copyright (c) 2014 e-legion. All rights reserved.
//

@interface NSString (YMTSizeCalculation)

- (CGSize)ymt_sizeWithFont:(UIFont *)font;
- (CGSize)ymt_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)ymt_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end
