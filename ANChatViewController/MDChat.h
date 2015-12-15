//
//  MDChat.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 12/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//


#import "MDMessage.h"

@class MDUser;
@interface MDChat : RLMObject

@property (nonatomic, assign) NSInteger chatID;
@property (nonatomic, weak) MDUser *user;
@property  RLMArray<MDMessage *>< MDMessage > *messages;

@end
