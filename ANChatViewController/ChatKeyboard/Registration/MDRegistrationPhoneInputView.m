//
//  MDRegistrationPhoneInputView.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 23/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDRegistrationPhoneInputView.h"
#import "PhoneFormatter.h"
#import "UIView+MDBorders.h"

@interface MDRegistrationPhoneInputView ()<UITextFieldDelegate>
@property (nonatomic, strong) PhoneFormatter *phoneFormatter;
@end

@implementation MDRegistrationPhoneInputView

- (void)awakeFromNib
{
	[super awakeFromNib];
	[self md_commonInit];
}

- (void)md_commonInit
{

	[UIView addTopBorderToView:self lineWidth:1.f color:[UIColor chatInputViewTopBorderColor]];
	self.sendButton.enabled = NO;
	self.phoneFormatter = [[PhoneFormatter alloc] init];
	self.textField.tintColor = [UIColor inputTextViewTintColor];
	[self.textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
	self.textField.keyboardType = UIKeyboardTypeNumberPad;
	self.textField.delegate = self;
	[self.sendButton addTarget:self
						action:@selector(didPressedSendButton:)
			  forControlEvents:UIControlEventTouchUpInside];
}

- (CGSize)intrinsicContentSize
{
	return CGSizeMake(UIViewNoIntrinsicMetric, 40.f);
}

#pragma mark - Actions
- (void)didPressedSendButton:(id)sender
{
	if (self.sendButton.enabled) {
		[self.delegate inputView:self sendButtonDidPressed:(UIButton*)sender];
	}
}

- (void)textFieldChanged:(UITextField*)textField
{
	self.sendButton.enabled = NO;
	self.sendButton.highlighted = NO;
	if (textField.text.length < 2) {
		textField.text = @"+7";
	}
	if (textField.text.length >= 16) {
		textField.text = [textField.text substringToIndex:16];
		self.sendButton.enabled = YES;
		self.sendButton.highlighted = YES;
	}
	textField.text = [self.phoneFormatter format:textField.text];
}

#pragma mark - TextField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	textField.text = @"+7 ";
}

/*
   // Only override drawRect: if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   - (void)drawRect:(CGRect)rect {
    // Drawing code
   }
 */

@end
