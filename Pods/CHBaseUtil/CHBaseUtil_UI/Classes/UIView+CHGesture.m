//
//  UIView.m
//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "UIView+CHGesture.h"
#import <objc/runtime.h>

static NSString *const CHSingleTappedKey = @"sjkdfjsdlkfsssdfss";
static NSString *const CHDoubleTappedKey = @"sdfasfasdfssfsdffd";
static NSString *const CHLongPressedKey =  @"sdfasdfaksdfjlasdf";


@implementation UIView (CHGesture)

- (UITapGestureRecognizer *)ch_whenSingleTapped:(CHGestureRecognizerActionBlock)block
{
    UITapGestureRecognizer * gesture = [self addTapGestureRecognizerWithTaps:1 touches:1 action:@selector(singleTapped:)];
    [self setBlock:block forKey:CHSingleTappedKey];
    return gesture;
}

- (UITapGestureRecognizer *)ch_whenDoubleTapped:(CHGestureRecognizerActionBlock)block
{
    UITapGestureRecognizer * gesture = [self addTapGestureRecognizerWithTaps:2 touches:1 action:@selector(doubleTapped:)];
    [self setBlock:block forKey:CHDoubleTappedKey];
    return gesture;
}

- (UILongPressGestureRecognizer *)ch_whenLongPressed:(CHGestureRecognizerActionBlock)block
{
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    gesture.cancelsTouchesInView = NO;
    [self addGestureRecognizer:gesture];
    [self setBlock:block forKey:CHLongPressedKey];
    return gesture;
}

#pragma mark - actions

- (void)singleTapped:(UITapGestureRecognizer *)recognizer
{
    [self performBlockForKey:CHSingleTappedKey recognizer:recognizer];
}

- (void)doubleTapped:(UITapGestureRecognizer *)recognizer
{
    [self performBlockForKey:CHDoubleTappedKey recognizer:recognizer];
}

- (void)longPressed:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self performBlockForKey:CHLongPressedKey recognizer:recognizer];
    }
}

#pragma mark - utils

- (void)setBlock:(CHGestureRecognizerActionBlock)block forKey:(NSString *)key
{
    const char *validKey = key.UTF8String;
    objc_setAssociatedObject(self, validKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UITapGestureRecognizer *)addTapGestureRecognizerWithTaps:(NSUInteger)taps
                                                    touches:(NSUInteger)touches
                                                     action:(SEL)aSelector
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:aSelector];
    tapGesture.numberOfTapsRequired = taps;
    tapGesture.numberOfTouchesRequired = touches;
    [self addGestureRecognizer:tapGesture];
    return tapGesture;
}

- (void)performBlockForKey:(NSString *)key recognizer:(UIGestureRecognizer *)recognizer
{
    const char *validKey = key.UTF8String;
    CHGestureRecognizerActionBlock block = objc_getAssociatedObject(self, validKey);
    if (block) {
        block(recognizer);
    }
}

@end
