//
//  WebActionView.h
//  VIPVideo
//
//  Created by lichanghong on 2/10/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebActionView : UIView
@property (nonatomic,copy) void(^backAction)(void);
@property (nonatomic,copy) void(^forwardAction)(void);
@property (nonatomic,copy) void(^playAction)(void);
@property (nonatomic,copy) void(^reloadAction)(void);
@property (nonatomic,copy) void(^saveAction)(void);

@end

NS_ASSUME_NONNULL_END
