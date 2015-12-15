//
//  MDChatViewModelFactory.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 22/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChatViewModelFactory.h"

#import "MDChatInOutMessageViewModel.h"
#import "MDChatServiceMessagesViewModel.h"


@implementation MDChatViewModelFactory

+ (id<MDChatViewModel>)chatViewModelWithMessage:(MDMessage *)message
{
	switch (message.type) {
		case MDMessageTypeIncoming:
			return [[MDChatInOutMessageViewModel alloc] initWithMessage:message];
		case MDMessageTypeOutgoing:
			return [[MDChatInOutMessageViewModel alloc] initWithMessage:message];
		case MDMessageTypeService:
			return [[MDChatServiceMessagesViewModel alloc] initWithMessage:message];
		case MDMessageTypeRecomendation:
            //TODO: create recomendation ViewModel
			return [[MDChatInOutMessageViewModel alloc] initWithMessage:message];
	}
}


@end
