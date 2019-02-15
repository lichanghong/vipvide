//
//  UIView.h
//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UILabel (Util)
+ (UILabel *)ch_cloneLabel:(UILabel *)label;
+ (UILabel *)ch_labelWithTextAlignment:(NSTextAlignment)textAlignment;

@end
