//
//  WTLGridHorizontalCollectionViewLayout.m
//  Pods
//
//  Created by Daarkfish on 27/12/2017.
//
//

#import "WTLGridHorizontalCollectionViewLayout.h"
@interface WTLGridHorizontalCollectionViewLayout()


@property (nonatomic) NSInteger cellCount;
@property (nonatomic) CGSize boundsSize;
@end

@implementation WTLGridHorizontalCollectionViewLayout
-(void) prepareLayout
{
    self.cellCount = [self.collectionView numberOfItemsInSection:0];
    self.boundsSize = self.collectionView.bounds.size;
}

-(CGSize) collectionViewContentSize
{
    NSInteger rowCount = (NSInteger)floorf(self.boundsSize.height / self.itemSize.height);
    NSInteger columnCount = (NSInteger)floorf(self.boundsSize.width / self.itemSize.width);
    NSInteger numberofItems = self.cellCount;
    NSInteger itemsPerPage = rowCount * columnCount;
    NSInteger numberofPages = (NSInteger)ceilf((CGFloat)numberofItems / (CGFloat)itemsPerPage);
    CGSize size = self.boundsSize;
    size.width = numberofPages * self.boundsSize.width;
    return size;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.cellCount];
    
    for (NSUInteger i=0; i< self.cellCount; ++i)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutForAttributesForCellAtIndexPath:indexPath];
        
        [allAttributes addObject:attr];
    }
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self layoutForAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (UICollectionViewLayoutAttributes*)layoutForAttributesForCellAtIndexPath:(NSIndexPath*)indexPath
{
    
    NSInteger row = indexPath.row;
    
    CGRect bounds = self.collectionView.bounds;
    CGSize itemSize = self.itemSize;
    
    NSInteger rowCount = (NSInteger)floorf(bounds.size.height / itemSize.height);
    NSInteger columnCount = (NSInteger)floorf(bounds.size.width / itemSize.width);
    NSInteger itemsPerPage = rowCount * columnCount;
    
    NSInteger columnPosition = row % columnCount;
    NSInteger rowPosition = (row / columnCount) % rowCount;
    NSInteger itemPage = floorf(row / itemsPerPage);
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGRect frame = CGRectZero;
    
    frame.origin.x = itemPage * bounds.size.width + columnPosition * itemSize.width;
    frame.origin.y = rowPosition * itemSize.height;
    frame.size = self.itemSize;
    
    attr.frame = frame;
    
    return attr;
}

#pragma mark Properties

- (void)setItemSize:(CGSize)itemSize
{
    self.itemSize = itemSize;
    [self invalidateLayout];
}


@end
