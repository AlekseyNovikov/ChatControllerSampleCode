//
//  UIImage+MDBubbleImage.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 28/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDChatViewModelFactory.h"

@interface UIImage (MDBubbleImage)

+ (UIImage *)bubbleImageForCellType:(MDMessageType)type
					   positionType:(MDChatViewModelMessagePositionType)positionType
						   selected:(BOOL)isSelected;

+ (UIImage *)roundedWhiteImageWithShadow;

+ (UIImage *)buttonBackground;
+ (UIImage *)buttonBackgroundSelected;

//+(UIImage *)imageForIncomingCellWithPositionType:(MDChatViewModelMessagePositionType) positionType;
//+(UIImage *)imageForOutgoingCellWithPositionType:(MDChatViewModelMessagePositionType) positionType;

@end
