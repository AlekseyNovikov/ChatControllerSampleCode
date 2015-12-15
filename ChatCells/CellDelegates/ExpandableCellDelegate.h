//
//  ExpandableCellDelegate.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 23/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MDChatTableViewCell;

@protocol ExpandableCellDelegate <NSObject>

@optional

- (BOOL)chatTableViewCellShouldExpand:(MDChatTableViewCell *)cell;
- (void)chatTableViewCell:(MDChatTableViewCell *)cell didExpanded:(BOOL)expanded;

@end
