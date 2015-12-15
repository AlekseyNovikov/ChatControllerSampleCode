//
//  MDChatInputTextView.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 05/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const MDTextViewTextWillChangeNotification;
//UIKIT_EXTERN NSString * const MDTextViewContentSizeDidChangeNotification;

@interface MDChatInputTextView : UITextView

/** The placeholder text string. Default is nil. */
@property (nonatomic, copy) NSString *placeholder;

/** The placeholder color. Default is lightGrayColor. */
@property (nonatomic, copy) UIColor *placeholderColor;

/** Maximum number of lines before scroll */
@property (nonatomic, readwrite) NSUInteger maxNumberOfLines;

/** The current displayed number of lines. */
@property (nonatomic, readonly) NSUInteger numberOfLines;

/** YES if the text view is and can still expand it self, depending if the maximum number of lines are reached. */
@property (nonatomic, readonly) BOOL isExpanding;

@end
