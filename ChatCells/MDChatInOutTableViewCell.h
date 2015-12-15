//
//  MDChatInOutTableViewCell.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 25/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChatTableViewCell.h"
#import "MDChatInOutMessageViewModel.h"

@interface MDChatInOutTableViewCell : MDChatTableViewCell

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, assign) BOOL expanded;
@property (nonatomic, getter = isCellFirst) BOOL cellFirst;

@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundBoubleView;

///Constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBubleConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingBubleConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomBubleConstaint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingBubleConstraint;


//- (void)commonInit;
///protected
- (void)_md_updateConstraintsForExpanded:(BOOL)isExpanded;

- (void)configureAppearance;
- (void)md_addGestureRecognizer;

///Actions
- (void)tapOnMessage:(UIGestureRecognizer*)gestureRecognizer;


@end
