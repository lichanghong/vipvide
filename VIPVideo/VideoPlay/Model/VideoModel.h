//
//  VideoModel.h
//  VIPVideo
//
//  Created by lichanghong on 2/14/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoModel : NSObject
@property (nonatomic,copy)NSString *imageUrl;
@property (nonatomic,copy)NSString *name;

@property (nonatomic,copy)NSString *targetURL; //要跳转的地址

@end

NS_ASSUME_NONNULL_END
