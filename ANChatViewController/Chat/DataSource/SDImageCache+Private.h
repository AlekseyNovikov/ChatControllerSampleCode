//
//  SDImageCache+Private.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 30/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "SDImageCache.h"

@interface SDImageCache (PrivateMethods)

- (NSString *)defaultCachePathForKey:(NSString *)key;
- (NSString *)cachedFileNameForKey:(NSString *)key;

@end