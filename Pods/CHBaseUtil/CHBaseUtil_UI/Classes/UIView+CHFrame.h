//
//  UIView.h
//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KScreenWidth            [[UIScreen mainScreen] bounds].size.width
#define KScreenHeight           [[UIScreen mainScreen] bounds].size.height
#define KScreenRect             [[UIScreen mainScreen] bounds]
#define KStatusHeight           (IosVersion>=7.0?20.0:0.0)
#define IS_PORTRAIT              UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)
#define STATUS_BAR_HEIGHT       (IS_PORTRAIT ? [UIApplication sharedApplication].statusBarFrame.size.height : [UIApplication sharedApplication].statusBarFrame.size.width)


#define Is414x736hScreen()       (ABS((double)[[UIScreen mainScreen] bounds].size.height - 736.f) < DBL_EPSILON)  //iphone6+
#define Is375x667hScreen()       (ABS((double)[[UIScreen mainScreen] bounds].size.height - 667.f) < DBL_EPSILON)
#define Is320x568hScreen()       (ABS((double)[[UIScreen mainScreen] bounds].size.height - 568.f) < DBL_EPSILON)  //iphone5s
#define Is320x480hScreen()       (ABS((double)[[UIScreen mainScreen] bounds].size.height - 480.f) < DBL_EPSILON)  //iphone4


@interface UIView (CHFrame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;


@end
