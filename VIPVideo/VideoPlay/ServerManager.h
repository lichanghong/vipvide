//
//  ServerManager.h
//  VIPVideo
//
//  Created by lichanghong on 2/14/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServerManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic ,copy) NSArray *serverlist;

@property (nonatomic,strong)NSString *currentServer;

- (void)changeServer;

@end

NS_ASSUME_NONNULL_END
