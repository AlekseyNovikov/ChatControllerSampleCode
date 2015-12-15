//
//  MDImageChatTableViewCell.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 11/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChatInOutTableViewCell.h"
#import "MDFullScreenPhoto.h"
#import <NYTPhotoViewer/NYTPhotosViewController.h>


@class MDImageChatTableViewCell;
@protocol MDImageChatTableViewCellDelegate <NSObject>

- (void)imagechatCell:(MDImageChatTableViewCell *)cell didTappedPhoto:(MDFullScreenPhoto *)photo;

@end

@interface MDImageChatTableViewCell : MDChatInOutTableViewCell<NYTPhotosViewControllerDelegate>

@property (weak, nonatomic) id<MDImageChatTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *attachmentImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingStatusLabelConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topStatusLabelConstraint;

@end
