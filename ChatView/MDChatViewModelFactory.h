//
//  MDChatViewModelFactory.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 22/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDMessage.h"

typedef NS_ENUM(NSInteger, MDChatViewModelMessagePositionType)
{
    MDChatViewModelMessagePositionTypeNone = 0,
    MDChatViewModelMessagePositionTypeTop,
    MDChatViewModelMessagePositionTypeMidle,
    MDChatViewModelMessagePositionTypeBottom
};

@protocol MDChatViewModel <NSObject>

-(instancetype)initWithMessage:(MDMessage *)message;
//-(void)configureViewModelWithObject:(id)modelObject;//выборка данных из модели
@end


@interface MDChatViewModelFactory : NSObject

+(id<MDChatViewModel>)chatViewModelWithMessage:(MDMessage *)message;

@end
