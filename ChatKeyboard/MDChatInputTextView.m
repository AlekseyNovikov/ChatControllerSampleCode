//
//  MDChatInputTextView.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 05/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChatInputTextView.h"

NSString *const MDTextViewTextWillChangeNotification = @"MDTextViewTextWillChangeNotification";

@interface MDChatInputTextView ()

// The label used as placeholder
@property(nonatomic, strong) UILabel *placeholderLabel;
// Used for detecting if the scroll indicator was previously flashed
@property(nonatomic) BOOL didFlashScrollIndicators;

@end

@implementation MDChatInputTextView

- (instancetype)initWithFrame:(CGRect)frame
				textContainer:(NSTextContainer *)textContainer
{
	if (self = [super initWithFrame:frame textContainer:textContainer]) {
		[self commonInit];
	}
	return self;
}
- (void)awakeFromNib
{
	[super awakeFromNib];
	[self commonInit];
}

- (void)commonInit
{
	self.editable = YES;
	self.selectable = YES;
	self.scrollEnabled = YES;
	self.scrollsToTop = NO;
	self.directionalLockEnabled = YES;
    
	[self md_registerNotifications];
}


#pragma mark - UIView Overrides

- (CGSize)intrinsicContentSize
{
    CGRect textRect = [self.layoutManager usedRectForTextContainer:self.textContainer];
    CGFloat height = textRect.size.height + self.textContainerInset.top + self.textContainerInset.bottom;
   	height = roundf(height);

	return CGSizeMake(UIViewNoIntrinsicMetric, height);
}

+ (BOOL)requiresConstraintBasedLayout
{
	return YES;
}

- (void)layoutSubviews
{
	[super layoutSubviews];

	self.placeholderLabel.hidden = [self md_shouldHidePlaceholder];

	if (!self.placeholderLabel.hidden) {

		[UIView performWithoutAnimation:^{
			 self.placeholderLabel.frame = [self md_placeholderRectThatFits:self.bounds];
			 [self sendSubviewToBack:self.placeholderLabel];
		 }];
	}
}

#pragma mark - Getters
- (UILabel *)placeholderLabel
{
	if (!_placeholderLabel) {
		_placeholderLabel = [UILabel new];
		_placeholderLabel.clipsToBounds = NO;
		_placeholderLabel.autoresizesSubviews = NO;
		_placeholderLabel.numberOfLines = 1;
		_placeholderLabel.font = self.font;
		_placeholderLabel.backgroundColor = [UIColor clearColor];
		_placeholderLabel.textColor = [UIColor lightGrayColor];
		_placeholderLabel.hidden = YES;

		[self addSubview:_placeholderLabel];
	}
	return _placeholderLabel;
}

- (NSString *)placeholder
{
	return self.placeholderLabel.text;
}

- (UIColor *)placeholderColor
{
	return self.placeholderLabel.textColor;
}

- (NSUInteger)numberOfLines
{
	CGFloat contentHeight = self.contentSize.height;
	contentHeight -= self.textContainerInset.top + self.textContainerInset.bottom;

	return fabs(contentHeight / self.font.lineHeight);
}

- (NSUInteger)maxNumberOfLines
{
	NSUInteger numberOfLines = _maxNumberOfLines;

	// number of lines for different devices???

	return numberOfLines;
}

- (BOOL)isExpanding
{
	if (self.numberOfLines >= self.maxNumberOfLines) {
		return YES;
	}
	return NO;
}

- (BOOL)md_shouldHidePlaceholder
{
	if (self.placeholder.length == 0 || self.text.length > 0) {
		return YES;
	}
	return NO;
}

- (CGRect)md_placeholderRectThatFits:(CGRect)bounds
{
	CGRect rect = CGRectZero;
	rect.size = [self.placeholderLabel sizeThatFits:bounds.size];
	rect.origin = UIEdgeInsetsInsetRect(bounds, self.textContainerInset).origin;

	CGFloat padding = self.textContainer.lineFragmentPadding;
	rect.origin.x += padding;

	return rect;
}

#pragma mark - Setters
-(void)setText:(NSString *)text
{
    [super setText:text];
    [self md_updateLayout];
}

- (void)setPlaceholder:(NSString *)placeholder
{
	self.placeholderLabel.text = placeholder;
	self.accessibilityLabel = placeholder;

	[self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)color
{
	self.placeholderLabel.textColor = color;
}

#pragma mark - UITextView Overrides

- (void)layoutIfNeeded
{
	if (!self.window) {
		return;
	}

	[super layoutIfNeeded];
}

#pragma mark - Notification Events


- (void)md_didChangeText:(NSNotification *)notification
{
	if (![notification.object isEqual:self]) {
		return;
	}

	if (self.placeholderLabel.hidden != [self md_shouldHidePlaceholder]) {
		[self setNeedsLayout];
	}
    [self md_updateLayout];
	[self md_flashScrollIndicatorsIfNeeded];
}

- (void)md_updateLayout
{
    [self invalidateIntrinsicContentSize];
    [self.superview layoutIfNeeded];//changing the intrinsic content size invalidates the layout of the superview
    [self scrollRangeToVisible:self.selectedRange];
}

- (void)md_flashScrollIndicatorsIfNeeded
{
	if (self.numberOfLines == self.maxNumberOfLines + 1) {
		if (!_didFlashScrollIndicators) {
			_didFlashScrollIndicators = YES;
			[super flashScrollIndicators];
		}
	} else if (_didFlashScrollIndicators) {
		_didFlashScrollIndicators = NO;
	}
}

#pragma mark - NSNotificationCenter register/unregister

- (void)md_registerNotifications
{
	[self md_unregisterNotifications];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(md_didChangeText:)
												 name:UITextViewTextDidChangeNotification
											   object:nil];


}

- (void)md_unregisterNotifications
{

	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UITextViewTextDidChangeNotification
												  object:nil];

}

#pragma mark - Lifeterm

- (void)dealloc
{
	[self md_unregisterNotifications];
	_placeholderLabel = nil;
}

@end
