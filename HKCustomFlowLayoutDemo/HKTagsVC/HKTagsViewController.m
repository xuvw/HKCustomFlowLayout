//
//  HKTagsViewController.m
//  HKCustomFlowLayoutDemo
//
//  Created by heke on 8/3/16.
//  Copyright © 2016年 mhk. All rights reserved.
//

#import "HKTagsViewController.h"
#import "HKCustomFlowLayout.h"
#import "HKTagsCollectionViewCell.h"

@interface HKTagsViewController ()
<HKCustomFlowLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HKCustomFlowLayout *layout;

@end

@implementation HKTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"自定义流布局";
    
    self.layout = [[HKCustomFlowLayout alloc] init];
    self.layout.delegate = self;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    UINib *xib = [UINib nibWithNibName:@"HKTagsCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:xib forCellWithReuseIdentifier:@"HKTagsCollectionViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HKCustomFlowlayout
- (NSInteger)hk_collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger *)section {
    return 1000;
}
/**
 代理先返回原始值，layout根据情况进行调整
 */
- (CGSize)hk_collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect rt = collectionView.bounds;
    CGFloat width = (rt.size.width -(2+4)*5)/5.0;//40 + arc4random()%40;
    CGFloat height = 30;
    return CGSizeMake(width, height);
}

#pragma mark - UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1000;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HKTagsCollectionViewCell *cell = (HKTagsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HKTagsCollectionViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = @(indexPath.item).description;
    return cell;
}

@end
