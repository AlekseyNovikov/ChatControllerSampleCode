//
//  MDChatTableViewCell.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 21/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDChatViewModel.h"
#import "ExpandableCellDelegate.h"

#import "NSString+YMTSizeCalculation.h"

@interface MDChatTableViewCell : UITableViewCell <UIGestureRecognizerDelegate>

@property (nonatomic, weak) id<ExpandableCellDelegate> expandableDelegate;

@property (nonatomic, strong) MDChatViewModel *viewModel;

+ (CGFloat)heightForCellWithViewModel:(MDChatViewModel *)viewModel;

+ (CGFloat)cellHeightForViewModel:(MDChatViewModel *)viewModel
				   availableWidth:(CGFloat)availableWidth;


- (void)configureCellWithViewModel:(MDChatViewModel *)viewModel;
- (void)configureCellWithViewModel:(MDChatViewModel *)viewModel
				  updateAppearance:(BOOL)isUpdateAppearance;

- (void)updateAppearanceWithAnimated:(BOOL)animated;


+ (UINib *)nib;

+ (NSString *)cellReuseIdentifier;


@end

