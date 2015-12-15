//
//  MDChatCellTableViewDataSource.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 21/09/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChatCellTableViewDataSource.h"

#import "MDChatViewModelFactory.h"
#import "MDChatViewModel.h"

#import "MDChatManager.h"
#import "MDUserManager.h"

@interface MDChatCellTableViewDataSource ()

//@property (nonatomic, strong) NSMutableArray *messagesInSection;
//@property (nonatomic, strong) NSMutableArray *sectionsOfMessages;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *expandedCellIndexPath;
@property (nonatomic, strong) NSTimer *chatTimer;

@property (nonatomic, strong) MDChatManager *chatManager;

@end

@implementation MDChatCellTableViewDataSource

#pragma mark - Getters

- (MDChatManager *)chatManager
{
	return [MDUserManager sharedManager].chatManager;
}

- (NSArray *)configureSectionsFromArray:(NSArray *)array
{
//	NSArray *sortDescriptors = @[[RLMSortDescriptor sortDescriptorWithProperty:@"messageDate" ascending:YES],
//								 [RLMSortDescriptor sortDescriptorWithProperty:@"localMessageID" ascending:YES]];
//	RLMResults *messages = [[MDMessage allObjects] sortedResultsUsingDescriptors:sortDescriptors];

	NSMutableArray *messagesInSection = [NSMutableArray new];
	NSMutableArray *sections = [NSMutableArray new];

	NSDateFormatter *dayFormatter = [[NSDateFormatter alloc]init];
	dayFormatter.dateFormat = @"dd MM yyyy";

	MDChatViewModel *lastMessage = (MDChatViewModel*)[array firstObject];
	NSString *lastDateString = [dayFormatter stringFromDate:lastMessage.message.messageDate];

	for (MDChatViewModel *message in array) {
		NSString *currentDataString = [dayFormatter stringFromDate:message.message.messageDate];

		if ([lastDateString isEqualToString:currentDataString]) {
			[messagesInSection addObject:message];
		} else {
			lastDateString = currentDataString;
			[sections addObject:messagesInSection];
			messagesInSection = @[message].mutableCopy;
		}
	}
	[sections addObject:messagesInSection];

	return sections;
}

#pragma mark - API timer

- (void)startTimerIfNeeded
{
	if (self.isRegistration) return;

	if (self.chatTimer) {
		[self.chatTimer invalidate];
		self.chatTimer = nil;
	}

	NSArray *arr = [self configureSectionsFromArray:nil];

	self.chatTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(chatTick:) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
	if (self.chatTimer) {
		[self.chatTimer invalidate];
		self.chatTimer = nil;
	}
}

- (void)chatTick:(id)sender
{
	[self stopTimer];
	NSArray *sortDescriptors = @[[RLMSortDescriptor sortDescriptorWithProperty:@"messageDate" ascending:NO],
								 [RLMSortDescriptor sortDescriptorWithProperty:@"localMessageID" ascending:NO]];
	MDMessage *latestMessage = [[MDMessage allObjects] sortedResultsUsingDescriptors:sortDescriptors].firstObject;
	[self.chatManager getMessagesAfterMessage:latestMessage
										count:10
								   completion:^(NSArray *messages, MDHTTPRequest *request, NSError *error) {
		 [self showNewMessages:messages];
	     //TODO: возвращать индексы ячеек для анимации
		 [self startTimerIfNeeded];
	 }];
}

- (void)showNewMessages:(NSArray *)messagesArray
{
	NSMutableArray *newMessages = [[NSMutableArray alloc] initWithCapacity:messagesArray.count];
	for (MDMessage *message in messagesArray) {
		MDChatViewModel *vm = [MDChatViewModelFactory chatViewModelWithMessage:message];
		[self md_configureViewModel:vm];
		[newMessages addObject:vm];

	}

	newMessages = [self configureSectionsFromArray:newMessages].mutableCopy;
//	newMessages = [self updatePositionTypesForObjects:newMessages];
	[self.chatObjects addObjectsFromArray:newMessages];
	self.chatObjects = [self updatePositionTypesForObjects:self.chatObjects];
	[self.delegate dataSourceDidFinishPreparingData:self hasNewItems:YES];
//        newMessages = [self updatePositionTypesForObjects:newMessages];
//        [newSections addObject:newMessages];
//    }
//
//
//	[self.chatObjects addObjectsFromArray:newSections];
//	[self.delegate dataSourceDidFinishPreparingData:self hasNewItems:YES];
}

