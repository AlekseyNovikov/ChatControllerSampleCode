//
//  MDOutgoingChatTableViewCell.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 21/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDOutgoingChatTableViewCell.h"
#import "MDChatInOutMessageViewModel.h"
#import "UIImage+MDBubbleImage.h"

@implementation MDOutgoingChatTableViewCell

-(void)configureAppearance{
    [super configureAppearance];
    
    self.messageLabel.textColor = [UIColor chatOutMessageTextColor];
}

- (void)_md_updateConstraintsForExpanded:(BOOL)isExpanded
{
    [super _md_updateConstraintsForExpanded:isExpanded];
    
    _trailingStatusLabelConstraint.constant = isExpanded ? -12 : 100;
    _topStatusLabelConstraint.constant = isExpanded ? 7 : -7;

}

@end
