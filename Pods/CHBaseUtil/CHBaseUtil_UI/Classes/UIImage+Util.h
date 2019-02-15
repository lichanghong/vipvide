//
//  UIView.h
//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (Util)
+ (UIImage *)ch_imageWithColor:(UIColor *)color;
+ (UIImage *)ch_imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;
 
FOUNDATION_EXTERN UIImage *_IMAGE(NSString*imageName);

@end
