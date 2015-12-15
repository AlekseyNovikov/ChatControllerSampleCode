//
//  MDDoctor.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 12/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//


@class MDDoctorReview;
@interface MDDoctor : RLMObject<EKMappingProtocol>

@property (nonatomic, assign) NSInteger doctorID;
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
@property (nonatomic, strong) MDDoctorReview *review;

@end

@interface MDDoctorReview : RLMObject<EKMappingProtocol>

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *author;

@end
