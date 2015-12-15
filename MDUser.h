//
//  MDUser.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 17/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//


#import "MDChildren.h"

@class MDDoctor;
@class MDChat;
@interface MDUser : RLMObject <EKMappingProtocol>//<NSCoding>

@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, strong) NSString *authTocken;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSDate   *birthday;
@property (nonatomic, strong) MDChat   *chat;
@property  RLMArray<MDChildren>        *childrens;
@property (nonatomic, strong) MDDoctor *doctor;
@property (nonatomic, assign) NSInteger pregnantWeeks;

+ (void)saveUser:(MDUser *)user;

@end
