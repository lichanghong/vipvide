//
//  WebActionView.m
//  VIPVideo
//
//  Created by lichanghong on 2/10/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import "WebActionView.h"
#import <UIView+CHFrame.h>


@interface WebActionView()
@property (nonatomic,strong)UIButton *backButton;
@property (nonatomic,strong)UIButton *forwardButton;
@property (nonatomic,strong)UIButton *playButton;
@property (nonatomic,strong)UIButton *reloadButton; //刷新
@property (nonatomic,strong)UIButton *saveButton; //收藏

@end

@implementation WebActionView
-(void)dealloc
{
    NSLog(@"WebActionView dealloc...");
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
      
        self.playButton = [[UIButton alloc]initWithFrame:CGRectMake(0, -10, frame.size.height+20, frame.size.height+20)];
        self.playButton.centerX = KScreenWidth/2.0;
        [self.playButton setImage:[UIImage imageNamed:@"playButton"] forState:UIControlStateNormal];
        [self.playButton addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.playButton];
        
        self.forwardButton = [[UIButton alloc]initWithFrame:CGRectMake(self.playButton.x-70, 0, 70, frame.size.height)];
        [self.forwardButton setImage:[UIImage imageNamed:@"forward"] forState:UIControlStateNormal];
        [self.forwardButton addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.forwardButton];
        
        self.backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.forwardButton.x-70, 0, 70, frame.size.height)];
        [self.backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [self.backButton addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.backButton];
        
        self.reloadButton = [[UIButton alloc]initWithFrame:CGRectMake(self.playButton.right, 0, 70, frame.size.height)];
        [self.reloadButton setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
        [self.reloadButton addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.reloadButton];
        
        self.saveButton = [[UIButton alloc]initWithFrame:CGRectMake(self.reloadButton.right, 0, 70, frame.size.height)];
        [self.saveButton setImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
        [self.saveButton addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.saveButton];

    }
    return self;
}

- (void)handleAction:(id)sender
{
    if (sender == self.backButton) {
        if (self.backAction) {
            self.backAction();
        }
    }
    else if (sender == self.forwardButton)
    {
        if (self.forwardAction) {
            self.forwardAction();
        }
    }
    else if (sender == self.playButton)
    {
        if (self.playAction) {
            self.playAction();
        }
    }
    else if (sender == self.reloadButton)
    {
        if (self.reloadAction) {
            self.reloadAction();
        }
    }
    else if (sender == self.saveButton)
    {
        if (self.saveAction) {
            self.saveAction();
        }
    }
}

@end
