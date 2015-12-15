//
//  PickerCollectionViewCell.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 30/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "PickerCollectionViewCell.h"

@implementation PickerCollectionViewCell

- (void)awakeFromNib
{
	[super awakeFromNib];
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)prepareForReuse
{
	self.pickerLabel.textColor = [UIColor blackColor];
}

@end
