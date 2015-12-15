//
//  MDChatManager.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 12/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChatManager.h"
#import "MDUserManager.h"
#import "MDChat.h"

#import "MDModelManager.h"
//#import "MDNetworkManager.h"

//#import "MDWebImageManager.h"


@interface MDChatManager ()
@property (nonatomic, assign) NSInteger messagesLocalIDCounter;
@end

@implementation MDChatManager

- (void)configureChat
{
	self.chat = [MDChat objectForPrimaryKey:@(0)];
	if (!self.chat) {
		self.chat = [[MDChat alloc] init];
		self.chat.chatID = 0;
		RLMRealm *realm = [RLMRealm defaultRealm];
		[realm beginWriteTransaction];
		[realm addObject:self.chat];
		[realm commitWriteTransaction];
	}

	self.messagesLocalIDCounter = [[[NSUserDefaults standardUserDefaults] valueForKey:@"MDLastMessageLocalID"] integerValue];
}


#pragma mark - Setters / Getters

- (void)setMessagesLocalIDCounter:(NSInteger)messagesLocalIDCounter
{
	if (_messagesLocalIDCounter != messagesLocalIDCounter) {
		[[NSUserDefaults standardUserDefaults] setValue:@(messagesLocalIDCounter) forKey:@"MDLastMessageLocalID"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		_messagesLocalIDCounter = messagesLocalIDCounter;
	}
	return;
}

#pragma mark - Messages

#pragma mark - Creation

- (MDMessage *)createMessageWithText:(NSString *)messageText
{
	MDMessage *newMessage = [[MDMessage alloc]init];
	newMessage.text = messageText;
	newMessage.type = MDMessageTypeOutgoing;
	newMessage.status = MDMessageStausPending;

	return [self createMessage:newMessage];
}

- (MDMessage *)createIncomingMessageWithText:(NSString *)messageText
{
	MDMessage *newMessage = [[MDMessage alloc]init];
	newMessage.text = messageText;
	newMessage.type = MDMessageTypeIncoming;
	newMessage.status = MDMessageStausSeen;

	return [self createMessage:newMessage];
}

- (MDMessage *)createMessageWithImage:(UIImage *)messageImage
{
	MDMessage *newMessage = [[MDMessage alloc]init];
	newMessage.image = messageImage;
	newMessage.text = @"image";
	newMessage.type = MDMessageTypeOutgoing;
	newMessage.status = MDMessageStausPending;

	return [self createMessage:newMessage];
}

- (MDMessage *)createMessage:(MDMessage *)message
{
	message.localMessageID = self.messagesLocalIDCounter + 1;
	self.messagesLocalIDCounter++;

	message.messageDate = [NSDate date];

	RLMRealm *realm = [RLMRealm defaultRealm];
	[realm beginWriteTransaction];
	[self.chat.messages addObject:message];
	[realm commitWriteTransaction];

	return message;

}

#pragma mark - private



- (NSMutableArray *)mapMassagesInChat:(MDChat *)chat FromArray:(NSArray *)rawArray
{
	NSMutableArray *mappedArray = [NSMutableArray new];
	for (id object in rawArray) {

		MDMessage *newMessage = [EKMapper objectFromExternalRepresentation:object withMapping:[MDMessage objectMapping]];
		newMessage.localMessageID = self.messagesLocalIDCounter + 1;
		self.messagesLocalIDCounter++;
		[mappedArray addObject:newMessage];
	}
	return mappedArray;
}

#pragma mark - API methods
/*
   - (MDHTTPRequest *)getAllMessagesFromServerCompletion:(void (^)(NSArray* messages, MDHTTPRequest *request, NSError *error))completion
   {
    return [[MDNetworkManager sharedManager].clientAPI getMessagesStarted:0
                                                                  success:^(MDHTTPRequest *request, id responseObject) {

                NSError *error = request.errorAPI;
                if ([responseObject[MDResponceJSONKeyMessages] isKindOfClass:[NSArray class]]) {
                    NSArray *rawArray = [responseObject objectForKey:MDResponceJSONKeyMessages];
                    if (completion != nil) completion(rawArray, request, error);
                }
            } failure:^(MDHTTPRequest *request, NSError *error) {
                if (completion != nil) completion(nil, request, error);
            }];
   }*/

- (void)getMessagesAfterMessage:(MDMessage *)lastMessage
									 count:(NSInteger)countOfMessages
								completion:(void (^)(NSArray* messages, NSError *error))completion
{
    
    __block NSArray *arr = [self tmpJsonArray];
    __block NSArray *messages = nil;
    __block NSMutableSet *messagesIdSet = [[NSMutableSet alloc]init];
    				[[MDModelManager sharedManager] performModelOperation:^{
    					 RLMRealm *realm = [RLMRealm defaultRealm];
    					 MDChat *chat = [MDChat objectForPrimaryKey:@(0)];
    
                    
    						 messages = [self mapMassagesInChat:chat FromArray:arr];
    						 for (MDMessage *message in messages) {
    							 [messagesIdSet addObject:@(message.localMessageID)];
    							 [realm beginWriteTransaction];
    							 [chat.messages addObject:message];
    							 [realm commitWriteTransaction];
    						 }
    					 
    				 } completion:^{
    	                 //fetch messages with predicat (Chat id's)
    					 NSPredicate *predicate = [NSPredicate predicateWithFormat:@"localMessageID IN %@", messagesIdSet];
    					 NSArray *newMessages = [MDMessage objectsWithPredicate:predicate];//TODO: add sorting
    
    					 if (completion != nil) completion(newMessages,  nil);
    				 }];

//	return [[MDNetworkManager sharedManager].clientAPI getMessagesStarted:lastMessage.messageID
//																	count:countOfMessages
//																  success:^(MDHTTPRequest *request, id responseObject) {
//
//				__block NSError *error = request.errorAPI;
//				__block NSArray *messages = nil;
//				__block NSMutableSet *messagesIdSet = [[NSMutableSet alloc]init];
//				[[MDModelManager sharedManager] performModelOperation:^{
//					 RLMRealm *realm = [RLMRealm defaultRealm];
//					 MDChat *chat = [MDChat objectForPrimaryKey:@(0)];
//
//					 if (error == nil && [responseObject[MDResponceJSONKeyMessages] isKindOfClass:[NSArray class]]) {
//						 NSMutableArray *rawArray = [[responseObject objectForKey:MDResponceJSONKeyMessages] mutableCopy];
//						 [rawArray removeObject:rawArray.firstObject];
//						 messages = [self mapMassagesInChat:chat FromArray:rawArray];
//						 for (MDMessage *message in messages) {
//							 [messagesIdSet addObject:@(message.localMessageID)];
//							 [realm beginWriteTransaction];
//							 [chat.messages addObject:message];
//							 [realm commitWriteTransaction];
//						 }
//					 }
//				 } completion:^{
//	                 //fetch messages with predicat (Chat id's)
//					 NSPredicate *predicate = [NSPredicate predicateWithFormat:@"localMessageID IN %@", messagesIdSet];
//					 NSArray *newMessages = [MDMessage objectsWithPredicate:predicate];//TODO: add sorting
//
//					 if (completion != nil) completion(newMessages, request, error);
//				 }];
//			} failure:^(MDHTTPRequest *request, NSError *error) {
//				if (completion != nil) completion(nil, request, error);
//			}];
}

- (void)sendMessageToServer:(MDMessage *)message
							completion:(void (^)(MDMessage *remoteMessage, NSError *error))completion
{
	NSMutableDictionary *messageDict = [[NSMutableDictionary alloc]initWithDictionary:@{@"text" : message.text}];
	UIImage *messageImage = message.image;
	if (messageImage) {
		NSData *imageData = UIImagePNGRepresentation(message.image);
		NSString *imageBase64String = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
		[messageDict addEntriesFromDictionary:@{@"photo" : imageBase64String,
												@"photoType" : @"png"}];
	}
	NSInteger localMessageID = message.localMessageID;

    completion(message, nil);
//	return [[MDNetworkManager sharedManager].clientAPI sendMessage:messageDict
//														   success:^(MDHTTPRequest *request, id responseObject) {
//				__block NSError *error = request.errorAPI;
//				__block MDMessage *remoteMessage = nil;
//				[[MDModelManager sharedManager] performModelOperation:^{
//					 if (error == nil && [[responseObject objectForKey:MDResponceJSONKeyMessage] isKindOfClass:[NSDictionary class]]) {
//						 MDMessage *localMessage = [MDMessage objectForPrimaryKey:@(localMessageID)];
//						 remoteMessage = [EKMapper objectFromExternalRepresentation:[responseObject objectForKey:MDResponceJSONKeyMessage]
//																		withMapping:[MDMessage objectMapping]];
//						 remoteMessage.localMessageID = localMessage.localMessageID;
//
//						 RLMRealm *realm = [RLMRealm defaultRealm];
//						 [realm beginWriteTransaction];
//						 [MDMessage createOrUpdateInDefaultRealmWithValue:remoteMessage];
//						 [realm commitWriteTransaction];
//
//					 } else if (messageImage) {//если не удалось отправить, изображение сохраняем локально
//						 remoteMessage.imageURL = [self localURLForImage:messageImage withMessage:localMessageID];
//					 }
//
//				 } completion:^{
//					 if (completion != nil) completion(remoteMessage, request, error);
//
//				 }];
//
//			} failure:^(MDHTTPRequest *request, NSError *error) {
//				if (completion != nil) completion(nil, request, error);
//			}];
}




- (void)deleteRealmHistory
{
	[[RLMRealm defaultRealm] beginWriteTransaction];
	[[RLMRealm defaultRealm] deleteObjects:self.chat.messages];
	[[RLMRealm defaultRealm] commitWriteTransaction];

	//TODO: delete localIDCounter;
	self.messagesLocalIDCounter = 0;

}

///tmp method before Network manager
- (NSArray *)tmpJsonArray
{
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"Messages" ofType:@"json"];
    
    NSError * error;
    NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    
    if (error) {
        NSLog(@"Error reading file: %@", error.localizedDescription);
    }
    
    
    NSArray *rawArray = (NSArray*)[NSJSONSerialization
                                   JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding]
                                   options:0 error:NULL];
    
    return rawArray;
}

@end
