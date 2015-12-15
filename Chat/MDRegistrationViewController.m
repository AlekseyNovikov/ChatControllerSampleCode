//
//  MDRegistrationViewController.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 23/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDRegistrationViewController.h"
#import "UIViewController+MDContainer.h"

#import "SearchDoctorViewController.h"

#import "MDChatViewController.h"
#import "RegistrationController.h"

#import "NSObject+MDBlocks.h"

#import "MDUserManager.h"
#import "MDChatManager.h"


@interface MDRegistrationViewController ()<RegistrationDelegate>

@property (weak, nonatomic) IBOutlet UIView *chatContainer;
@property (nonatomic, strong) RegistrationController *registrationController;

@end

static NSString *MDObservationContext = @"MDObservationContext";

@implementation MDRegistrationViewController

- (MDChatViewController *)chatViewController
{
	if (_chatViewController) {
		return _chatViewController;
	}
	_chatViewController = [[MDChatViewController alloc]initWithStyle:UITableViewStylePlain];
	_chatViewController.interactionEnable = NO;
	[[MDUserManager sharedManager] createChatManager];
	return _chatViewController;
}

- (RegistrationInputView *)chatInputAccessoryView///accessoryView
{
	if (_chatInputAccessoryView) {
		return _chatInputAccessoryView;
	}
	_chatInputAccessoryView = [RegistrationInputView  new];
	[_chatInputAccessoryView setBackgroundImage:[UIImage new]
							 forToolbarPosition:UIBarPositionAny
									 barMetrics:UIBarMetricsDefault];
	[_chatInputAccessoryView setShadowImage:[UIImage new]
						 forToolbarPosition:UIBarPositionAny];

	_chatInputAccessoryView.translatesAutoresizingMaskIntoConstraints = NO;
	[_chatInputAccessoryView setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];

	return _chatInputAccessoryView;

}

- (void)viewDidLoad
{
	[super viewDidLoad];
    
    [[MDUserManager sharedManager].chatManager deleteRealmHistory];

	[self displayContentController:self.chatViewController inContainer:self.chatContainer];
	self.registrationController = [[RegistrationController alloc]initWithViewController:self delegate:self];
	self.chatViewController.inputAccessoryView = self.chatInputAccessoryView;

	self.chatViewController.scrollViewDelegate = self.registrationController;

	///KVO
	[self.chatViewController.tableView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:(void*)&MDObservationContext];



	// Do any additional setup after loading the view.
	//DataSource
    [self.chatViewController setDataSourceForRegistration:YES];

}
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.chatViewController becomeFirstResponder];
	self.registrationController.registrationStep = MDRegistrationStepPhone;
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self.chatViewController resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Registration delegate
- (void)registrationController:(RegistrationController *)registrationController
			   incomingMessage:(NSString *)message
{
	[self performBlock:^{
		 [self.chatViewController addNewIncomingMessage:message];
	 } afterDelay:(0.3)];
}

- (void)registrationController:(RegistrationController *)registrationController sendMessage:(NSString *)message
{
	[self.chatViewController addNewMessage:message];
}

- (void)registrationController:(RegistrationController *)registrationController registrationFinished:(BOOL)finished
{
	if (finished) {
		SearchDoctorViewController *searchDoctorController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SearchDoctorViewController class])];
		searchDoctorController.fromRegister = YES;
		[self.navigationController pushViewController: searchDoctorController animated:YES];
		[[MDUserManager sharedManager].chatManager deleteRealmHistory];
	}
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (context == &MDObservationContext) {
		if ([keyPath isEqualToString:@"contentInset"]) {
			id newValue = [change objectForKey:NSKeyValueChangeNewKey];
			UIEdgeInsets newInsets;
			[newValue getValue:&newInsets];
			if (self.registrationController.registrationStep == MDRegistrationStepDone) {
				UIEdgeInsets correctInset = UIEdgeInsetsMake(0, 0, 70, 0);
				if (!UIEdgeInsetsEqualToEdgeInsets(newInsets, correctInset)) {
					[self.chatViewController.tableView setContentInset:correctInset];
				}
			}

		}
	} else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}


- (void)dealloc
{
	[self.chatViewController.tableView removeObserver:self forKeyPath:@"contentInset" context:&MDObservationContext];
}

@end
