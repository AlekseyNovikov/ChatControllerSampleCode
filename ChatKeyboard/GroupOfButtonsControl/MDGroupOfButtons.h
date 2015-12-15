//
//  MDGroupOfButtons.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 29/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

@class MDGroupOfButtons;
@protocol MDGroupOfButtonsDelegate <NSObject>

-(void)groupButtons:(MDGroupOfButtons *)groupButtons didPressedButtonAtIndex:(NSUInteger)index;

@end

@interface MDGroupOfButtons : UIControl

//@property (nonatomic, assign) NSUInteger numberOfButtons;
//@property (nonatomic, assign) CGFloat buttonHeight;

@property (nonatomic, readonly) NSUInteger selectedButtonIndex;
@property (nonatomic, weak) id<MDGroupOfButtonsDelegate> delegate;

-(void)configureWithTitles:(NSArray *)titles buttonHeight:(CGFloat)buttonHeight;

@end
