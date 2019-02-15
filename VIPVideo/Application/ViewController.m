//
//  ViewController.m
//  VIPVideo
//
//  Created by lichanghong on 2/6/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import "ViewController.h"
#import "MP4PlayerViewController.h"

@interface ViewController ()
@property (nonatomic,strong)MP4PlayerViewController *playerVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.playerVC.view];
     // Do any additional setup after loading the view, typically from a nib.
}

- (MP4PlayerViewController *)playerVC
{
    if (!_playerVC) {
        _playerVC = [MP4PlayerViewController new];
    }
    return _playerVC;
}

 


@end
