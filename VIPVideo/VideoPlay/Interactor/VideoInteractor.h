//
//  VideoInteractor.h
//  VIPVideo
//
//  Created by lichanghong on 2/6/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoInteractorProtocol.h"
#import <AVFoundation/AVFoundation.h>
#import "VideoPresenter.h"

@interface VideoInteractor : NSObject <VideoInteractorInputProtocol>

@property (nonatomic ,weak) id<VideoPresenterInputProtocol> presenter;


@end


