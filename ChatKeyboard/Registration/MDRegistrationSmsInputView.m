//
//  MDRegistrationSmsInputView.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 23/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDRegistrationSmsInputView.h"
#import "UIView+MDBorders.h"

@interface MDRegistrationSmsInputView ()<UITextFieldDelegate>

@end

@implementation MDRegistrationSmsInputView

- (void)awakeFromNib
{
	[super awakeFromNib];
	[self md_commonInit];
}

- (void)md_commonInit
{
    [UIView addTopBorderToView:self lineWidth:1.f color:[UIColor chatInputViewTopBorderColor]];
	self.textField.keyboardType = UIKeyboardTypeNumberPad;
	self.textField.tintColor = [UIColor inputTextViewTintColor];
	[self.textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];

	[self.changePhoneNumberButton addTarget:self
									 action:@selector(didPressedChangePhoneNumberButton:)
						   forControlEvents:UIControlEventTouchUpInside];
	[self.refreshSmsCodeButton addTarget:self
								  action:@selector(didPressedRefreshSmsCodeButton:)
						forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Actions
- (void)textFieldChanged:(UITextField*)textField
{
	if (textField.text.length >= 5) {
		textField.text = [textField.text substringToIndex:5];
	}
	if (textField.text.length == 4) {
		[self.delegate inputView:self smsCodeEntered:textField.text];
    }
}
- (void)didPressedChangePhoneNumberButton:(id)sender
{
	[self.delegate inputView:self changePhoneNumberButtonDidPressed:(UIButton*)sender];
}

- (void)didPressedRefreshSmsCodeButton:(id)sender
{
	[self.delegate inputView:self newSmsCodeButtonDidPressed:(UIButton*)sender];
}
/*
   // Only override drawRect: if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   - (void)drawRect:(CGRect)rect {
    // Drawing code
   }
 */

@end
