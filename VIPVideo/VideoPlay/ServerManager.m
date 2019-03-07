//
//  ServerManager.m
//  VIPVideo
//
//  Created by lichanghong on 2/14/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import "ServerManager.h"
#import <MBProgressHUD.h>

#define GitSERVER @"https://raw.githubusercontent.com/lichanghong/alive_server_point/master/index.html"
#define CodingSERVER @"https://coding.net/u/fengyunyifei/p/alive_server_point/git/raw/master/index.html"


@interface ServerManager()
@property (nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,assign)NSInteger loadCount; //加载服务器地址次数，超过三次不再加载
@property (nonatomic,assign)NSInteger loadServerlistCount; //加载服务器地址次数，超过三次不再加载
@property (nonatomic ,strong) MBProgressHUD *progressHUD;

@end

@implementation ServerManager
{
    
}
+ (void)load
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidFinishLaunching) name:UIApplicationDidFinishLaunchingNotification object:nil];
}

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
+ (void)applicationDidFinishLaunching
{
    [[self sharedInstance] searchForServerList];
}
- (void)searchForServerList
{
    self.loadCount = 1;
    self.loadServerlistCount = 1;
    [self loadGitServer];
}
- (void)showErrorWithMsg:(NSString *)msg
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        self.progressHUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        self.progressHUD.label.text = msg;
        [self.progressHUD hideAnimated:YES afterDelay:3];
    });
}

- (void)loadGitServer
{
    if (self.loadCount >= 3) {
        [self showErrorWithMsg:@"服务器错误"];
        return;
    }
    __weak typeof(self) weakself = self;
    NSURLSession *sessin = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:GitSERVER];
    NSMutableURLRequest *mrequest = [NSMutableURLRequest requestWithURL:url];
    [mrequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [[sessin dataTaskWithRequest:mrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        weakself.loadCount++;
        NSError *err;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        NSLog(@"json=%@",json);
        if (error || !json) {
            [weakself loadCoddingServer];
        }
        else
        {
            if ([json.allKeys containsObject:@"server"]) {
                NSString *server = [json objectForKey:@"server"];
                weakself.loadCount = 0;
                [[NSUserDefaults standardUserDefaults] setObject:server forKey:@"server"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [weakself loadServerlistWithServer:server];
            }
            else
            {
                [weakself loadCoddingServer];
            }
        }
    }]resume];
}

- (void)loadCoddingServer
{
    __weak typeof(self) weakself = self;
    NSURLSession *sessin = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:CodingSERVER];
    NSMutableURLRequest *mrequest = [NSMutableURLRequest requestWithURL:url];
    [mrequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [[sessin dataTaskWithRequest:mrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *err;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        NSLog(@"json=%@",json);
        if (error || !json) {
            [weakself loadGitServer];
        }
        else
        {
            if ([json.allKeys containsObject:@"server"]) {
                weakself.loadCount = 0;
                NSString *server = [json objectForKey:@"server"];
                [[NSUserDefaults standardUserDefaults] setObject:server forKey:@"server"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [weakself loadServerlistWithServer:server];
            }
            else
            {
                [weakself loadCoddingServer];
            }
        }
    }]resume];
}

- (void)loadServerlistWithServer:(NSString *)server
{
    self.loadServerlistCount++;
    __weak typeof(self) weakself = self;
    NSURLSession *sessin = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:server];
    NSMutableURLRequest *mrequest = [NSMutableURLRequest requestWithURL:url];
    [mrequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [[sessin dataTaskWithRequest:mrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *err;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        NSLog(@"json2=%@",json);
        if (error || !json) {
            [weakself showErrorWithMsg:@"服务器列表错误"];
        }
        else
        {
            NSArray *serverlist = [json mutableArrayValueForKey:@"domains"];
            if (serverlist && serverlist.count>0) {
                weakself.loadServerlistCount = 0;
                weakself.serverlist = serverlist;
                NSLog(@"serlist = %@",weakself.serverlist);
            }
            else
            {
                if (weakself.loadServerlistCount > 4) {
                    return ;
                }
                
               NSString *server = [[NSUserDefaults standardUserDefaults] stringForKey:@"server"];
                [self loadServerlistWithServer:server];
            }
        }
    }]resume];
}


- (void)changeServer
{
    self.currentIndex++;
    if (self.currentIndex>=self.serverlist.count) {
        self.currentIndex--;
    }
    
}

- (NSString *)currentServer
{
    if (self.currentIndex < self.serverlist.count) {
        return self.serverlist[self.currentIndex];
    }
    return nil;
}

#pragma mark lazy load
- (NSArray *)serverlist
{
    if (!_serverlist) {
        _serverlist = [NSArray array];
    }
    return _serverlist;
}

@end
