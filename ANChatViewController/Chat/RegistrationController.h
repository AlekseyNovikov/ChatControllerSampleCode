//
//  RegistrationController.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 23/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDRegistrationViewController.h"

typedef NS_ENUM (NSInteger, MDRegistrationStep) {
	MDRegistrationStepInit = 0,
	MDRegistrationStepPhone,
	MDRegistrationStepSms,
	MDRegistrationStepSex,
	MDRegistrationStepChildrens,
	MDRegistrationStepPregnancyAge,
	MDRegistrationStepName,
	MDRegistrationStepDone
};

@class RegistrationController;

@protocol RegistrationDelegate <NSObject>

- (void)registrationController:(RegistrationController *)registrationController
			   incomingMessage:(NSString *)message;
- (void)registrationController:(RegistrationController *)registrationController
				   sendMessage:(NSString *)message;

- (void)registrationController:(RegistrationController *)registrationController registrationFinished:(BOOL)finished;

@end


@interface RegistrationController : NSObject <MDChatScrollViewDelegate>

@property(nonatomic, assign) MDRegistrationStep registrationStep;
@property(nonatomic, weak) id<RegistrationDelegate> delegate;

- (instancetype)initWithViewController:(MDRegistrationViewController *)viewController
							  delegate:(id<RegistrationDelegate>)delegate;

@end
