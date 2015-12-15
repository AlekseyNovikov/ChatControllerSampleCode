//
//  MDInputViewDelegate.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 26/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

@protocol MDInputViewDelegate <NSObject>

@required
- (void)inputView:(UIView *)inputView sendButtonDidPressed:(UIButton *)button;
- (void)inputView:(UIView *)inputView newSmsCodeButtonDidPressed:(UIButton *)button;
- (void)inputView:(UIView *)inputView changePhoneNumberButtonDidPressed:(UIButton *)button;
- (void)inputView:(UIView *)inputView smsCodeEntered:(NSString*)smsCode;

- (void)inputView:(UIView *)inputView buttonWithTitlePressed:(NSString *)title;

- (void)inputView:(UIView *)inputView menButtonPressed:(UIButton *)button;
- (void)inputView:(UIView *)inputView womenButtonPressed:(UIButton *)button;

- (void)inputView:(UIView *)inputView pickerValueSelected:(NSString *)string;

- (void)inputView:(UIView *)inputView doneButtonPressed:(UIButton *)button;

@end