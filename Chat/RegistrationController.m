//
//  RegistrationController.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 23/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "RegistrationController.h"
#import "MDRegistrationViewController.h"

#import "MDRegistrationPhoneInputView.h"
#import "MDRegistrationSmsInputView.h"
#import "MDRegistrationButtonsInputView.h"
#import "MDRegistrationPregnancyAgeInputView.h"
#import "MDChatInputTextView.h"

#import "MDRegistrationNameInputView.h"
#import "MDRegistrationDoneInputView.h"

#import "MDInputViewDelegate.h"

#import "MDNetworkManager.h"
#import "MDUserManager.h"

@interface RegistrationController ()<MDInputViewDelegate>

@property (nonatomic, strong) MDRegistrationViewController *viewController;
@property (nonatomic, strong) UIView *accessoryView;
@property (nonatomic, strong) UIView *actionSheetView;
@property (nonatomic, strong) NSMutableDictionary *registrationData;

@property (nonatomic, strong) NSTimer *sendTimer;

@property (nonatomic, assign) BOOL forMen;
@property (nonatomic, assign) BOOL forPregnancy;

@end

static const NSInteger tagConst = 2000;

@implementation RegistrationController

- (instancetype)initWithViewController:(MDRegistrationViewController *)viewController
							  delegate:(id<RegistrationDelegate>)delegate
{
	if (self = [super init]) {
		self.viewController = viewController;
		self.delegate = delegate;
		self.registrationStep = MDRegistrationStepInit;
		self.registrationData = [NSMutableDictionary new];


	}
	return self;
}

- (void)dealloc
{
	self.delegate = nil;
}

#pragma  mark - Getters
- (UIView *)accessoryView
{
	if (!_accessoryView) {
		_accessoryView = [UIView new];
		_accessoryView = self.viewController.chatInputAccessoryView;
	}
	return _accessoryView;
}
#pragma mark - Setter
- (void)setRegistrationStep:(MDRegistrationStep)registrationStep
{
	if (self.registrationStep == registrationStep) {
		return;
	}
	[self tranzitionFromStep:_registrationStep toStep:registrationStep];
	_registrationStep = registrationStep;

}

