//
//  NSThread+SJGAdditional.h
//  ShowJet
//
//  Created by Vladimir Ryazanov on 27/03/15.
//  Copyright (c) 2015 Boloid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSThread (SJGAdditional)

+ (void)sjg_performBlockInMainThread:(void(^)(void))block;

@end
