//
//  MDRegistrationButtonsInputView.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 28/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDRegistrationButtonsInputView.h"
#import "UIView+MDBorders.h"


@implementation MDRegistrationButtonsInputView

- (void)layoutSubviews
{
	[UIView addTopBorderToView:self lineWidth:1.f color:[UIColor chatInputViewTopBorderColor]];
}

-(void)setTitles:(NSArray *)titles{
    _titles = titles;
    [self md_configureButtons];
}

- (void)md_configureButtons
{
	[self.buttonsView configureWithTitles:self.titles buttonHeight:50.f];
	[self.buttonsView addTarget:self
						 action:@selector(buttonSelected:)
			   forControlEvents:UIControlEventValueChanged];


}

- (CGSize)intrinsicContentSize
{
	return CGSizeMake(UIViewNoIntrinsicMetric, 216);

}

- (IBAction)buttonSelected:(MDGroupOfButtons*)groupOfButtons
{
	NSUInteger selectedIndex = groupOfButtons.selectedButtonIndex;
	[self.delegate inputView:self buttonWithTitlePressed:self.titles[selectedIndex]];
}


@end