- (void)md_configureViewModel:(MDChatViewModel *)viewModel
{
	switch (viewModel.message.type) {
		case MDMessageTypeIncoming:
			viewModel.reuseIdentifier = [MDIncomingChatTableViewCell cellReuseIdentifier];
			viewModel.canBeExpanded = YES;
			viewModel.expanded = NO;
			break;
		case MDMessageTypeOutgoing:
			viewModel.reuseIdentifier = [MDOutgoingChatTableViewCell cellReuseIdentifier];
			if (viewModel.isMessageWithImage) {
				viewModel.reuseIdentifier = [MDImageChatTableViewCell cellReuseIdentifier];
			}
			viewModel.canBeExpanded = YES;
			viewModel.expanded = NO;
			break;
		case MDMessageTypeService:
			viewModel.reuseIdentifier = [MDServiceChatTableViewCell cellReuseIdentifier];
			break;
		case MDMessageTypeRecomendation:
			break;
	}

}

//- (NSMutableArray *)dataSource
//{
//	NSArray *sortDescriptors = @[[RLMSortDescriptor sortDescriptorWithProperty:@"messageDate" ascending:YES],
//								 [RLMSortDescriptor sortDescriptorWithProperty:@"localMessageID" ascending:YES]];
//	RLMResults *messages = [[MDMessage allObjects] sortedResultsUsingDescriptors:sortDescriptors];
//	_dataSource = (NSMutableArray*)messages;
//	return _dataSource;
//}

#pragma mark - Initialisation

- (id)initWithTableView:(UITableView*)tableView
{
	self = [super init];
	if (self) {
		self.tableView = tableView;
		self.tableView.dataSource = self;
		[self md_commonInit];

	}
	return self;
}

- (void)md_commonInit
{
	self.chatObjects = [[NSMutableArray alloc] init];
}

- (NSMutableArray *)updatePositionTypesForObjects:(NSMutableArray *)objects
{//TODO: need fix
	for (NSArray *section in objects) {
		NSMutableArray *messageGroup;
		for (MDChatViewModel *vm in section) {
			if (vm.message.type == MDMessageTypeService) {
				vm.positionType = MDChatViewModelMessagePositionTypeNone;
				messageGroup = nil;
				continue;
			} else {
				if (!messageGroup.count) {
					vm.positionType = MDChatViewModelMessagePositionTypeTop;
					messageGroup = [NSMutableArray arrayWithObject:vm];
				} else {
					MDChatViewModel *lastObject = messageGroup.lastObject;
					MDChatViewModel *firstObject = messageGroup.firstObject;
					if (lastObject.message.type == vm.message.type) { //cлед сообщение тогоже типа
						lastObject.positionType = MDChatViewModelMessagePositionTypeMidle;
						firstObject.positionType = MDChatViewModelMessagePositionTypeTop;
						vm.positionType = MDChatViewModelMessagePositionTypeBottom;
						[messageGroup addObject:vm];
					} else { // след нового типа
						MDChatViewModel *lastObject = messageGroup.lastObject;
						lastObject.positionType = MDChatViewModelMessagePositionTypeBottom;
						if (messageGroup.count == 1) {
							lastObject.positionType = MDChatViewModelMessagePositionTypeTop;
						}
						[messageGroup removeAllObjects];

						vm.positionType = MDChatViewModelMessagePositionTypeTop;
						[messageGroup addObject:vm];
					}
				}
			}
		}

	}

	return objects;
}

- (void)setDatasourceDelegates:(id)delegate
{
	self.delegate = delegate;
	self.delegateForCells = delegate;
}

#pragma mark - Public

- (void)updateCellsHeight
{
	[self.tableView beginUpdates];
	[self.tableView endUpdates];
}

#pragma mark Helpers
- (id)chatObjectForIndexPath:(NSIndexPath *)indexPath
{
	return self.chatObjects[indexPath.section][indexPath.row];
}

//- (id)chatObjectAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

