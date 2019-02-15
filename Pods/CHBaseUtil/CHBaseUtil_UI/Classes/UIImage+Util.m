//
//  UIView.m
//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "UIImage+Util.h"

@implementation  UIImage (Util)
 
static CGFloat edgeSizeFromCornerRadius(CGFloat cornerRadius)
{
    return cornerRadius * 2 + 6;
}

+ (UIImage *)ch_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)ch_imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius
{
    CGFloat minEdgeSize = edgeSizeFromCornerRadius(cornerRadius);
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    [color setStroke];
    [roundPath fill];
    [roundPath stroke];
    [roundPath addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

UIImage *_IMAGE(NSString*imageName)
{
    return [UIImage imageNamed:imageName];
}


@end
