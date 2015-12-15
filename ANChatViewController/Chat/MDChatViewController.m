//
//  MDChatViewController.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 21/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChatViewController.h"

#import "MDChatCellTableViewDataSource.h"

#import "MDIncomingChatTableViewCell.h"
#import "MDOutgoingChatTableViewCell.h"
#import "MDImageChatTableViewCell.h"
#import "MDServiceChatTableViewCell.h"

#import "ExpandableCellDelegate.h"

#import "MDChatManager.h"
#import "MDUserManager.h"

#import <NYTPhotoViewer/NYTPhotosViewController.h>


@interface MDChatViewController ()<UIScrollViewDelegate, ExpandableCellDelegate, MDImageChatTableViewCellDelegate, MDChatCellTableViewDataSourceDelegate>
@end

@implementation MDChatViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	[[MDUserManager sharedManager].chatManager configureChat];

	[self md_configureTableView];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

- (void)md_configureTableView
{
	self.tableView.dataSource = self.tableViewDataSource;
	self.tableView.delegate = self;
	self.tableView.allowsSelection = NO;
	self.tableView.keyboardDismissMode = self.interactionEnable ? UIScrollViewKeyboardDismissModeInteractive : UIScrollViewKeyboardDismissModeNone;
	[self md_registerCells];
	[self md_configureBackgroundForTableView:self.tableView];
	[self.tableView setContentInset:UIEdgeInsetsMake(42, 0, 12, 0)];

	self.tableView.tableFooterView = [UIView new];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}


- (void)md_configureBackgroundForTableView:(UITableView *)tableView
{
	CAGradientLayer *gradient = [CAGradientLayer layer];
	gradient.frame = self.view.bounds;

	UIColor *firstColor = [UIColor chatVCGradientFirstColor];
	UIColor *lastColor = [UIColor chatVCGradientLastColor];

	gradient.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor], (id)[lastColor CGColor], nil];

	UIView *tableBackgroundView = [[UIView alloc] init];
	[tableBackgroundView.layer insertSublayer:gradient atIndex:1];
	[tableView setBackgroundView:tableBackgroundView];
}

- (void)md_registerCells
{
	[self.tableView registerNib:[MDIncomingChatTableViewCell nib]
		 forCellReuseIdentifier:[MDIncomingChatTableViewCell cellReuseIdentifier]];
	[self.tableView registerNib:[MDOutgoingChatTableViewCell nib]
		 forCellReuseIdentifier:[MDOutgoingChatTableViewCell cellReuseIdentifier]];
	[self.tableView registerNib:[MDImageChatTableViewCell nib]
		 forCellReuseIdentifier:[MDImageChatTableViewCell cellReuseIdentifier]];
	[self.tableView registerNib:[MDServiceChatTableViewCell nib]
		 forCellReuseIdentifier:[MDServiceChatTableViewCell cellReuseIdentifier]];
}

- (void)md_scrollTableViewIfNeeded
{
	NSArray *visibleRows = [self.tableView indexPathsForVisibleRows];
	NSInteger lastSections = [self.tableView numberOfSections] - 1;
	NSInteger lastRow = [self.tableView numberOfRowsInSection:lastSections] - 1;
	NSIndexPath *lastRowIndexPath = [NSIndexPath indexPathForRow:lastRow inSection:lastSections];
	if (![visibleRows containsObject:lastRowIndexPath]) {
		return;
	}
	@try {
		[self.tableView scrollToRowAtIndexPath:lastRowIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
	}
	@catch (NSException *exception) {
	}
}

#pragma mark - Getters
//- (MDChatCellTableViewDataSource *)tableViewDataSource
//{
//	if (_tableViewDataSource == nil) {
//		MDChatCellTableViewDataSource *datasource = [[MDChatCellTableViewDataSource alloc] initWithTableView:self.tableView];
//		_tableViewDataSource = datasource;
//		[_tableViewDataSource setDatasourceDelegates:self];
//	}
//	return _tableViewDataSource;
//}

- (void)setDataSourceForRegistration:(BOOL)registration
{
	MDChatCellTableViewDataSource *datasource = [[MDChatCellTableViewDataSource alloc] initWithTableView:self.tableView];
	datasource.registration = registration;
	self.tableViewDataSource = datasource;
	[self.tableViewDataSource setDatasourceDelegates:self];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)addNewMessage:(NSString *)message
{
	[self.tableViewDataSource sendNewMessageWithText:message];
	[self md_scrollTableViewIfNeeded];
}

- (void)addImageMessage:(UIImage *)image
{
	[self.tableViewDataSource sendImage:image];
	[self md_scrollTableViewIfNeeded];
}

- (void)addNewIncomingMessage:(NSString *)message
{
	[self.tableViewDataSource newIncomingMessageWithText:message];
	[self md_scrollTableViewIfNeeded];
}


#pragma mark - Overrides
- (BOOL)canBecomeFirstResponder
{
	return YES;
}

- (BOOL)resignFirstResponder
{
	self.inputView = nil;
	return [super resignFirstResponder];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [self.tableViewDataSource tableView:tableView
					  heightForCellAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableViewDataSource tableView:tableView willDisplayCell:cell atIndexPath:indexPath];
}

#pragma mark ExpamdableCellDelegate
- (BOOL)chatTableViewCellShouldExpand:(MDChatTableViewCell *)cell
{
	if (self.interactionEnable) {
		return [self.tableViewDataSource chatTableViewCellShouldExpand:cell];
	}
	return NO;
}

- (void)chatTableViewCell:(MDChatTableViewCell *)cell
			  didExpanded:(BOOL)expanded
{
	[self.tableViewDataSource chatTableViewCell:cell didExpand:expanded];
}

#pragma mark - MDImageChatTableViewCellDelegate
- (void)imagechatCell:(MDImageChatTableViewCell *)cell didTappedPhoto:(MDFullScreenPhoto *)photo
{
	NSArray *photos = [NSArray arrayWithObject:photo];

	NYTPhotosViewController *photosViewController = [[NYTPhotosViewController alloc] initWithPhotos:photos];
	photosViewController.rightBarButtonItem = nil;
	photosViewController.delegate = cell;
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	[self presentViewController:photosViewController animated:YES completion:nil];
}

#pragma mark - MDChatCellTableViewDataSourceDelegate
- (void)dataSourceDidFinishPreparingData:(MDChatCellTableViewDataSource *)dataSource hasNewItems:(BOOL)hasNewItems
{
	if (hasNewItems) {
		[self.tableView reloadData];
		[self md_scrollTableViewIfNeeded];
	}
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self.scrollViewDelegate chatViewController:self scrollViewDidScroll:scrollView];
}

@end
