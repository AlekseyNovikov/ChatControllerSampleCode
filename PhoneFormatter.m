//
//  PhoneFormatter.m
//  MoiDoctor
//
//  Created by Roma Bakenbard on 23.09.15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "PhoneFormatter.h"

@implementation PhoneFormatter


- (id)init {
    
    NSArray *ruPhoneFormats = [NSArray arrayWithObjects:
                               @"+# ### ###–##–##", nil];
    NSArray *bankCardsFormats = [NSArray arrayWithObjects:
                               @"#### #### #### ####", nil];
    NSArray *bankCardValidToFormats = [NSArray arrayWithObjects:
                                 @"##/##", nil];
    
    predefinedFormats = [[NSDictionary alloc] initWithObjectsAndKeys:
                         ruPhoneFormats, @"ru",
                         bankCardsFormats, @"card",
                         bankCardValidToFormats, @"validTo",
                         nil];
    
    return self;
    
}

- (NSString *)format:(NSString *)phoneNumber addMask:(BOOL)addMask {
    NSString *stripped_phone = [self strip:phoneNumber];
    return [self format:stripped_phone withLocale:@"ru" addMask:addMask];
}

- (NSString *)format:(NSString *)phoneNumber {
    return [self format:phoneNumber addMask:NO];
}

- (NSString *)cardFormat:(NSString *)cardNumber {
    return [self format:cardNumber withLocale:@"card" addMask:NO];
}

- (NSString *)cardValidToFormat:(NSString *)dateString {
    return [self format:dateString withLocale:@"validTo" addMask:NO];
}

- (NSString *)format:(NSString *)phoneNumber withLocale:(NSString *)locale addMask:(BOOL)addMask {
    
    NSArray *localeFormats = [predefinedFormats objectForKey:locale];
    
    if(localeFormats == nil) return phoneNumber;
    
    NSString *input = [self strip:phoneNumber];
    
    for(NSString *phoneFormat in localeFormats) {
        
        int i = 0;
        
        NSMutableString *temp = [[NSMutableString alloc] init];
        
        for(int p = 0; temp != nil && i < [input length] && p < [phoneFormat length]; p++) {
            
            unichar c = [phoneFormat characterAtIndex:p];
            
            BOOL required = [self canBeInputByPhonePad:c];
            
            unichar next = [input characterAtIndex:i];
            
            switch(c) {
                    
                case '$':
                    
                    p--;
                    
                    [temp appendFormat:@"%C", next]; i++;
                    
                    break;
                    
                case '#':
                    
                    if(next < '0' || next > '9') {
                        
                        temp = nil;
                        
                        break;
                        
                    }
                    
                    [temp appendFormat:@"%C", next]; i++;
                    
                    break;
                    
                default:
                    
                    if(required) {
                        
                        if(next != c) {
                            
                            temp = nil;
                            
                            break;
                            
                        }
                        
                        [temp appendFormat:@"%C", next]; i++;
                        
                    } else {
                        
                        [temp appendFormat:@"%C", c];
                        
                        if(next == c) i++;
                        
                    }
                    
                    break;
                    
            }
            
        }
        
        if(i == [input length]) {
            if (addMask) {
                return [temp stringByAppendingString:[phoneFormat substringFromIndex:temp.length]];
            } else {
                return temp;
            }
            
        }
        
    }
    
    return input;
    
}



- (NSString *)strip:(NSString *)phoneNumber {
    
    NSMutableString *res = [[NSMutableString alloc] init];
    
    for(int i = 0; i < [phoneNumber length]; i++) {
        
        unichar next = [phoneNumber characterAtIndex:i];
        
        if([self canBeInputByPhonePad:next])
            
            [res appendFormat:@"%C", next];
        
    }
    
    return res;
    
}



- (BOOL)canBeInputByPhonePad:(char)c {
    if(c >= '0' && c <= '9') return YES;
    
    return NO;
    
}

@end
