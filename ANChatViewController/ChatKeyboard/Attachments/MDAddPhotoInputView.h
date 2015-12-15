//
//  MDAddPhotoInputView.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 09/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDGroupOfButtons.h"
@class MDAddPhotoInputView;

@protocol MDAddPhotoInputViewDelegate <NSObject>

-(void)addPhotoInputView:(MDAddPhotoInputView *) addPhotoView buttonPressed:(UIButton *)button;

-(void)makePhotoButonPresedInAddPhotoInputView:(MDAddPhotoInputView *)addPhotoView;
-(void)libraryButtonPresedInAddPhotoInputView:(MDAddPhotoInputView *)addPhotoView;

@end

@interface MDAddPhotoInputView : UIView

@property (weak, nonatomic) IBOutlet MDGroupOfButtons *addPhotoButtons;
@property (weak, nonatomic) id<MDAddPhotoInputViewDelegate> delegate;

@end
