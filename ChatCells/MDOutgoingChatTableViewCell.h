//
//  MDOutgoingChatTableViewCell.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 21/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChatTableViewCell.h"
#import "MDChatInOutTableViewCell.h"


@interface MDOutgoingChatTableViewCell : MDChatInOutTableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingStatusLabelConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topStatusLabelConstraint;



@end
