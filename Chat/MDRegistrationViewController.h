//
//  MDRegistrationViewController.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 23/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "BaseViewController.h"
#import "MDInputViewDelegate.h"
#import "MDChatViewController.h"
#import "RegistrationInputView.h"

@class MDChatInputView;

@interface MDRegistrationViewController : BaseViewController

@property (nonatomic, strong)  MDChatViewController *chatViewController;

@property (nonatomic, strong) RegistrationInputView *chatInputAccessoryView;
//@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end
