//
//  MDConversationViewController.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 21/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "BaseViewController.h"

@class MDChatInputView;
@class MDChatInputTextView;

@interface MDConversationViewController : BaseViewController

@property (nonatomic, strong) MDChatInputView *chatInputView;
@property (nonatomic, strong) MDChatInputTextView *chatInputTextView;

@property (nonatomic, strong) UIButton *addPhotoButton;
@property (nonatomic, strong) UIButton *sendMessageButton;

@end
