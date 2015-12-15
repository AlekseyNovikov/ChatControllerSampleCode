//
//  MDRegistrationDoneInputView.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 02/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDChatInputTextView.h"
#import "MDInputViewDelegate.h"

@interface MDRegistrationDoneInputView : UIView
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) id<MDInputViewDelegate> delegate;

@property (nonatomic, assign) CGFloat backgroundAlpha;

@end
