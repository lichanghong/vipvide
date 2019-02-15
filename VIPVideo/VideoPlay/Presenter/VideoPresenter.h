//
//  VideoPresenter.h
//  VIPVideo
//
//  Created by lichanghong on 2/7/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoPresenterProtocol.h"
#import <AVFoundation/AVFoundation.h>
#import "VideoPlayerVCProtocol.h"
#import "VideoInteractor.h"
#import "VideoInteractorProtocol.h"

@interface VideoPresenter : NSObject
<VideoPresenterInputProtocol>

@property (nonatomic ,weak) id<VideoPlayerVCOutputProtocol> view;
@property (nonatomic ,strong) id<VideoInteractorInputProtocol> interactor;
@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;

@end