#pragma mark TableView DataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.chatObjects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return ((NSArray*)self.chatObjects[section]).count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

	MDChatViewModel *viewModel = [self chatObjectForIndexPath:indexPath];

	NSString *reuseIdentifier = viewModel.reuseIdentifier;
	MDChatTableViewCell *cell = (MDChatTableViewCell*)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];

	[cell configureCellWithViewModel:viewModel];
	cell.expandableDelegate = self.delegateForCells;
	if ([cell isKindOfClass:[MDImageChatTableViewCell class]]) {
		((MDImageChatTableViewCell*)cell).delegate = self.delegateForCells;
	}

	return cell;
}

///Delegates
- (CGFloat)tableView:(UITableView *)tableView heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
	MDChatViewModel *viewModel = [self chatObjectForIndexPath:indexPath];

	CGFloat availableWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
	//Get cell class  name back from reuseIdentifier
	Class class = NSClassFromString(viewModel.reuseIdentifier);
	CGFloat height = [class cellHeightForViewModel:viewModel availableWidth: availableWidth];
	return height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	if ([cell isKindOfClass:[MDServiceChatTableViewCell class]]) {
		NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];
		if (indexPath.row == totalRow - 1) {
			((MDServiceChatTableViewCell*)cell).bottomSeparator.alpha = 0.0f;
		} else {
			((MDServiceChatTableViewCell*)cell).bottomSeparator.alpha = 1.0f;
		}
	}
}

///ExpandableCell
- (BOOL)chatTableViewCellShouldExpand:(MDChatTableViewCell *)cell
{
	NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
	MDChatViewModel *viewModel = [self chatObjectForIndexPath:cellIndexPath];
	if (!viewModel.canBeExpanded) {
		return NO;
	}
	return YES;
}

- (void)updateViewCellAtIndexPath:(NSIndexPath *)indexPath
						 expanded:(BOOL)isExpanded
				 updateAppearance:(BOOL)updateAppearance
{
	MDChatViewModel *viewModel = [self chatObjectForIndexPath:indexPath];
	viewModel.expanded = isExpanded;

	UITableViewCell *expendedCell = [self.tableView cellForRowAtIndexPath:indexPath];

	if ([expendedCell isKindOfClass:[MDChatTableViewCell class]]) {
		[(MDChatTableViewCell*)expendedCell configureCellWithViewModel:viewModel
													  updateAppearance:NO];
		if (updateAppearance) {
			[(MDChatTableViewCell*)expendedCell updateAppearanceWithAnimated:YES];
		}
	}
}

- (void)chatTableViewCell:(MDChatTableViewCell *)cell didExpand:(BOOL)expand
{
	if (self.expandedCellIndexPath != nil) {
		[self updateViewCellAtIndexPath:self.expandedCellIndexPath expanded:NO updateAppearance:YES];
	}

	NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
	if (self.expandedCellIndexPath != cellIndexPath) {
		[self updateViewCellAtIndexPath:cellIndexPath expanded:expand updateAppearance:NO];
	}

	self.expandedCellIndexPath = expand == YES ? cellIndexPath : nil;
	[self updateCellsHeight];
}

#pragma mark - Send message
- (void)sendImage:(UIImage *)image
{
	MDMessage *message = [[MDUserManager sharedManager].chatManager createMessageWithImage:image];
	[self stopTimer];
	[[MDUserManager sharedManager].chatManager sendMessageToServer:message
														completion:^(MDMessage *remoteMessage, MDHTTPRequest *request, NSError *error) {

		 [self showNewMessages:@[remoteMessage]];
		 [self startTimerIfNeeded];
	 }];

}

- (void)sendNewMessageWithText:(NSString *)messageText
{
	MDMessage *message = [[MDUserManager sharedManager].chatManager createMessageWithText:messageText];
	if (self.isRegistration) {
		[self showNewMessages:@[message]];
		return;
	}
	[self stopTimer];
	[[MDUserManager sharedManager].chatManager sendMessageToServer:message
														completion:^(MDMessage *remoteMessage, MDHTTPRequest *request, NSError *error) {

		 [self showNewMessages:@[remoteMessage]];
		 [self startTimerIfNeeded];
	 }];


}

- (void)newIncomingMessageWithText:(NSString *)messageText
{
	MDMessage *message = [[MDUserManager sharedManager].chatManager createIncomingMessageWithText:messageText];
	[self showNewMessages:@[message]];
}

- (void)dealloc
{
	[self stopTimer];
}

@end
