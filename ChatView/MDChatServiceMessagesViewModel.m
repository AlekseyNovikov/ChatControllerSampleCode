//
//  MDChatServiceMessagesViewModel.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 21/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChatServiceMessagesViewModel.h"

@implementation MDChatServiceMessagesViewModel

- (NSString *)linkText
{
    if (!_linkText) {
        _linkText = self.message.link;
    }
    return _linkText;
}

@end
