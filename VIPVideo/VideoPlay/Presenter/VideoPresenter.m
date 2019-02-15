//
//  VideoPresenter.m
//  VIPVideo
//
//  Created by lichanghong on 2/7/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import "VideoPresenter.h"

@interface VideoPresenter()

@end

@implementation VideoPresenter


- (void)startPlayerWithURLString:(NSString *)urlstr
{
    NSURL *videoUrl = [NSURL URLWithString:urlstr];
    self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
    [self.playerItem addObserver:self.interactor forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
//    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    [self.view setPlayer:_player];
    // 添加视频播放结束通知
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
}

- (void)avPlayerStatusFailed
{
    [self.view avPlayerStatusFailed];
}
- (void)avPlayerStatusReadyToPlay
{
    [self.view avPlayerStatusReadyToPlay];
}

- (id<VideoInteractorInputProtocol>)interactor
{
    if (!_interactor) {
        _interactor = [VideoInteractor new];
        [((VideoInteractor*)_interactor) setPresenter:self];
    }
    return _interactor;
}


@end
