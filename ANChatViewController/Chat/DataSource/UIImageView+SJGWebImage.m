//
//  UIImageView+SJGWebImage.m
//  ShowJet
//
//  Created by Vladimir Ryazanov on 17/04/15.
//  Copyright (c) 2015 Boloid. All rights reserved.
//

#import "UIImageView+SJGWebImage.h"
#import "objc/runtime.h"
//#import "UIImage+ImageEffects.h"
#import "MDWebImageManager.h"

static const NSInteger kDefaultCacheMaxCacheAge = 4096;
static char imageURLKey;

@implementation UIImageView (SJGWebImage)

- (void)setAssociatedURL:(NSURL *)associatedURL {
    objc_setAssociatedObject(self, &imageURLKey, associatedURL, OBJC_ASSOCIATION_RETAIN);
}

- (NSURL *)associatedURL {
    return objc_getAssociatedObject(self, &imageURLKey);
}

- (void)sjg_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder delay:(NSTimeInterval)delay
{
    [self sjg_setImageWithURL:url placeholderImage:placeholder options:SDWebImageRetryFailed progress:nil completed:nil delay:delay];
}

- (void)sjg_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options delay:(NSTimeInterval)delay
{
    [self sjg_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil delay:delay];
}

- (void)sjg_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completionBlock delay:(NSTimeInterval)delay
{
    [self sjg_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completionBlock delay:delay];
}

- (void)sjg_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock delay:(NSTimeInterval)delay
{
    [self sd_cancelCurrentImageLoad];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    self.image = placeholder;
    self.associatedURL = url;
    
    MDWebImageManager *webImageManager = [MDWebImageManager sharedManager];
    webImageManager.imageCache.maxCacheAge = kDefaultCacheMaxCacheAge;
    webImageManager.cacheKeyFilter = ^(NSURL *url) {
        return [url absoluteString];
    };
    
    __block __typeof__(self) weakSelf = self;
    [webImageManager.imageCache queryDiskCacheForKey:webImageManager.cacheKeyFilter(url)
                                             done:^(UIImage *image, SDImageCacheType cacheType) {
                                                 NSURL *curURL = self.associatedURL;
                                                 if ([curURL isEqual:url]) {
                                                     if (image != nil) {
                                                         weakSelf.image = image;
                                                         if (completedBlock) {
                                                                 completedBlock(image, nil, cacheType, url);
                                                         }
                                                     } else {
                                                         NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:4];
                                                         userInfo[@"options"] = @(options);
                                                         if (url != nil) userInfo[@"url"] = url;
                                                         if (progressBlock != nil) userInfo[@"progress"] = progressBlock;
                                                         if (completedBlock != nil) userInfo[@"completed"] = completedBlock;
                                                         if (placeholder != nil) userInfo[@"placeholder"] = placeholder;
                                                         if (delay > 0.000001) {
                                                             [self performSelector:@selector(timerLoadImageWithUserInfo:)
                                                                        withObject:userInfo
                                                                        afterDelay:delay
                                                                           inModes:@[NSRunLoopCommonModes]];
                                                         } else {
                                                             [self timerLoadImageWithUserInfo:userInfo];
                                                         }
                                                         
                                                     }
                                                 }
                                             }];
}

- (void)timerLoadImageWithUserInfo:(id)userInfo
{
    [self sd_setImageWithURL:userInfo[@"url"]
            placeholderImage:userInfo[@"placeholder"]
                     options:[userInfo[@"options"] integerValue]
                   completed:userInfo[@"completed"]];
}


@end
