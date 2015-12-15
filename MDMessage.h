//
//  MDMessage.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 12/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//
typedef NS_ENUM (NSInteger, MDMessageType)
{
	MDMessageTypeIncoming = 0,
	MDMessageTypeOutgoing,
	MDMessageTypeService,
	MDMessageTypeRecomendation
};

typedef NS_ENUM (NSInteger, MDMessageStaus)
{
	MDMessageStausPending = 0,
	MDMessageStausSent,
	MDMessageStausDelivered,
	MDMessageStausSeen
};

@class MDChat;
@interface MDMessage : RLMObject<EKMappingProtocol>

@property (nullable, nonatomic, readonly) MDChat *chat;

@property(nonatomic, assign) MDMessageType type;
@property(nonatomic, assign) NSInteger messageID;
@property(nonatomic, assign) NSInteger localMessageID;
@property(nullable, nonatomic, strong) NSDate *messageDate;

@property(nullable, nonatomic, strong) NSString *text;

@property(nullable, nonatomic, strong) NSString *link;
@property(nullable, nonatomic, strong) NSString *linkURL;

@property(nullable, nonatomic, strong) UIImage  *image;
@property(nullable, nonatomic, strong) NSString *imageURL;

@property(nonatomic, assign) MDMessageStaus status;

@end

RLM_ARRAY_TYPE(MDMessage)