//
//  MDChatViewModel.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 01/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChatViewModel.h"
#import "NSDate+MDApplicationDate.h"


@implementation MDChatViewModel

- (instancetype)initWithMessage:(MDMessage *)message
{
	self = [super init];
	if (!self) {
		return nil;
	}
	if (message.image || message.imageURL.length ) {
		self.isMessageWithImage = YES;
	}
	self.message = message;
	self.canBeExpanded = NO;
	self.expanded = NO;
	return self;
}

#pragma mark - Setters
- (void)setPositionType:(MDChatViewModelMessagePositionType)positionType
{
	if (_positionType != positionType) {
		_positionType = positionType;
		if (_positionType == MDChatViewModelMessagePositionTypeTop) {
			self.cellFirst = YES;
		} else {
			self.cellFirst = NO;
		}
	}

}

#pragma mark - Getters
- (NSString *)messageText
{
	if (!_messageText) {
		_messageText = self.message.text;
	}
	return _messageText;
}

- (NSString *)dateTimeText
{
	if (!_dateTimeText) {
		NSDateFormatter *formater = [NSDate md_chatMessageDateToShowFormatter];
		_dateTimeText = [formater stringFromDate:self.message.messageDate];
	}
	return _dateTimeText;
}

/*
   MDMessageStausPending = 0,
    MDMessageStausSent,
    MDMessageStausDelivered,
    MDMessageStausSeen
 */
- (NSString *)statusText
{
	switch (self.message.status) {
		case MDMessageStausPending:
			_statusText = @"";
			break;
		case MDMessageStausSent:
			_statusText = @"Отправлено";
			break;
		case MDMessageStausDelivered:
			_statusText = @"Доставленно";
			break;
		case MDMessageStausSeen:
			_statusText = @"Просмотрено";
			break;
		default:
			break;
	}
	return _statusText;
}

- (UIImage *)image
{
	if (!_image) {
		_image = self.message.image;
	}
	return _image;
}
@end
