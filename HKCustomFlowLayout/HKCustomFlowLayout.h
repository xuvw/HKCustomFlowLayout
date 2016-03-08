//
//  HKCustomFlowLayout.h
//  HKCustomFlowLayoutDemo
//
//  Created by heke on 7/3/16.
//  Copyright © 2016年 mhk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HKCustomFlowLayoutDelegate <NSObject,UICollectionViewDelegateFlowLayout>

@required

- (NSInteger)hk_collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger *)section;
/**
 代理先返回原始值，layout根据情况进行调整
 */
- (CGSize)hk_collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HKCustomFlowLayout : UICollectionViewLayout

/*
 default:{5,5,5,5}
 */
@property (nonatomic, assign) UIEdgeInsets   sectionInset;
/*
 default:5
 */
@property (nonatomic, assign) CGFloat        minimumLineSpacing;
/*
 default:5
 */
@property (nonatomic, assign) CGFloat        minimumInteritemSpacing;

@property (nonatomic, weak) id<HKCustomFlowLayoutDelegate> delegate;

@end
