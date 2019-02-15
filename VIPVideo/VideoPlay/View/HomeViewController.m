//
//  HomeViewController.m
//  VIPVideo
//
//  Created by lichanghong on 2/14/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import "HomeViewController.h"
#import "VideoModel.h"
#import "HomeCollectionViewCell.h"
#import <SDWebImage.h>
#import "WebViewController.h"

#define kScreenWidth (UIScreen.mainScreen.bounds.size.width)

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,copy) NSArray *dataSources;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view.
    
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.minimumLineSpacing = 20;
        flowLayout.minimumInteritemSpacing = 20;
        flowLayout.itemSize = CGSizeMake(kScreenWidth/4.0-10, kScreenWidth/6.0);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 50, self.view.bounds.size.width-20, self.view.bounds.size.height) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:HomeCollectionViewCell.class forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    VideoModel *model = self.dataSources[indexPath.item];
    [cell.mImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideoModel *model = self.dataSources[indexPath.item];
    WebViewController *webViewController = [[WebViewController alloc]init];
    [webViewController webViewLoadURL:model.targetURL];
    [self.navigationController pushViewController:webViewController animated:YES];
}


- (void)initDataSource
{
    NSArray *imageurls = @[
                @"http://app.baiyug.cn:2019/img/youkulogo.png",
                @"http://app.baiyug.cn:2019/img/iqiyilogo.png",
                @"http://app.baiyug.cn:2019/img/hunantvlogo.png",
                @"http://app.baiyug.cn:2019/img/letvlogo.png",
                @"http://app.baiyug.cn:2019/img/qq.png",
                @"http://app.baiyug.cn:2019/img/sohulogo.png",
                @"http://app.baiyug.cn:2019/img/pptvlogo.png"                           ];
    NSArray *names = @[
                           @"优酷",
                           @"爱奇艺",
                           @"芒果TV",
                           @"乐视",
                           @"腾讯视频",
                           @"搜狐",
                           @"PPTV"
                           ];
    NSArray *targetURLS = @[
                       @"https://movie.youku.com/",
                       @"https://www.iqiyi.com/dianying/",
                       @"https://www.mgtv.com/movie/",
                       @"http://movie.le.com/",
                       @"https://v.qq.com/channel/movie",
                       @"https://tv.sohu.com/movie/",
                       @"http://movie.pptv.com/"
                       ];
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i=0; i<imageurls.count; i++) {
        VideoModel *model = [VideoModel new];
        model.imageUrl = imageurls[i];
        model.name  = names[i];
        model.targetURL = targetURLS[i];
        [mArr addObject:model];
    }
    self.dataSources = mArr;
}

@end
