//
//  MDRegistrationNameInputView.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 02/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDRegistrationNameInputView.h"


@implementation MDRegistrationNameInputView

- (void)awakeFromNib
{
	[super awakeFromNib];
	[self md_commonInit];
	[self setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
}

- (void)md_commonInit
{
	[self md_configureTextView];

	self.backgroundColor = [UIColor whiteColor];
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth;

	self.textView.placeholder = @"Ваше имя";
	self.textView.maxNumberOfLines = 4;

	[self.sendButton addTarget:self
						action:@selector(sendButtonPressed:)
			  forControlEvents:UIControlEventTouchUpInside];
	self.sendButton.enabled = NO;

	[self md_registerNotifications];
}

- (void)md_configureTextView
{
	self.textView.maxNumberOfLines = 4;

	self.textView.font = [UIFont inputMessageTextFont];

	self.textView.autocapitalizationType = UITextAutocapitalizationTypeSentences;
	self.textView.keyboardType = UIKeyboardTypeDefault;
	self.textView.keyboardAppearance = UIKeyboardAppearanceDark;
	self.textView.returnKeyType = UIReturnKeyDefault;
	self.textView.enablesReturnKeyAutomatically = YES;
	self.textView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, -1.0, 0.0, 1.0);
	self.textView.textContainerInset = UIEdgeInsetsZero;
	self.textView.tintColor = [UIColor inputTextViewTintColor];
}

- (CGSize)intrinsicContentSize
{
	return CGSizeMake(UIViewNoIntrinsicMetric, 40.f);
}

- (IBAction)sendButtonPressed:(UIButton *)button
{
	[self.delegate inputView:self sendButtonDidPressed:button];
}

- (void)sendButtonChangeState:(BOOL)state
{
	self.sendButton.enabled = state;
	self.sendButton.highlighted = state;
}

#pragma mark - Notification Events

- (void)md_didChangeTextViewText:(NSNotification *)notification
{
	MDChatInputTextView *textView = (MDChatInputTextView*)notification.object;

	// Skips this it's not the expected textView.
	if (![textView isEqual:self.textView]) {
		return;
	}
	[self sendButtonChangeState:textView.text.length];
}

#pragma mark - NSNotificationCenter register/unregister

- (void)md_registerNotifications
{
	[self md_unregisterNotifications];

	[[NSNotificationCenter defaultCenter]
	 addObserver:self
		selector:@selector(md_didChangeTextViewText:)
			name:UITextViewTextDidChangeNotification
		  object:nil];
}

- (void)md_unregisterNotifications
{
	[[NSNotificationCenter defaultCenter]
	 removeObserver:self];

}

#pragma mark - Lifeterm

- (void)dealloc
{
	[self md_unregisterNotifications];
}

@end
