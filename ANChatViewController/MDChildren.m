//
//  MDChildren.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 19/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChildren.h"

#import "NSDate+MDApplicationDate.h"
/*
   @property (nonatomic, assign) NSInteger childrenID;
   @property (nonatomic, strong) NSString *name;
   @property (nonatomic, strong) NSString *gender;
   @property (nonatomic, strong) NSDate *birthday;
 */


@implementation MDChildren

+ (EKObjectMapping *)objectMapping
{
	return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
				[mapping mapPropertiesFromDictionary:@{
					 MDChildrenJSONKeyID : @"childrenID",
					 MDChildrenJSONKeyName : @"name",
					 MDChildrenJSONKeyGender : @"gender"
				 }];
				[mapping mapKeyPath:MDChildrenJSONKeyBirthday toProperty:@"birthday" withDateFormatter:[NSDate md_calendarDateServerFormatter]];
			}];

}

#pragma mark - Realm
+ (NSString *)primaryKey
{
	return @"childrenID";
}
@end
