//
//  MDDoctor.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 12/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDDoctor.h"
#import "NSDate+MDApplicationDate.h"
/*
   @property (nonatomic, assign) NSInteger docortID;
   @property (nonatomic, strong) NSString *firstName;
   @property (nonatomic, strong) NSString *lastName;
   @property (nonatomic, strong) NSString *middleName;
   @property (nonatomic, strong) NSDate   *birthday;
   @property (nonatomic, strong) NSString *photoURL;
   @property (nonatomic, strong) NSString *education;
   @property (nonatomic, strong) NSString *scholasticDegree;
   @property (nonatomic, strong) NSString *specialization;
   @property (nonatomic, assign) NSInteger experience;
   @property (nonatomic, assign) NSInteger childsCount;
 */

@implementation MDDoctor

+ (EKObjectMapping *)objectMapping
{
	return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
				[mapping mapPropertiesFromDictionary:@{
					 MDDoctorJSONKeyID                : @"doctorID",
					 MDDoctorJSONKeyPhoto             : @"photoURL",
					 MDDoctorJSONKeyFirstName         : @"firstName",
					 MDDoctorJSONKeyLastName          : @"lastName",
					 MDDoctorJSONKeyMiddleName        : @"middleName",
					 MDDoctorJSONKeyChildsCount       : @"childsCount",
					 MDDoctorJSONKeySpecialization    : @"specialization",
					 MDDoctorJSONKeyEducation         : @"education",
					 MDDoctorJSONKeySchoolasticDegree : @"scholasticDegree",
					 MDDoctorJSONKeyExperience        : @"experience"
				 }];
				[mapping mapKeyPath:MDDoctorJSONKeyBirthday toProperty:@"birthday" withDateFormatter:[NSDate md_calendarDateServerFormatter]];
				[mapping hasOne:[MDDoctorReview class] forKeyPath:MDDoctorJSONKeyReview forProperty:@"review"];
			}];
}


#pragma mark - Realm
+ (NSString *)primaryKey
{
	return @"doctorID";
}


@end

@implementation MDDoctorReview

+ (EKObjectMapping *)objectMapping
{
	return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
				[mapping mapPropertiesFromDictionary:@{
					 MDDoctorJSONKeyReviewText   : @"text",
					 MDDoctorJSONKeyReviewAuthor : @"author"
				 }];
			}];
}

#pragma mark - Realm
+ (NSString *)primaryKey
{
	return @"author";
}

@end
