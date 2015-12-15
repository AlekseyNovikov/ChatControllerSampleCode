//
//  UIImageView+SJGWebImage.h
//  ShowJet
//
//  Created by Vladimir Ryazanov on 17/04/15.
//  Copyright (c) 2015 Boloid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (SJGWebImage)

@property(nonatomic, strong) NSURL *associatedURL;

- (void)sjg_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder delay:(NSTimeInterval)delay;
- (void)sjg_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options delay:(NSTimeInterval)delay;
- (void)sjg_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock delay:(NSTimeInterval)delay;
- (void)sjg_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock delay:(NSTimeInterval)delay;

@end
