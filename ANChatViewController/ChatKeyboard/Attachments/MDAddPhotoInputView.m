//
//  MDAddPhotoInputView.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 09/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDAddPhotoInputView.h"
#import "UIView+MDBorders.h"

@interface MDAddPhotoInputView ()

@property (nonatomic, strong) NSArray * buttonsTitles;

@end

@implementation MDAddPhotoInputView

- (void)awakeFromNib
{
	[self md_configureButtons];
}

- (void)layoutSubviews
{
	[UIView addTopBorderToView:self lineWidth:0.5f color:[UIColor chatInputViewTopBorderColor]];
}

- (NSArray *)buttonsTitles
{
	if (!_buttonsTitles) {
		_buttonsTitles = @[@"Сделать снимок", @"Медиатека"];
	}
	return _buttonsTitles;
}


- (void)md_configureButtons
{
	[self.addPhotoButtons configureWithTitles:self.buttonsTitles buttonHeight:50.f];
	[self.addPhotoButtons addTarget:self
							 action:@selector(buttonSelected:)
				   forControlEvents:UIControlEventValueChanged];


}

- (IBAction)buttonSelected:(MDGroupOfButtons*)groupOfButtons
{
	NSUInteger selectedIndex = groupOfButtons.selectedButtonIndex;
	if (selectedIndex == 0) {
		[self.delegate makePhotoButonPresedInAddPhotoInputView:self];
	} else if (selectedIndex == 1) {
		[self.delegate libraryButtonPresedInAddPhotoInputView:self];
	}
}

@end
