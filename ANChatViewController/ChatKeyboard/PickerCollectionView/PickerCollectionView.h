//
//  PickerCollectionView.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 30/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "LGHorizontalLinearFlowLayout.h"

@interface PickerCollectionView : UIView

@property (nonatomic, assign) NSUInteger selectedItem;

@property (nonatomic, strong) NSArray *dataArray;

-(void)configureWithArray:(NSArray *)dataArray;
@end
