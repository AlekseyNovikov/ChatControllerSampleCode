//
//  MDRegistrationPregnancyAgeInputView.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 30/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "PickerCollectionView.h"
#import "MDInputViewDelegate.h"

@interface MDRegistrationPregnancyAgeInputView : UIView

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet PickerCollectionView *pickerCollectionView;

@property (weak, nonatomic) id<MDInputViewDelegate> delegate;

@end
