//
//  MDRegistrationPregnancyAgeInputView.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 30/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDRegistrationPregnancyAgeInputView.h"
#import "UIView+MDBorders.h"

@interface MDRegistrationPregnancyAgeInputView()

@property (nonatomic, strong) NSArray *pickerValues;

@end

@implementation MDRegistrationPregnancyAgeInputView

- (void)awakeFromNib
{
    [self md_commonInit];
    
}

- (void)md_commonInit
{
    [UIView addTopBorderToView:self lineWidth:1.f color:[UIColor chatInputViewTopBorderColor]];
    
    NSMutableArray *weeksArray = [NSMutableArray array];
    for (NSInteger i = 1; i <= 42; i++)
        [weeksArray addObject:[NSNumber numberWithInteger:i]];
    self.pickerValues = [NSArray arrayWithArray:weeksArray];
    
    [self.pickerCollectionView configureWithArray:self.pickerValues];
    
    self.nextButton.layer.borderWidth = 1.f;
    self.nextButton.layer.borderColor = [UIColor chatInputViewTopBorderColor].CGColor;
    self.nextButton.layer.cornerRadius = 4;
    
    [self.nextButton addTarget:self
                        action:@selector(nextButtonPressed:)
              forControlEvents:UIControlEventTouchUpInside];

}

-(IBAction)nextButtonPressed:(UIButton *)button
{
    NSString *selected = [self.pickerValues[self.pickerCollectionView.selectedItem] stringValue];
    [self.delegate inputView:self pickerValueSelected:selected];
}

@end
