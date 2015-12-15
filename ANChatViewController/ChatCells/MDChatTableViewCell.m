//
//  MDChatTableViewCell.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 21/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChatTableViewCell.h"

@implementation MDChatTableViewCell

- (void)configureCellWithViewModel:(MDChatViewModel *)viewModel
{
    [self configureCellWithViewModel:viewModel updateAppearance:YES];
}

-(void)configureCellWithViewModel:(MDChatViewModel *)viewModel
                 updateAppearance:(BOOL)isUpdateAppearance
{
}

- (void)updateAppearanceWithAnimated:(BOOL)animated
{
}


+ (CGFloat)cellHeightForViewModel:(MDChatViewModel *)viewModel
                   availableWidth:(CGFloat)availableWidth{
    return 40.f;
}


+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle bundleForClass:[self class]]];
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([self class]);
}

@end
