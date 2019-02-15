//
//  HomeCollectionViewCell.m
//  VIPVideo
//
//  Created by lichanghong on 2/14/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    CGFloat screenWidth = (UIScreen.mainScreen.bounds.size.width);
    self.mImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth/4.0-10, screenWidth/6.0)];
    self.mImageView.backgroundColor = [UIColor clearColor];
    self.mImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.mImageView];
}

@end
