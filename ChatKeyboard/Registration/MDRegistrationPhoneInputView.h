//
//  MDRegistrationPhoneInputView.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 23/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDInputViewDelegate.h"

@interface MDRegistrationPhoneInputView : UIView

@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) id<MDInputViewDelegate> delegate;

@end
