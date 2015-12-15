//
//  MDChatCellTableViewDataSource.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 21/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MDChatTableViewCell.h"
#import "MDServiceChatTableViewCell.h"
#import "MDOutgoingChatTableViewCell.h"
#import "MDIncomingChatTableViewCell.h"
#import "MDImageChatTableViewCell.h"

@class MDChatCellTableViewDataSource;

@protocol MDChatCellTableViewDataSourceDelegate <NSObject>

//@required
- (void)dataSourceDidFinishPreparingData:(MDChatCellTableViewDataSource *)dataSource hasNewItems:(BOOL)hasNewItems;

@end

@interface MDChatCellTableViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, assign, getter = isRegistration) BOOL registration;
@property (nonatomic, strong) NSMutableArray *chatObjects;
@property (nonatomic, weak) id delegateForCells;
@property (nonatomic, weak) id<MDChatCellTableViewDataSourceDelegate> delegate;

- (id)initWithTableView:(UITableView*)tableView;
- (void)setDatasourceDelegates:(id)delegate;

///DelegatesMethods
- (CGFloat)tableView:(UITableView *)tableView heightForCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

///ExpandableCell
- (BOOL)chatTableViewCellShouldExpand:(MDChatTableViewCell *)cell;
- (void)chatTableViewCell:(MDChatTableViewCell *)cell didExpand:(BOOL)expand;

- (void)startTimerIfNeeded;


- (void)sendImage:(UIImage *)image;
- (void)sendNewMessageWithText:(NSString *)messageText;
- (void)newIncomingMessageWithText:(NSString *)messageText;

@end


