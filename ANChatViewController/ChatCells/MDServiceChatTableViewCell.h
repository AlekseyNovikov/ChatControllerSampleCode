//
//  MDServiceChatTableViewCell.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 21/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChatTableViewCell.h"


@interface MDServiceChatTableViewCell : MDChatTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *serviceMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *linkLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomSeparator;
@end
