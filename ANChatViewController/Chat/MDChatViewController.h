//
//  MDChatViewController.h
//  MoiDoctor
//
//  Created by Aleksey Novikov on 21/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "MDChatInputView.h"
#import "MDChatCellTableViewDataSource.h"

@class MDChatViewController;
@protocol MDChatScrollViewDelegate <NSObject>

- (void)chatViewController:(MDChatViewController *)chatViewController scrollViewDidScroll:(UIScrollView *)scrollView;

@end


@interface MDChatViewController : UITableViewController

@property (nonatomic, strong) MDChatCellTableViewDataSource *tableViewDataSource;

- (void)setDataSourceForRegistration:(BOOL)registration;

@property (nonatomic, weak) id<MDChatScrollViewDelegate> scrollViewDelegate;

@property (nonatomic, strong) UIView *inputAccessoryView;
@property (nonatomic, strong) UIView *inputView;

@property (nonatomic, assign) BOOL interactionEnable;

- (void)addNewMessage:(NSString *)message;
- (void)addImageMessage:(UIImage *)image;
- (void)addNewIncomingMessage:(NSString *)message;



@end
