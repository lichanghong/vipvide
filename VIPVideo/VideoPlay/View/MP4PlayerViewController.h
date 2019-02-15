//
//  MP4PlayerViewController.h
//  VIPVideo
//
//  Created by lichanghong on 2/7/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerView.h"
#import "VideoPresenter.h"
#import <UIView+Toast.h>

NS_ASSUME_NONNULL_BEGIN

@interface MP4PlayerViewController : UIViewController <VideoPlayerVCOutputProtocol>
@property (nonatomic ,strong) PlayerView *playerView;
@property (nonatomic ,strong) VideoPresenter *presenter;


@end

NS_ASSUME_NONNULL_END
