//
//  MDRegistrationNameInputView.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 02/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDChatInputTextView.h"
#import "MDInputViewDelegate.h"

@interface MDRegistrationNameInputView : UIView
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet MDChatInputTextView *textView;
@property (weak, nonatomic) id<MDInputViewDelegate> delegate;

@end
