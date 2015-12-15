//
//  MDRegistrationButtonsInputView.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 28/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDInputViewDelegate.h"
#import "MDGroupOfButtons.h"
typedef NS_ENUM(NSInteger, MDButtonsInputViewType)
{
    MDButtonsInputViewTypeSex = 0,
    MDButtonsInputViewTypeChildrens
};

@interface MDRegistrationButtonsInputView : UIView

@property (nonatomic, assign) MDButtonsInputViewType type;
@property (nonatomic, strong) NSArray *titles;
@property (weak, nonatomic) IBOutlet MDGroupOfButtons *buttonsView;
@property (weak, nonatomic) id<MDInputViewDelegate> delegate;

@end
