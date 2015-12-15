//
//  MDChatViewModel.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 01/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDChatViewModelFactory.h"

@interface MDChatViewModel : NSObject <MDChatViewModel>

@property (nonatomic, strong) MDMessage *message;

@property (nonatomic, assign) Class cellClass;
@property (nonatomic, strong) NSString *reuseIdentifier;

@property (nonatomic, strong) NSString *messageText;
@property (nonatomic, strong) NSString *dateTimeText;
@property (nonatomic, strong) NSString *statusText;
@property (nonatomic, assign) BOOL isMessageWithImage;
@property (nonatomic, strong) UIImage *image;


@property (nonatomic, assign) MDChatViewModelMessagePositionType positionType;
@property (nonatomic, getter = isCellFirst) BOOL cellFirst;


@property (nonatomic, assign) BOOL canBeExpanded;
@property (nonatomic, assign) BOOL expanded;

@end
