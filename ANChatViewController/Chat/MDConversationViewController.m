//
//  MDConversationViewController.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 21/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDConversationViewController.h"
#import "UIViewController+MDContainer.h"

//#import "DoctorInfoNavigationView.h"
//#import "DoctorInfoViewController.h"

#import "MDChatViewController.h"

#import "MDChatInputView.h"
#import "MDChatInputTextView.h"

#import "MDAddPhotoInputView.h"

#import "MDUserManager.h"
#import "MDChatManager.h"
#import "MDChat.h"


@interface MDConversationViewController () <UINavigationControllerDelegate, UITextViewDelegate, UITableViewDelegate, MDAddPhotoInputViewDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) MDChatManager *chatManager;
@property (nonatomic, strong) NSTimer *chatTimer;

@property (weak, nonatomic) IBOutlet UIView *chatContainer;

@property (nonatomic, strong) MDChatViewController *chatViewController;

@property (nonatomic, getter = isViewVisible) BOOL viewVisible;

@property (nonatomic, getter = isFirstShow) BOOL firstShow;

@end

@implementation MDConversationViewController



- (MDChatInputView *)chatInputView
{
	if (_chatInputView) {
		return _chatInputView;
	}
	_chatInputView = [[[NSBundle mainBundle] loadNibNamed:@"MDChatInputView"
													owner:nil
												  options:nil] objectAtIndex:0];
	_chatInputView.backgroundColor = [UIColor whiteColor];
	_chatInputView.translucent = NO;
	_chatInputView.translatesAutoresizingMaskIntoConstraints = NO;

	_chatInputView.textView.placeholder = @"Написать сообщение";
	_chatInputView.textView.maxNumberOfLines = 4;

	[_chatInputView.leftButton addTarget:self action:@selector(didPressAddPhotoButton:) forControlEvents:UIControlEventTouchUpInside];
	[_chatInputView.rightButton addTarget:self action:@selector(didPressSendMessageButton:) forControlEvents:UIControlEventTouchUpInside];

	[_chatInputView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
	[_chatInputView addConstraint:[NSLayoutConstraint constraintWithItem:_chatInputView
															   attribute:NSLayoutAttributeHeight
															   relatedBy:NSLayoutRelationLessThanOrEqual
																  toItem:nil
															   attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f
																constant:_chatInputView.maximumHeight]];

	return _chatInputView;
}


- (MDChatViewController *)chatViewController
{
	if (_chatViewController) {
		return _chatViewController;
	}
	_chatViewController = [[MDChatViewController alloc]initWithStyle:UITableViewStylePlain];
	_chatViewController.interactionEnable = YES;
	[[MDUserManager sharedManager] createChatManager];
	_chatViewController.tableView.contentInset = UIEdgeInsetsMake(0.f, 0, 12.f, 0);//TODO: set proper offset
	return _chatViewController;
}


- (void)viewDidLoad
{
	[super viewDidLoad];

	[self displayContentController:self.chatViewController inContainer:self.chatContainer];
	self.chatViewController.inputAccessoryView = self.chatInputView;

	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableTapped:)];
	[self.chatViewController.view addGestureRecognizer:tap];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardDidHide:)
												 name:UIKeyboardDidHideNotification
											   object:nil];

	//DataSource
    [self.chatViewController setDataSourceForRegistration:NO];
    [self.chatViewController.tableViewDataSource getTmpData];

//	[self.chatViewController.tableViewDataSource startTimerIfNeeded];
}

- (IBAction)tableTapped:(id)sender
{
	[self.chatInputView.textView resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	// Helps laying out subviews with recently added constraints.

	[self.view layoutIfNeeded];
	self.viewVisible = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.chatViewController becomeFirstResponder];
	[self.navigationController setDelegate:self];

}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self.chatViewController resignFirstResponder];
	self.viewVisible = NO;
}

#pragma mark - Getters
- (MDChatInputTextView *)chatInputTextView
{
	return self.chatInputView.textView;
}

- (UIButton *)addPhotoButton
{
	return self.chatInputView.leftButton;
}

- (UIButton *)sendMessageButton
{
	return self.chatInputView.rightButton;
}

#pragma mark - Actions
- (void)didPressAddPhotoButton:(id)sender
{

	MDAddPhotoInputView *addPhotoView = [[[NSBundle mainBundle] loadNibNamed:@"MDAddPhotoInputView"
																	   owner:nil
																	 options:nil]
										 objectAtIndex:0];


	addPhotoView.delegate = self;
	self.chatViewController.inputView = addPhotoView;
	[self.chatViewController reloadInputViews];
	[self.chatViewController becomeFirstResponder];
}

- (void)didPressSendMessageButton:(id)sender
{
	NSString *newMessage = self.chatInputTextView.text;
	self.chatInputTextView.text = @"";

	//TODO - completion поменять на метод делегата в котором обновлять нужную ячейку?ячейки?
	[self.chatViewController addNewMessage:newMessage];

}

#pragma mark - AddPhotoDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
	///send image
	[self.chatViewController addImageMessage:chosenImage];

	[picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)makePhotoButonPresedInAddPhotoInputView:(MDAddPhotoInputView *)addPhotoView
{
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	picker.allowsEditing = YES;
	picker.sourceType = UIImagePickerControllerSourceTypeCamera;

	[self presentViewController:picker animated:YES completion:NULL];
}

- (void)libraryButtonPresedInAddPhotoInputView:(MDAddPhotoInputView *)addPhotoView
{
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	picker.allowsEditing = YES;
	picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

	[self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - ImagePicker



#pragma mark - Notification
- (void)keyboardDidHide:(NSNotification *)notification
{
	[self.chatViewController becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


#pragma mark - View lifeterm
- (void)dealloc
{
	[self.navigationController setDelegate:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