#pragma mark - StateMachine method
- (void)tranzitionFromStep:(MDRegistrationStep)fromStep toStep:(MDRegistrationStep)toStep
{
	if (fromStep == toStep) {
		return;
	}
	static UIView *fromView;
	if (fromStep == MDRegistrationStepInit && toStep == MDRegistrationStepPhone) {

		//ввод номера телефона

		MDRegistrationPhoneInputView *phoneView = [[[NSBundle mainBundle] loadNibNamed:@"MDRegistrationPhoneInputView"
																				 owner:nil
																			   options:nil] objectAtIndex:0];
		phoneView.delegate = self;
		phoneView.backgroundColor  = [UIColor whiteColor];
		[self.accessoryView addSubview:phoneView];
		[self layoutAccessorySubview:phoneView];
		[self.delegate registrationController:self incomingMessage:@"Здравствуйте! Через пару минут вы познакомитесь с вашим доктором. А пока введите номер телефона, чтобы мы завели вам учетную запись."];
		fromView = phoneView;
	}
	if (fromStep == MDRegistrationStepPhone && toStep == MDRegistrationStepSms) {

		//ввод кода из СМС

		MDRegistrationSmsInputView *smsView = [[[NSBundle mainBundle] loadNibNamed:@"MDRegistrationSmsInputView"
																			 owner:nil
																		   options:nil] objectAtIndex:0];
		smsView.delegate = self;
		[self.accessoryView insertSubview:smsView belowSubview:fromView];
		[self layoutAccessorySubview:smsView];
		[smsView.textField becomeFirstResponder];

		[self transitionView:fromView toView:smsView slideFromRight:NO];
		[self.delegate registrationController:self incomingMessage:@"Отлично. Вам выслан код подтверждения.\nВведите его ниже."];
		self.sendTimer = [NSTimer scheduledTimerWithTimeInterval:30
														  target:self
														selector:@selector(repeatMessage:)
														userInfo:nil
														 repeats:NO];

		fromView = smsView;

	}
	if (fromStep == MDRegistrationStepSms && toStep == MDRegistrationStepPhone) {

		//обратно к телефону

		MDRegistrationPhoneInputView *phoneView = [[[NSBundle mainBundle] loadNibNamed:@"MDRegistrationPhoneInputView"
																				 owner:nil
																			   options:nil] objectAtIndex:0];
		phoneView.delegate = self;
		[self.accessoryView insertSubview:phoneView belowSubview:fromView];
		[self layoutAccessorySubview:phoneView];
		[phoneView.textField becomeFirstResponder];
		[self transitionView:fromView toView:phoneView slideFromRight:YES];
		fromView = phoneView;

	}
	if (fromStep == MDRegistrationStepSms && toStep == MDRegistrationStepSex) {

		//ввод пола
		[self.sendTimer invalidate];
		self.sendTimer = nil;

		MDRegistrationButtonsInputView *sexView = [[[NSBundle mainBundle] loadNibNamed:@"MDRegistrationButtonsInputView"
																				 owner:nil
																			   options:nil] objectAtIndex:0];
		sexView.type = MDButtonsInputViewTypeSex;
		sexView.titles = @[@"Я мужчина", @"Я женщина"];
		sexView.delegate = self;
		[self.accessoryView insertSubview:sexView belowSubview:fromView];
		[self layoutAccessorySubview:sexView];
		[self transitionView:fromView toView:sexView];

		[self.delegate registrationController:self incomingMessage:@"Готово!\nПожалуйста, расскажите о себе"];

		fromView = sexView;


	}
	if (fromStep == MDRegistrationStepSex && toStep == MDRegistrationStepChildrens) {

		//ввод информации о детях
		MDRegistrationButtonsInputView *childrensView = [[[NSBundle mainBundle] loadNibNamed:@"MDRegistrationButtonsInputView"
																					   owner:nil
																					 options:nil] objectAtIndex:0];

		childrensView.type = MDButtonsInputViewTypeChildrens;
		if (self.forMen) {
			childrensView.titles = @[@"Детей нет", @"Я папа"];
		} else {
			childrensView.titles = @[@"Детей нет", @"Я будущая мама", @"Я мама"];
		}
		childrensView.delegate = self;
		[self.accessoryView insertSubview:childrensView belowSubview:fromView];
		[self layoutAccessorySubview:childrensView];
		[self transitionView:fromView toView:childrensView slideFromRight:NO];

		[self.delegate registrationController:self incomingMessage:@"У вас есть дети?"];

		fromView = childrensView;
	}
	if (fromStep == MDRegistrationStepChildrens && toStep == MDRegistrationStepPregnancyAge) {
		MDRegistrationPregnancyAgeInputView *pregnancyAgeView = [[[NSBundle mainBundle] loadNibNamed:@"MDRegistrationPregnancyAgeInpytView"
																							   owner:nil
																							 options:nil] objectAtIndex:0];


		pregnancyAgeView.delegate = self;
		[self.accessoryView insertSubview:pregnancyAgeView belowSubview:fromView];
		[self layoutAccessorySubview:pregnancyAgeView];
		[self transitionView:fromView toView:pregnancyAgeView slideFromRight:NO];

		[self.delegate registrationController:self incomingMessage:@"Это чудесно!☺️На каком вы сроке?"];

		fromView = pregnancyAgeView;
	}
	if ((fromStep == MDRegistrationStepPregnancyAge || fromStep == MDRegistrationStepChildrens) && toStep == MDRegistrationStepName) {
		MDRegistrationNameInputView *nameView = [[[NSBundle mainBundle] loadNibNamed:@"MDRegistrationNameInputView"
																			   owner:nil
																			 options:nil]
												 objectAtIndex:0];
		nameView.delegate = self;
		[self.accessoryView insertSubview:nameView belowSubview:fromView];
		[self layoutAccessorySubview:nameView];
		[nameView.textView becomeFirstResponder];
		[self transitionView:fromView toView:nameView];

		[self.delegate registrationController:self incomingMessage:@"Как доктору к вам обращаться?"];

		fromView = nameView;
	}
	if (fromStep == MDRegistrationStepName && toStep == MDRegistrationStepDone) {

		MDRegistrationDoneInputView *doneView = [[[NSBundle mainBundle] loadNibNamed:@"MDRegistrationDoneInputView"
																			   owner:nil
																			 options:nil]
												 objectAtIndex:0];
		doneView.delegate = self;
		doneView.tag = tagConst + 1;
		[self.accessoryView insertSubview:doneView belowSubview:fromView];
		[self layoutAccessorySubview:doneView];
		[self transitionView:fromView toView:doneView];

		[self.delegate registrationController:self incomingMessage:[NSString stringWithFormat:@"Приятно познакомиться, %@. Ваши данные сохранены в Настройках.", [self.registrationData valueForKey:@"name"]]];
		[self.delegate registrationController:self incomingMessage:@"Нажмите «Готово», и мы подберем вам подходящего доктора"];
	}
}

