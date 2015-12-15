//
//  MDImageChatTableViewCell.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 11/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDImageChatTableViewCell.h"
//#import "UIImageView+SJGWebImage.h"

@implementation MDImageChatTableViewCell


- (void)configureCellWithViewModel:(MDChatViewModel *)viewModel updateAppearance:(BOOL)isUpdateAppearance
{
	[super configureCellWithViewModel:viewModel updateAppearance:isUpdateAppearance];

	if (viewModel.image) {
		self.attachmentImageView.image = viewModel.image;
	} else {
		NSString *fullImageURLString = [NSString stringWithFormat:@"https://moidoc.com/%@", viewModel.message.imageURL];
		NSURL *imageURL = [NSURL URLWithString:fullImageURLString];
//		[self.attachmentImageView sjg_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"out-image-msg-bubble-placeholder" ] delay:0];
	}

	self.expanded = viewModel.expanded;
	self.cellFirst = viewModel.isCellFirst;

	if (isUpdateAppearance == YES) {
		[self updateAppearanceWithAnimated:NO];
	}
}

- (void)configureAppearance
{
	[super configureAppearance];
	self.attachmentImageView.layer.cornerRadius = 4.f;

}

- (void)md_addGestureRecognizer
{
	[self.attachmentImageView setUserInteractionEnabled:YES];
	UITapGestureRecognizer *tapPhotoGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self
																							   action:@selector(photoTapped:)];
	[self.attachmentImageView addGestureRecognizer:tapPhotoGestureRecognizer];
}

- (void)_md_updateConstraintsForExpanded:(BOOL)isExpanded
{
	[super _md_updateConstraintsForExpanded:isExpanded];

	_trailingStatusLabelConstraint.constant = isExpanded ? -12 : 100;
	_topStatusLabelConstraint.constant = isExpanded ? 7 : -7;

}

- (IBAction)photoTapped:(id)sender
{
	MDFullScreenPhoto *photo = [[MDFullScreenPhoto alloc] init];
	photo.image = self.attachmentImageView.image;

	[self.delegate imagechatCell:self didTappedPhoto:photo];
}

#pragma mark - NYTPhotosViewControllerDelegate
- (UIView *)photosViewController:(NYTPhotosViewController *)photosViewController referenceViewForPhoto:(id <NYTPhoto>)photo
{

	return self.attachmentImageView;
}

- (void)photosViewControllerWillDismiss:(NYTPhotosViewController *)photosViewController
{
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
}
/*
   // Only override drawRect: if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   - (void)drawRect:(CGRect)rect {
    // Drawing code
   }
 */

@end
