//
//  MDAPIKeys.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 26/11/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#ifndef MDAPIKeys_h
#define MDAPIKeys_h
//request
static NSString *const MDUserGETParameterToken = @"auth_key";
static NSString *const MDUserGETParameterPhone = @"phone";
static NSString *const MDUserGETParameterSmsPassword = @"password";


static NSString *const MDChatGETParameterPrevMessageID = @"prev_id";
static NSString *const MDChatGETParameterMessagesCount = @"count";


//responce
static NSString *const MDResponceJSONKeySuccess = @"success";
static NSString *const MDResponceJSONKeyMessage = @"message";

//User
static NSString *const MDResponceJSONKeyUser = @"patient";
static NSString *const MDResponseJSONKeyAuthCode = @"auth-code";


//userProfile
static NSString *const MDUserJSONKeyToken = @"token";
static NSString *const MDUserJSONKeyID = @"id";
static NSString *const MDUserJSONKeyName = @"name";
static NSString *const MDUserJSONKeyPhone = @"phone";
static NSString *const MDUserJSONKeyMail = @"email";
static NSString *const MDUserJSONKeyGender = @"gender";
static NSString *const MDUserJSONKeyPregnansy = @"pregnant_weeks";
static NSString *const MDUserJSONKeyBirthday = @"birthday";
static NSString *const MDUserJSONKeyChildrens = @"childs";
static NSString *const MDUserJSONKeyDoctor = @"current_doctor";
static NSString *const MDUserJSONKeyTarif = @"current_tariff";

//doctor info
static NSString *const MDDoctorJSONKeyID = @"id";
static NSString *const MDDoctorJSONKeyPhoto = @"photo_link";
static NSString *const MDDoctorJSONKeyFirstName = @"first_name";
static NSString *const MDDoctorJSONKeyLastName = @"last_name";
static NSString *const MDDoctorJSONKeyMiddleName = @"middle_name";
static NSString *const MDDoctorJSONKeyChildsCount = @"childs_count";
static NSString *const MDDoctorJSONKeySpecialization = @"spezialization";
static NSString *const MDDoctorJSONKeyEducation = @"education";
static NSString *const MDDoctorJSONKeySchoolasticDegree = @"scholastic_degree";
static NSString *const MDDoctorJSONKeyExperience = @"experience";
static NSString *const MDDoctorJSONKeyBirthday = @"birthday";
static NSString *const MDDoctorJSONKeyReview = @"reviews";
static NSString *const MDDoctorJSONKeyReviewText = @"review";
static NSString *const MDDoctorJSONKeyReviewAuthor = @"author";

//childs
static NSString *const MDChildrenJSONKeyID = @"id";
static NSString *const MDChildrenJSONKeyName = @"name";
static NSString *const MDChildrenJSONKeyGender = @"gender";
static NSString *const MDChildrenJSONKeyBirthday = @"birthday";

//tarif
static NSString *const MDTarifJSONKeyID = @"id";
static NSString *const MDTarifJSONKeyPhotoCount = @"photoCount";
static NSString *const MDTarifJSONKeyPrice = @"price";
static NSString *const MDTarifJSONKeyResponceTime = @"responseTime";
static NSString *const MDTarifJSONKeyTitle = @"title";

//chat
static NSString *const MDResponceJSONKeyMessages = @"messages";

#endif /* MDAPIKeys_h */
