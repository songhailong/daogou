//
//  WZCollectionViewController.h
//  TVSearch_Example
//
//  Created by che on 2018/1/19.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZViewController.h"
#import "WZCollectionReusableModel.h"

@interface WZCollectionViewController : WZViewController<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionViewFlowLayout *_flowLayot;
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayot;
@property (nonatomic,assign) NSInteger page;


@property (nonatomic,copy) NSArray<WZCollectionReusableModel *> *dataSource;

-(void)loadFinished;

@end
