//
//  MDChatInputView.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 05/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChatInputView.h"
#import "MDChatInputTextView.h"
@interface MDChatInputView ()

@property(weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomConstraint;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *textViewTopConstraint;

@end

@implementation MDChatInputView

- (void)awakeFromNib
{
	[super awakeFromNib];
	[self commonInit];
}

- (void)commonInit
{
	self.rightButton.enabled = NO;
	[self md_configureTextView];
	[self md_registerNotifications];
}


#pragma mark - UIView Overrides

- (void)layoutIfNeeded
{
	if (self.constraints.count == 0 || !self.window) {
		return;
	}

	[super layoutIfNeeded];
}

- (CGSize)intrinsicContentSize
{
	return CGSizeMake(UIViewNoIntrinsicMetric, [self minimumInputbarHeight]);
}

+ (BOOL)requiresConstraintBasedLayout
{
	return YES;
}

- (void)md_configureTextView
{
	self.textView.maxNumberOfLines = [self defaultNumberOfLines];

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

- (CGFloat)minimumInputbarHeight
{
	CGFloat minimumTextViewHeight = self.textView.intrinsicContentSize.height;
	minimumTextViewHeight += _textViewBottomConstraint.constant + _textViewTopConstraint.constant;
	return minimumTextViewHeight;
}
- (CGFloat)maximumHeight
{
    return [self inputBarHeightForLines:self.textView.maxNumberOfLines];

}

- (CGFloat)appropriateHeight
{
	CGFloat height = 0.0;
	CGFloat minimumHeight = [self minimumInputbarHeight];

	if (self.textView.numberOfLines == 1) {
		height = minimumHeight;
	} else if (self.textView.numberOfLines < self.textView.maxNumberOfLines) {
		height = [self inputBarHeightForLines:self.textView.numberOfLines];
	} else {
		height = [self inputBarHeightForLines:self.textView.maxNumberOfLines];
	}

	if (height < minimumHeight) {
		height = minimumHeight;
	}

	return roundf(height);
}

- (CGFloat)inputBarHeightForLines:(NSUInteger)numberOfLines
{
	CGFloat height = self.textView.intrinsicContentSize.height;
	height -= self.textView.font.lineHeight;
	height += roundf(self.textView.font.lineHeight * numberOfLines);
	height += _textViewBottomConstraint.constant + _textViewTopConstraint.constant;

	return height;
}

- (NSUInteger)defaultNumberOfLines
{
	return 4;
}


#pragma mark - Setters

- (void)setBackgroundColor:(UIColor *)color
{
	self.tintColor = color;
}

- (void)rightButtonChangeState:(BOOL)state
{
	self.rightButton.enabled = state;
	self.rightButton.highlighted = state;
}

#pragma mark - Notification Events

- (void)md_didChangeTextViewText:(NSNotification *)notification
{
	MDChatInputTextView *textView = (MDChatInputTextView*)notification.object;

	// Skips this it's not the expected textView.
	if (![textView isEqual:self.textView]) {
		return;
	}
	[self rightButtonChangeState:textView.text.length];
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

	_textView.delegate = nil;
	_textView = nil;

	_leftButton = nil;
	_rightButton = nil;
}

@end
