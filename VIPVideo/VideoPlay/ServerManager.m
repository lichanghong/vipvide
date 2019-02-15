//
//  ServerManager.m
//  VIPVideo
//
//  Created by lichanghong on 2/14/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import "ServerManager.h"

@interface ServerManager()
@property (nonatomic,assign)NSInteger currentIndex;

@end

@implementation ServerManager

+ (instancetype)sharedInstance
{
    static ServerManager *manager = nil;
    @synchronized (self) {
        if (!manager) {
            manager = [[ServerManager alloc]init];
            manager.currentIndex = 0;
        }
    }
    return manager;
}

- (void)changeServer
{
    self.currentIndex++;
    if (self.currentIndex>=self.serverList.count) {
        self.currentIndex--;
    }
    
}

- (NSString *)currentServer
{
    return [self serverList][self.currentIndex];
}

- (NSArray *)serverList
{
    return @[
             @"http://app.baiyug.cn:2019/vip/index.php?url="
             ];
}

@end
