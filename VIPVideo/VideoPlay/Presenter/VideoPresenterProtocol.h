//
//  VideoPresenterProtocol.h
//  VIPVideo
//
//  Created by lichanghong on 2/7/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

@protocol VideoPresenterInputProtocol <NSObject>

- (void)startPlayerWithURLString:(NSString *)urlstr;
- (void)avPlayerStatusReadyToPlay;
- (void)avPlayerStatusFailed;


@end

@protocol VideoPresenterOutputProtocol <NSObject>



@end
