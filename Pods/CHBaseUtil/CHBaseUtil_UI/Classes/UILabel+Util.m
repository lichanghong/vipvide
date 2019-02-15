//
//  UIView.m
//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "UILabel+Util.h"

@implementation  UILabel (Util)


+ (UILabel *)ch_cloneLabel:(UILabel *)label
{
    UILabel *cloneLabel = [[UILabel alloc] init];
    cloneLabel.textColor = label.textColor;
    cloneLabel.textAlignment = label.textAlignment;
    cloneLabel.textColor = label.textColor;
    cloneLabel.font = label.font;
    cloneLabel.shadowColor = label.shadowColor;
    cloneLabel.lineBreakMode = label.lineBreakMode;
    return cloneLabel;
}

+ (UILabel *)ch_labelWithTextAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[self alloc] init];
    label.textAlignment = textAlignment;
    return label;
}



@end
