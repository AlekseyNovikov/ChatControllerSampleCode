//
//  MDServiceChatTableViewCell.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 21/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDServiceChatTableViewCell.h"
#import "MDChatServiceMessagesViewModel.h"

static const CGFloat horisontalOffset = 8.f;
static const CGFloat verticalOffset = 25.f;

@interface MDServiceChatTableViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *linkViewHC;

@property (assign, nonatomic) BOOL withLink;

@end

@implementation MDServiceChatTableViewCell
#pragma mark Class Methods
+ (CGFloat)cellHeightForViewModel:(MDChatServiceMessagesViewModel *)viewModel availableWidth:(CGFloat)availableWidth
{
	CGFloat actualAvailableWidth = availableWidth - 2 * horisontalOffset;

	CGFloat cellHeight;
	CGFloat mainTextHeight = ({
		UIFont *font = [UIFont chatMessageTextFont];
		[viewModel.messageText ymt_sizeWithFont:font forWidth:actualAvailableWidth lineBreakMode:NSLineBreakByWordWrapping].height;
	});
	cellHeight = mainTextHeight;
	if (viewModel.linkText) {
		CGFloat linkTextHeight = ({
			UIFont *font = [UIFont chatLinkTextFont];
			[viewModel.linkText ymt_sizeWithFont:font forWidth:actualAvailableWidth lineBreakMode:NSLineBreakByWordWrapping].height;
		});
		cellHeight += linkTextHeight + 10.f;
	}

	return cellHeight + 2 * verticalOffset;
}

- (void)updateConstraints
{
	if (!self.withLink) {
		self.linkViewHC.constant = 0;
	}
	[super updateConstraints];
}


- (void)configureCellWithViewModel:(MDChatServiceMessagesViewModel *)viewModel
{
	self.serviceMessageLabel.text = viewModel.messageText;
	if (viewModel.linkText) {
		self.linkLabel.text = viewModel.linkText;
		self.withLink = YES;
	}
	[self setNeedsUpdateConstraints];
	[super configureCellWithViewModel:viewModel];
}

- (void)prepareForReuse
{
	self.textLabel.text = nil;
	self.linkLabel.text = nil;
}
/*
   // Only override drawRect: if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   - (void)drawRect:(CGRect)rect {
    // Drawing code
   }
 */

@end
