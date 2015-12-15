//
//  RegistrationInputView.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 23/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MDRegistrationInputViewType)
{
    MDRegistrationInputViewPhoneType = 0,
    MDRegistrationInputViewSMSType,
};

@interface RegistrationInputView : UIToolbar



@end
