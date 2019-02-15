//
//  UIView.h
//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CHGestureRecognizerActionBlock)(UIGestureRecognizer *gestureRecognizer);

@interface UIView (CHGesture)


/// 给一个view添加单击手势
- (UITapGestureRecognizer *)ch_whenSingleTapped:(CHGestureRecognizerActionBlock)block;
/// 给一个view添加双击手势
- (UITapGestureRecognizer *)ch_whenDoubleTapped:(CHGestureRecognizerActionBlock)block;
/// 给一个view添加长按手势
- (UILongPressGestureRecognizer *)ch_whenLongPressed:(CHGestureRecognizerActionBlock)block;


@end