- (void)layoutAccessorySubview:(UIView *)subView
{
	subView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.accessoryView addConstraints:[NSLayoutConstraint
										constraintsWithVisualFormat:@"H:|[subView]|"
															options:0
															metrics:nil
															  views:NSDictionaryOfVariableBindings(subView)]];
	[self.accessoryView addConstraints:[NSLayoutConstraint
										constraintsWithVisualFormat:@"V:|[subView]|"
															options:0
															metrics:nil
															  views:NSDictionaryOfVariableBindings(subView)]];
}


#pragma mark - InputViewDelegate
- (void)inputView:(UIView *)inputView sendButtonDidPressed:(UIButton *)button
{
	if  ([inputView isKindOfClass:[MDRegistrationPhoneInputView class]]) {
		NSString *phoneNumber = ((MDRegistrationPhoneInputView*)inputView).textField.text;
		phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
		phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"–" withString:@""];

		[self.delegate registrationController:self sendMessage:phoneNumber];
		[self.registrationData setObject:phoneNumber forKey:@"phone"];

		[[MDUserManager sharedManager] getSmsCodeWithPhoneNumber:phoneNumber completion:nil];

		self.registrationStep = MDRegistrationStepSms;
	}
	if ([inputView isKindOfClass:[MDRegistrationNameInputView class]]) {
		NSString *name = ((MDRegistrationNameInputView*)inputView).textView.text;
		[((MDRegistrationNameInputView*)inputView).textView resignFirstResponder];
		[self.delegate registrationController:self sendMessage:name];
		[self.registrationData setObject:name forKey:@"name"];
		self.registrationStep = MDRegistrationStepDone;
	}
}

- (void)inputView:(UIView *)inputView newSmsCodeButtonDidPressed:(UIButton *)button
{
	if  ([inputView isKindOfClass:[MDRegistrationSmsInputView class]]) {
		[[MDUserManager sharedManager] getSmsCodeWithPhoneNumber:self.registrationData[@"phone"] completion:nil];
	}

}

- (void)inputView:(UIView *)inputView changePhoneNumberButtonDidPressed:(UIButton *)button
{
	if  ([inputView isKindOfClass:[MDRegistrationSmsInputView class]]) {
		self.registrationStep = MDRegistrationStepPhone;
	}

}

- (void)inputView:(UIView *)inputView smsCodeEntered:(NSString *)smsCode
{
	if  ([inputView isKindOfClass:[MDRegistrationSmsInputView class]]) {
		[self.delegate registrationController:self sendMessage:smsCode];
		__weak RegistrationController *weakSelf = self;

		[[MDUserManager sharedManager] loginWithSMSCode:smsCode
											phoneNumber:self.registrationData[@"phone"]
											 completion:^(BOOL codeValid, MDHTTPRequest *request, NSError *error) {
			 if (codeValid) {
				 weakSelf.registrationStep = MDRegistrationStepSex;
				 [((MDRegistrationSmsInputView*)inputView).textField resignFirstResponder];
			 } else {
				 [weakSelf wrongSmsCodeAnimationForView:inputView];
				 ((MDRegistrationSmsInputView*)inputView).textField.text = @"";
			 }
		 }];
	}

}

- (void)inputView:(UIView *)inputView buttonWithTitlePressed:(NSString *)title
{
	if ([inputView isKindOfClass:[MDRegistrationButtonsInputView class]]) {
		if (((MDRegistrationButtonsInputView*)inputView).type == MDButtonsInputViewTypeSex) {
			[self.delegate registrationController:self sendMessage:title];
			if ([title isEqualToString:@"Я мужчина"]) {
				self.forMen = YES;
			}
			[self.registrationData setObject:self.forMen ? @"male" : @"female" forKey:@"gender"];

			self.registrationStep = MDRegistrationStepChildrens;
		} else if (((MDRegistrationButtonsInputView*)inputView).type == MDButtonsInputViewTypeChildrens) {
			[self.delegate registrationController:self sendMessage:title];
//			[self.registrationData setObject:title forKey:@"childrens"];
			if ([title isEqualToString:@"Я будущая мама"]) {
				self.forPregnancy = YES;
			}

			self.registrationStep = self.forPregnancy ? MDRegistrationStepPregnancyAge : MDRegistrationStepName;
		}
	}
}

