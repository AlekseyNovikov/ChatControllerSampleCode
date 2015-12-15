//
//  UIImage+ColorImage.h
//  MoiDoctor
//
//  Created by Roma Bakenbard on 08.10.15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorImage)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)tintImage:(UIImage *)image withColor:(UIColor *)color;

@end
