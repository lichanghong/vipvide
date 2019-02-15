//
//  MP4PlayerViewController.m
//  VIPVideo
//
//  Created by lichanghong on 2/7/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import "MP4PlayerViewController.h"
#import <Masonry.h>
#import <MBProgressHUD.h>
#import "PlayerActionView.h"
#import "WebViewController.h"
#import "PreLoadWebView.h"

@interface MP4PlayerViewController ()
@property (nonatomic ,strong) id playbackTimeObserver;
@property (nonatomic ,strong) MBProgressHUD *progressHUD;
@property (nonatomic ,strong) PlayerActionView *playerActionView;
@property (nonatomic,strong) PreLoadWebView *preloadView;

@end

@implementation MP4PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.playerView];
    [self.view addSubview:self.playerActionView];
    
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.playerActionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
   
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.navigationController.childViewControllers.count == 1) {
       NSString *iqiyiURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"iqiyiURL"];
        //第一层解析出url
       NSString *url = [NSString stringWithFormat:@"http://app.baiyug.cn:2019/vip/index.php?url=%@",iqiyiURL];
       __weak typeof(self) weakSelf = self;
        WebViewController *webViewController = [[WebViewController alloc]init];
        [webViewController webViewLoadURL:url completion:^(NSString * _Nonnull html) {          
        }];
        [weakSelf.navigationController pushViewController:webViewController animated:YES];

        self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.progressHUD.label.text = @"加载中...";
    }
}



- (void)setPlayer:(AVPlayer *)player
{
    self.playerView.player = player;
}
- (void)avPlayerStatusFailed
{
    self.progressHUD.label.text = @"视频加载失败";
    [self.progressHUD hideAnimated:YES afterDelay:2];
    [self.view makeToast:@"视频加载失败,重新选片"];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        WebViewController *webViewController = [[WebViewController alloc]init];
        [webViewController webViewLoadURL:@"http://m.iqiyi.com/"];
        [weakSelf.navigationController pushViewController:webViewController animated:YES];
    });
}
- (void)avPlayerStatusReadyToPlay
{
    [self.progressHUD hideAnimated:YES];
    __weak typeof(self) weakSelf = self;
    self.playbackTimeObserver = [self.playerView.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        //        CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;// 计算当前在第几秒
        //        [weakSelf.videoSlider setValue:currentSecond animated:YES];
        //        NSString *timeString = [self convertTime:currentSecond];
        //        weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@/%@",timeString,_totalTime];
    }];
}
- (PlayerView *)playerView
{
    if (!_playerView) {
        _playerView = [[PlayerView alloc]initWithFrame:self.view.bounds];
    }
    return _playerView;
}

- (VideoPresenter *)presenter
{
    if (!_presenter) {
        _presenter = [[VideoPresenter alloc]init];
        _presenter.view = self;
    }
    return _presenter;
}

- (PlayerActionView *)playerActionView
{
    if (!_playerActionView) {
        _playerActionView = [[PlayerActionView alloc]initWithFrame:self.view.bounds];
    }
    return _playerActionView;
}

@end
