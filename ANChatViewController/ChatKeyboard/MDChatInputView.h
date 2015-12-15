//
//  MDChatInputView.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 05/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDChatInputTextView;
@interface MDChatInputView : UIToolbar

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet MDChatInputTextView *textView;

/** The minimum height based on the intrinsic content size's. */
@property (nonatomic, readonly) CGFloat minimumInputbarHeight;

/** The most appropriate height calculated based on the amount of lines of text and other factors. */
@property (nonatomic, readonly) CGFloat appropriateHeight;

@property (nonatomic, readonly) CGFloat maximumHeight;


@end
