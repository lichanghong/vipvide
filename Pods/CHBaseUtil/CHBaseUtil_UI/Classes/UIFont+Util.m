//
//  UIView.m
//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "UIFont+Util.h"

@implementation  UIFont (Util)
UIFont *FONT(CGFloat size)
{
    return [UIFont systemFontOfSize:size];
}
UIFont *FONT_B(CGFloat size)
{
    return [UIFont boldSystemFontOfSize:size];
}
@end
