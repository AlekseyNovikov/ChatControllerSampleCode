//
//  MDChatManager.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 12/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MDChat;
@class MDMessage;
@class MDHTTPRequest;

@interface MDChatManager : NSObject

@property(nonatomic, strong) MDChat *chat;

- (void)configureChat;


- (MDHTTPRequest *)getMessagesAfterMessage:(MDMessage *)lastMessage
									 count:(NSInteger)countOfMessages
								completion:(void (^)(NSArray* messages, MDHTTPRequest *request, NSError *error))completion;

- (MDHTTPRequest *)sendMessageToServer:(MDMessage *)message
							completion:(void (^)(MDMessage *remoteMessage, MDHTTPRequest *request, NSError *error))completion;


- (MDMessage *)createMessageWithText:(NSString *)messageText;
- (MDMessage *)createIncomingMessageWithText:(NSString *)messageText;
- (MDMessage *)createMessageWithImage:(UIImage *)messageImage;

- (void)deleteRealmHistory;


@end
