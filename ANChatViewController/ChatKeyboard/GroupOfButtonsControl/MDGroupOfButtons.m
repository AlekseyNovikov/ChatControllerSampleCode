//
//  MDGroupOfButtons.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 29/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDGroupOfButtons.h"
#import "UIView+MDBorders.h"
@interface MDGroupOfButtons ()
@property (nonatomic, readwrite) NSUInteger selectedButtonIndex;
@property (nonatomic, assign) NSUInteger numberOfButtons;
@property (nonatomic, assign) CGFloat buttonHeight;
@end

static const NSInteger tagConst = 1000;

@implementation MDGroupOfButtons

- (void)configureWithTitles:(NSArray *)titles buttonHeight:(CGFloat)buttonHeight;
{

	self.numberOfButtons = titles.count;
	self.buttonHeight = buttonHeight;
	self.selectedButtonIndex = 0;
	[self md_configureGroupWithButtonTitles:titles];
	[self configureAppearence];

}

- (void)configureAppearence
{
	self.layer.cornerRadius = 4;
	self.layer.borderWidth = 1;
	self.layer.borderColor = [UIColor chatInputViewTopBorderColor].CGColor;

	for (int i = 1; i < self.subviews.count; i++) {
		[UIView addTopBorderToView:self.subviews[i] lineWidth:1.f color:[UIColor chatInputViewTopBorderColor]];
	}
}

- (CGSize)intrinsicContentSize
{
	return CGSizeMake(UIViewNoIntrinsicMetric, self.buttonHeight * self.numberOfButtons);
}

- (void)md_configureGroupWithButtonTitles:(NSArray *)buttonTitles
{
	for (int i = 0; i < buttonTitles.count; i++) {
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.backgroundColor = [UIColor whiteColor];
		button.tag = tagConst + i;
		[button setTitle:buttonTitles[i] forState:UIControlStateNormal ];
		[button setTitleColor:[UIColor darkAppColor] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor inputTextViewTintColor] forState:UIControlStateHighlighted];

		[button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:button];
	}
	[self layoutButtons];
	[self layoutIfNeeded];

}

- (void)layoutButtons
{
	for (int i = 0; i < self.subviews.count; i++) {
		UIView *view = self.subviews[i];
		view.translatesAutoresizingMaskIntoConstraints = NO;
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(view)]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:view
														 attribute:NSLayoutAttributeHeight
														 relatedBy:NSLayoutRelationEqual
															toItem:nil
														 attribute:NSLayoutAttributeNotAnAttribute
														multiplier:1
														  constant:self.buttonHeight]];
		if (i == 0) {
			[self addConstraint:[NSLayoutConstraint constraintWithItem:view
															 attribute:NSLayoutAttributeTop
															 relatedBy:NSLayoutRelationEqual
																toItem:self
															 attribute:NSLayoutAttributeTop
															multiplier:1
															  constant:0]];
		} else {

			[self addConstraint:[NSLayoutConstraint constraintWithItem:view
															 attribute:NSLayoutAttributeTop
															 relatedBy:NSLayoutRelationEqual
																toItem:self.subviews[i - 1]
															 attribute:NSLayoutAttributeBottom
															multiplier:1
															  constant:0]];
		}
		if (i == self.subviews.count - 1) {
			[self addConstraint:[NSLayoutConstraint constraintWithItem:view
															 attribute:NSLayoutAttributeBottom
															 relatedBy:NSLayoutRelationEqual
																toItem:self
															 attribute:NSLayoutAttributeBottom
															multiplier:1
															  constant:0]];
		}
	}

}

- (IBAction)buttonPressed:(UIButton *)button
{
	self.selectedButtonIndex = button.tag - tagConst;
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
