//
//  MDChildren.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 19/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//


@interface MDChildren : RLMObject<EKMappingProtocol>

@property (nonatomic, assign) NSInteger childrenID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSDate *birthday;

@end

RLM_ARRAY_TYPE(MDChildren)