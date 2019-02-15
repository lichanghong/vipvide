//
//  PlayerActionView.m
//  VIPVideo
//
//  Created by lichanghong on 2/8/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import "PlayerActionView.h"

@interface PlayerActionView()
@property (nonatomic,strong) UIButton *playButton;
@end

@implementation PlayerActionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.playButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    self.playButton.center = self.center;
    [self.playButton setImage:[UIImage imageNamed:@"playButton"] forState:UIControlStateNormal];
    [self addSubview:self.playButton];
    
}

@end
