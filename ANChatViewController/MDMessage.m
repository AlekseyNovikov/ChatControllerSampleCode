//
//  MDMessage.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 12/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChat.h"
#import "MDMessage.h"
#import "NSDate+MDApplicationDate.h"
/*
   @property(nonatomic, assign) MDMessageType type;
   @property(nonatomic, assign) NSInteger messageID;
   @property(nonatomic, strong) NSDate *messageDate;

   @property(nullable, nonatomic, strong) NSString *text;

   @property(nullable, nonatomic, strong) NSString *link;
   @property(nullable, nonatomic, strong) NSString *linkURL;

   @property(nullable, nonatomic, strong) UIImage  *image;
   @property(nullable, nonatomic, strong) NSString *remoteImageURL;
   @property(nullable, nonatomic, strong) NSString *localImageURl;//может не надо?

   @property(nonatomic, assign) MDMessageStaus status;

   @property(nonatomic, weak) MDMessage *prevMessage;

 */

@implementation MDMessage

+ (EKObjectMapping *)objectMapping
{
	return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
				NSDictionary *messageType = @{@"incoming"   : @(MDMessageTypeIncoming),
											  @"outgoing"   : @(MDMessageTypeOutgoing),
											  @"service"    : @(MDMessageTypeService)};

				NSDictionary *messageStatus = @{@"pending"      : @(MDMessageStausPending),
												@"sent"         : @(MDMessageStausSent),
												@"delivered"    : @(MDMessageStausDelivered),
												@"seen"         : @(MDMessageStausSeen)};

				[mapping mapPropertiesFromDictionary:@{@"id"   : @"messageID",
													   @"text" : @"text",
													   @"photo" : @"imageURL"}];

				[mapping mapKeyPath:@"type" toProperty:@"type" withValueBlock:^id (NSString *key, id value) {
					 return messageType[value];
				 } reverseBlock:^id (id value) {
					 return [messageType allKeysForObject:value].lastObject;
				 }];

				[mapping mapKeyPath:@"status" toProperty:@"status" withValueBlock:^id (NSString *key, id value) {
					 return messageStatus[value];
				 } reverseBlock:^id (id value) {
					 return [messageStatus allKeysForObject:value].lastObject;
				 }];
				[mapping mapKeyPath:@"date" toProperty:@"messageDate" withValueBlock:^id (NSString *key, id value) {
					 return [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[value intValue]];
				 }];

			}];
}

+ (NSArray *)ignoredProperties
{
	return @[@"image"];
}

+ (NSString *)primaryKey
{
	return @"localMessageID";
}

-(MDChat *)chat
{
    return [self linkingObjectsOfClass:@"MDChat" forProperty:@"messages"].firstObject;
}

@end
