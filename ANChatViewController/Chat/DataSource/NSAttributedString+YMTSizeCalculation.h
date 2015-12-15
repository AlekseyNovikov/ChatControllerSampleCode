//
//  NSAttributedString+NTVSizeCalculation.h
//  ntv-ios-2
//
//  Created by Николай Довгань on 23/08/15.
//  Copyright (c) 2015 NTV. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSAttributedString (YMTSizeCalculation)

- (CGSize)ymt_sizeForWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)ymt_sizeConstrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end
