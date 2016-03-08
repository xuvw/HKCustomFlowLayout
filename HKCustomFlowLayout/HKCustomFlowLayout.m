//
//  HKCustomFlowLayout.m
//  HKCustomFlowLayoutDemo
//
//  Created by heke on 7/3/16.
//  Copyright © 2016年 mhk. All rights reserved.
//

#import "HKCustomFlowLayout.h"

@interface HKCustomFlowLayout ()

@property (nonatomic, strong) NSMutableArray *cellAttributesList;

@property (nonatomic, assign) CGRect         collectionViewBounds;
@property (nonatomic, assign) CGFloat        contentHeight;

@property (nonatomic, assign) CGSize         contentSize;

@end

@implementation HKCustomFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellAttributesList = [NSMutableArray array];
        self.contentHeight = 0;
        
        self.minimumInteritemSpacing = 5;
        self.minimumLineSpacing      = 5;
        self.sectionInset            = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    
//    NSLog(@"HKCustomFlowLayout--init");
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
//    NSLog(@"HKCustomFlowLayout--prepareLayout");
    //do custom things
    self.collectionViewBounds = self.collectionView.bounds;
    self.contentHeight = self.collectionViewBounds.size.height;
    
    [self createLayoutAttributes];
}

- (CGSize)collectionViewContentSize {
//    NSLog(@"HKCustomFlowLayout--collectionViewContentSize");
    return self.contentSize;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"HKCustomFlowLayout--layoutAttributesForItemAtIndexPath");
    return [self.cellAttributesList objectAtIndex:indexPath.item];
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSLog(@"HKCustomFlowLayout--layoutAttributesForElementsInRect");
    return self.cellAttributesList;
}

#pragma mark - create AttributeList
- (void)createLayoutAttributes {
//    NSLog(@"HKCustomFlowLayout--createLayoutAttributes");
    NSInteger count = [self.delegate hk_collectionView:self.collectionView numberOfItemsInSection:0];
    NSInteger index = 0;
    UICollectionViewLayoutAttributes *la = nil;
    CGFloat x = self.sectionInset.left;
    CGFloat y = self.sectionInset.top;
    
    CGRect rt = self.collectionView.bounds;
    
    CGFloat contentWidth = rt.size.width- self.sectionInset.left - self.sectionInset.right;
    
    CGFloat cellRight = 0;
    CGFloat containerRight = rt.size.width- self.sectionInset.right;
    
    NSIndexPath *indexPath = nil;
    CGSize      cellSize   = CGSizeZero;
    CGFloat     maxCellHeight = 0;
    CGFloat     remainderWidth = 0;
    
    while (index<count) {
        indexPath = [NSIndexPath indexPathForItem:index
                                        inSection:0];
        la       = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        [self.cellAttributesList addObject:la];
        
        cellSize = [self.delegate hk_collectionView:self.collectionView sizeForItemAtIndexPath:indexPath];
        
        if (cellSize.height>maxCellHeight) {
            maxCellHeight = cellSize.height;
        }
        
        cellRight = x + cellSize.width;
        remainderWidth = containerRight - x;
        
        if (cellRight > containerRight) {//超出右边界，根据情况进行换行
            
            if (fabs(x - self.sectionInset.left)<0.1) {//当前行为空，cell宽度大于内容宽度,强制改为内容宽度后
                
                cellSize.width = contentWidth;
                la.frame = CGRectMake(x, y, cellSize.width, cellSize.height);
                x += cellSize.width + self.minimumInteritemSpacing;
                
            }else{//当前行非空，先折行，后判断
                
                x = self.sectionInset.left;
                y += maxCellHeight + self.minimumInteritemSpacing;
                
                if (cellSize.width > contentWidth) {
                    cellSize.width = contentWidth;
                }
                
                la.frame = CGRectMake(x, y, cellSize.width, cellSize.height);
                x += cellSize.width + self.minimumInteritemSpacing;
                
                maxCellHeight = cellSize.height;
            }
        }else{//未超出
            
            la.frame = CGRectMake(x, y, cellSize.width, cellSize.height);
            x += cellSize.width + self.minimumInteritemSpacing;
        }
        
        index++;
    }//end of while
    
    y += maxCellHeight + self.sectionInset.bottom;
    
    if (y<rt.size.height) {
        y = rt.size.height;
    }
    
    self.contentSize = CGSizeMake(rt.size.width, y);
}

@end
