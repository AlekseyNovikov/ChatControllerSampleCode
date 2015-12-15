//
//  MDIncomingChatTableViewCell.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 21/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDIncomingChatTableViewCell.h"
#import "MDChatInOutMessageViewModel.h"

#import "UIImage+MDBubbleImage.h"

@implementation MDIncomingChatTableViewCell

-(void)configureAppearance{
    [super configureAppearance];
    
    self.messageLabel.textColor = [UIColor chatInMessageTextColor];
}

- (void)_md_updateConstraintsForExpanded:(BOOL)isExpanded
{
    [super _md_updateConstraintsForExpanded:isExpanded];
    
    _leadingStatusLabelConstraint.constant = isExpanded ? -12 : 100;
    _topStatusLabelConstraint.constant = isExpanded ? 7 : -7;
   
}

@end
