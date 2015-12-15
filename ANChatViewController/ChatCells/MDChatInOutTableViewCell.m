//
//  MDChatInOutTableViewCell.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 25/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChatInOutTableViewCell.h"
#import "NSString+YMTSizeCalculation.h"


///BubleOffset
static const CGFloat topBubleOffset = 7.f;
static const CGFloat leftBubleOffset = 12.f;
static const CGFloat rightBubleOffset = 12.f;
static const CGFloat bottomBubleOffset = 9.f;

static const CGFloat topBubleMargin = 12.f;
static const CGFloat notFirstTopBubleMargin = 4.f;
static const CGFloat expandedTopBubleMargin = 33.f;

static const CGFloat bottomBubleMargin = 0.f;
static const CGFloat expandedBottomBubleMargin = 22.f;

static const CGFloat leadingBubleMargin = 8.f;
static const CGFloat trailingBubleMargin = 45.f;


/**
 *  Base class for Incoming and Outgoing messages
 */
@implementation MDChatInOutTableViewCell

#pragma mark Class Methods
+ (CGFloat)cellHeightForViewModel:(MDChatViewModel *)viewModel availableWidth:(CGFloat)availableWidth
{
	CGFloat actualAvailableWidth = availableWidth - leadingBubleMargin - trailingBubleMargin - leftBubleOffset - rightBubleOffset - 2;

	CGFloat mainTextHeight = ({
		UIFont *font = [UIFont chatMessageTextFont];
		[viewModel.messageText ymt_sizeWithFont:font forWidth:actualAvailableWidth lineBreakMode:NSLineBreakByWordWrapping].height;
	});

	if (viewModel.isMessageWithImage) {
		mainTextHeight = 178.f;
	}

	CGFloat cellHeight = mainTextHeight + topBubleOffset + bottomBubleOffset;
	if (viewModel.expanded) {
		return cellHeight + expandedTopBubleMargin + expandedBottomBubleMargin;
	}
	CGFloat topMargin = viewModel.isCellFirst ? topBubleMargin : notFirstTopBubleMargin;
//    if (viewModel.positionType != MDChatViewModelMessagePositionTypeTop) {
//        topMargin = notFirstTopBubleMargin;
//    }
	return cellHeight + topMargin + bottomBubleMargin;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self
															 action:@selector(tapOnMessage:)];
	self.tapGesture.delegate = self;
	[self md_addGestureRecognizer];
	[self configureAppearance];

}

- (void)md_addGestureRecognizer
{
	[self.backgroundBoubleView setUserInteractionEnabled:YES];
	[self.backgroundBoubleView addGestureRecognizer:self.tapGesture];
}

///protected
- (void)_md_updateConstraintsForExpanded:(BOOL)isExpanded
{
	self.leadingBubleConstraint.constant = leadingBubleMargin;
	self.trailingBubleConstraint.constant = trailingBubleMargin;

	//vertical constraint
//    CGFloat topMargin = self.isCellFirst ? topBubleMargin : notFirstTopBubleMargin;
	CGFloat topMargin = self.isCellFirst ? topBubleMargin : notFirstTopBubleMargin;

	self.topBubleConstraint.constant = isExpanded ? expandedTopBubleMargin : topMargin;
	self.bottomBubleConstaint.constant = isExpanded ? expandedBottomBubleMargin : bottomBubleMargin;

	//animate aditional constraint in child class

}

- (void)configureCellWithViewModel:(MDChatInOutMessageViewModel *)viewModel
				  updateAppearance:(BOOL)isUpdateAppearance

{
	[super configureCellWithViewModel:viewModel updateAppearance:isUpdateAppearance];

	self.messageLabel.text = viewModel.messageText;
	self.dateTimeLabel.text = viewModel.dateTimeText;
	self.expanded = viewModel.expanded;
	self.cellFirst = viewModel.isCellFirst;

	self.backgroundBoubleView.image = [UIImage bubbleImageForCellType:viewModel.message.type
														 positionType:viewModel.positionType
															 selected:self.expanded];


	if (isUpdateAppearance == YES) {
		[self updateAppearanceWithAnimated:NO];
	}

}

- (void)configureAppearance
{
	self.dateTimeLabel.font = [UIFont chatDateTimeTextFont];
	self.dateTimeLabel.textColor = [UIColor chatDateTimeTextColor];
	self.dateTimeLabel.text = self.dateTimeLabel.text.uppercaseString;

	self.statusLabel.font = [UIFont chatMessageStatusTextFont];
	self.statusLabel.textColor = [UIColor chatMessageStatusTextColor];

	self.messageLabel.font = [UIFont chatMessageTextFont];
}

- (void)updateAppearanceWithAnimated:(BOOL)animated
{
	BOOL isExpanded = self.expanded;
	void (^AnimateBlock)(void) = ^(void) {
		_dateTimeLabel.alpha = isExpanded ? 1.0 : 0.f;
		_statusLabel.alpha =   isExpanded ? 1.0 : 0.f;
	};

	if (animated) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

		[self _md_updateConstraintsForExpanded:isExpanded];

		[UIView animateWithDuration:0.3
						 animations:^{
			 AnimateBlock();
			 [self layoutIfNeeded];
		 }
						 completion:nil];
//        });
	} else {
		[self _md_updateConstraintsForExpanded:isExpanded];
		AnimateBlock();
	}
}

#pragma mark Actions
- (void)tapOnMessage:(UIGestureRecognizer*)gestureRecognizer
{
	if (self.expandableDelegate && [self.expandableDelegate respondsToSelector:@selector(chatTableViewCellShouldExpand:)]) {
		if ([self.expandableDelegate chatTableViewCellShouldExpand:self]) {
			if ([self.expandableDelegate respondsToSelector:@selector(chatTableViewCell:didExpanded:)]) {

				self.expanded = !self.expanded;

				[self updateAppearanceWithAnimated:YES];
				[self.expandableDelegate chatTableViewCell:self didExpanded:self.expanded];
			}
		}
	}
}

@end
