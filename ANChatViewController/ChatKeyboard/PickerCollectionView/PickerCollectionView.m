//
//  PickerCollectionView.m
//  MoiDoctor
//
//  Created by Aleksey Novikov on 30/10/15.
//  Copyright © 2015 Aleksey Novikov. All rights reserved.
//

#import "PickerCollectionView.h"
#import "PickerCollectionViewCell.h"

@interface PickerCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LGHorizontalLinearFlowLayout *collectionViewLayout;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@property (readonly, nonatomic) CGFloat pageWidth;
@property (readonly, nonatomic) CGFloat contentOffset;

@end

@implementation PickerCollectionView

- (void)configureWithArray:(NSArray *)dataArray
{
	self.dataArray = dataArray;
	[self configureCollectionView];
}

- (void)configureCollectionView
{

	self.collectionViewLayout = [LGHorizontalLinearFlowLayout layoutConfiguredWithCollectionView:self.collectionView
																						itemSize:CGSizeMake(60, 80)
																			  minimumLineSpacing:0];
	self.collectionViewLayout.minimumScaleFactor = 0.5;
	self.collectionViewLayout.scalingOffset = 120;

	self.collectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:self.collectionViewLayout];
	[self addSubview:self.collectionView];
	self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
	[self layoutCollectionView];

	[self.collectionView registerNib:[UINib nibWithNibName:@"PickerCollectionViewCell" bundle:nil]
		  forCellWithReuseIdentifier:@"PickerCollectionViewCell"];
	self.collectionView.backgroundColor = [UIColor clearColor];
	self.collectionView.showsHorizontalScrollIndicator = NO;
	self.collectionView.showsVerticalScrollIndicator = NO;
	self.collectionView.dataSource = self;
	self.collectionView.delegate = self;

	self.selectedIndexPath = [NSIndexPath indexPathForItem:self.selectedItem inSection:0];
}

#pragma mark - Layout
- (void)layoutCollectionView
{
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|"
																 options:0
																 metrics:nil
																   views:NSDictionaryOfVariableBindings(_collectionView)]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collectionView]|"
																 options:0
																 metrics:nil
																   views:NSDictionaryOfVariableBindings(_collectionView)]];
}

- (void)configureCell:(PickerCollectionViewCell *)cell selected:(BOOL)selected
{
	cell.pickerLabel.textColor = selected ? [UIColor inputTextViewTintColor] : [UIColor darkAppColor];
}

#pragma mark - CollectionView dataSource / delegate


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	PickerCollectionViewCell *cell =
		(PickerCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"PickerCollectionViewCell"
																			 forIndexPath:indexPath];
	cell.pickerLabel.text = [self.dataArray[indexPath.item] stringValue];
	if (indexPath == self.selectedIndexPath) {
		[self configureCell:cell selected:YES];
	} else  {
		[self configureCell:cell selected:NO];
	}
	return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	self.selectedItem = indexPath.item;
	[self scrollToPage:self.selectedItem animated:YES];
}

#pragma mark - Actions
- (void)scrollToPage:(NSUInteger)page animated:(BOOL)animated
{
	CGFloat pageOffset = page * self.pageWidth - self.collectionView.contentInset.left;
	[self.collectionView setContentOffset:CGPointMake(pageOffset, 0) animated:animated];
}

- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated
{
	[self.collectionView selectItemAtIndexPath:indexPath
									  animated:animated
								scrollPosition:UICollectionViewScrollPositionNone];
	self.selectedItem = indexPath.item;
	[self scrollToPage:self.selectedItem animated:animated];
}

- (void)highlightCellAtIndexPath:(NSIndexPath *)indexPath
{
	static NSIndexPath *oldIndexPath;
	PickerCollectionViewCell *oldCell = (PickerCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:oldIndexPath];
	[self configureCell:oldCell selected:NO];
	PickerCollectionViewCell *newCell = (PickerCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
	[self configureCell:newCell selected:YES];
	oldIndexPath = indexPath;
}

- (void)didEndScrolling
{
	CGPoint center = [self convertPoint:self.collectionView.center toView:self.collectionView];
	NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:center];
	[self selectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGPoint center = [self convertPoint:self.collectionView.center toView:self.collectionView];
	NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:center];
	[self highlightCellAtIndexPath:indexPath];

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	if (!scrollView.isTracking)
		[self didEndScrolling];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if (!decelerate)
		[self didEndScrolling];
}

#pragma mark - Convenience

- (CGFloat)pageWidth
{
	return self.collectionViewLayout.itemSize.width + self.collectionViewLayout.minimumLineSpacing;
}

- (CGFloat)contentOffset
{
	return self.collectionView.contentOffset.x + self.collectionView.contentInset.left;
}

- (void)dealloc
{
	self.collectionView.delegate = nil;
	self.collectionView.dataSource = nil;
}


@end
