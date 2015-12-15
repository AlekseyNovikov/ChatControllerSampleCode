//
//  MDIncomingChatTableViewCell.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 21/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChatTableViewCell.h"
#import "MDChatInOuttableViewCell.h"

@interface MDIncomingChatTableViewCell : MDChatInOutTableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingStatusLabelConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topStatusLabelConstraint;

@end
