//
//  MDRegistrationDoneInputView.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 02/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDRegistrationDoneInputView.h"
@interface MDRegistrationDoneInputView ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundGradient;

@end


@implementation MDRegistrationDoneInputView

- (void)awakeFromNib
{
	[super awakeFromNib];
	[self md_commonInit];
	[self setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
}

- (void)md_commonInit
{
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self md_configureButton];

	self.backgroundGradient.alpha = 0.f;

	[self.doneButton addTarget:self
						action:@selector(doneButtonPressed:)
			  forControlEvents:UIControlEventTouchUpInside];

}

- (void)md_configureButton
{
	self.doneButton.layer.cornerRadius = 4;
	self.doneButton.layer.borderWidth = 1;
	self.doneButton.layer.borderColor = [UIColor chatInputViewTopBorderColor].CGColor;

	self.doneButton.layer.shadowColor = [UIColor buttonShadowColor].CGColor;
	self.doneButton.layer.shadowOffset = CGSizeMake(0, 1.0);
	self.doneButton.layer.shadowOpacity = 1.0;
	self.doneButton.layer.shadowRadius = 0.0;
}

- (void)setBackgroundAlpha:(CGFloat)backgroundAlpha
{
	if (_backgroundAlpha == backgroundAlpha) {
		return;
	}
	self.backgroundGradient.alpha = backgroundAlpha;
	_backgroundAlpha = backgroundAlpha;
}

- (CGSize)intrinsicContentSize
{
	return CGSizeMake(UIViewNoIntrinsicMetric, 96.f);
}

- (IBAction)doneButtonPressed:(UIButton*)button
{
	[self.delegate inputView:self doneButtonPressed:button];
}

@end