- (void)inputView:(UIView *)inputView pickerValueSelected:(NSString *)string
{
	if ([inputView isKindOfClass:[MDRegistrationPregnancyAgeInputView class]]) {
		[self.delegate registrationController:self sendMessage:string];
		[self.registrationData setObject:@([string integerValue]) forKey:@"pregnant_weeks"];
		self.registrationStep = MDRegistrationStepName;
	}
}

- (void)inputView:(UIView *)inputView doneButtonPressed:(UIButton *)button
{
	if ([inputView isKindOfClass:[MDRegistrationDoneInputView class]]) {//перенести на экран с анимацией

		[[MDUserManager sharedManager] registerUserWithData:self.registrationData completion:nil];
		[self.delegate registrationController:self registrationFinished:YES];
	}
}


- (void)repeatMessage:(id)sender
{
	[self.delegate registrationController:self incomingMessage:@"Не получили СМС с кодом? Нажмите ↻ и мы отправим новый.\nИли вы можете изменить номер телефона"];
}

#pragma mark - MDChatScrollViewDelegate
- (void)chatViewController:(MDChatViewController *)chatViewController scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (self.registrationStep == MDRegistrationStepDone) {
		MDRegistrationDoneInputView *doneView = (MDRegistrationDoneInputView*)[self.accessoryView viewWithTag:tagConst + 1];

		CGFloat offsetFromInset = scrollView.contentOffset.y + scrollView.contentInset.top;
		CGFloat contentFrameY = fabs(MIN(offsetFromInset, 0.0));

		CGRect contentFrame = CGRectMake(0.0, contentFrameY, scrollView.bounds.size.width, scrollView.contentSize.height - MAX(0.0, offsetFromInset) + scrollView.contentInset.top - scrollView.contentInset.bottom + 64);

		UIView *superContentView = chatViewController.parentViewController.view;

		CGRect viewInMainRect = [superContentView convertRect:doneView.frame fromView:nil];
		CGRect accessoryViewConvertedFrame = CGRectMake(0.0,
														superContentView.frame.size.height - viewInMainRect.size.height,
														viewInMainRect.size.width,
														viewInMainRect.size.height);
		CGRect intersectionRect = CGRectIntersection(contentFrame, accessoryViewConvertedFrame);

		doneView.backgroundAlpha = 1.5 * intersectionRect.size.height / accessoryViewConvertedFrame.size.height;
	}
}

#pragma mark - Animations

- (void)transitionView:(UIView *)view toView:(UIView *)toView slideFromRight:(BOOL)slideFromRight
{
	CATransition* transition = [CATransition animation];
	transition.startProgress = 0;
	transition.endProgress = 1;
	transition.type = kCATransitionPush;
	transition.subtype = slideFromRight ? kCATransitionFromLeft : kCATransitionFromRight;
	transition.duration = 0.2;
	[transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];


	// Add the transition animation to both layers
	[view.layer addAnimation:transition forKey:@"transition"];
	[toView.layer addAnimation:transition forKey:@"transition"];

	// Finally, change the visibility of the layers.
	view.hidden = YES;
	toView.hidden = NO;
}
- (void)transitionView:(UIView *)view toView:(UIView *)toView
{

	CATransition* transition = [CATransition animation];
	transition.startProgress = 0.18;
	transition.endProgress = 1;
	transition.type = kCATransitionPush;
	transition.subtype =  kCATransitionFromTop;
	transition.duration = 0.3;

	[transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];

	// Add the transition animation to both layers
	toView.hidden = NO;
	[toView.layer addAnimation:transition forKey:@"transition"];

	view.hidden = YES;
}

- (void)wrongSmsCodeAnimationForView:(UIView *)view
{
	CAKeyframeAnimation * anim = [ CAKeyframeAnimation animationWithKeyPath:@"transform" ];
	anim.values = @[
		[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0, 0.0f, 0.0f)],
		[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]
	];
	anim.autoreverses = YES;
	anim.repeatCount = 2.0f;
	anim.duration = 0.07f;

	[view.layer addAnimation:anim forKey:nil];
}

@end
