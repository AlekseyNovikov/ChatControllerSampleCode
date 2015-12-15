//
//  MDUser.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 17/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDUser.h"
#import "MDDoctor.h"
#import "MDChildren.h"

#import "NSDate+MDApplicationDate.h"

/*
   @property (nonatomic, assign) NSInteger userID;
   @property (nonatomic, strong) NSString *auth_tocken;
   @property (nonatomic, strong) NSString *firstName;
   @property (nonatomic, strong) NSString *lastName;
   @property (nonatomic, strong) NSString *phoneNumber;
   @property (nonatomic, strong) NSString *email;
   @property (nonatomic, strong) NSString *gender;
   @property (nonatomic, strong) NSDate   *birthday;
   @property (nonatomic, strong) NSArray  *childrens;
   @property (nonatomic, strong) MDDoctor *doctor;
   @property (nonatomic, assign) NSInteger pregnantWeeks;
 */

@implementation MDUser

+ (EKObjectMapping *)objectMapping
{
	return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
				[mapping mapPropertiesFromDictionary:@{
					 MDUserJSONKeyID : @"userID",
					 MDUserJSONKeyToken : @"authTocken",
					 MDUserJSONKeyName : @"firstName",
					 MDUserJSONKeyPhone : @"phoneNumber",
					 MDUserJSONKeyMail : @"email",
					 MDUserJSONKeyGender : @"gender",
					 MDUserJSONKeyPregnansy : @"pregnantWeeks"
				 }];
				[mapping mapKeyPath:MDUserJSONKeyBirthday toProperty:@"birthday" withDateFormatter:[NSDate md_calendarDateServerFormatter]];

				[mapping hasMany:[MDChildren class] forKeyPath:MDUserJSONKeyChildrens forProperty:@"childrens"];
				[mapping hasOne:[MDDoctor class] forKeyPath:MDUserJSONKeyDoctor forProperty:@"doctor"];
//        [mapping hasOne:<#(__unsafe_unretained Class)#> forKeyPath:<#(NSString *)#>]
			}];
}

+ (void)saveUser:(MDUser *)user
{
	RLMRealm *realm = [RLMRealm defaultRealm];
	[realm beginWriteTransaction];
	[MDUser createOrUpdateInRealm:realm withValue:user];
	[realm commitWriteTransaction];
}

#pragma mark - Realm
+ (NSString *)primaryKey
{
	return @"userID";
}
@end
