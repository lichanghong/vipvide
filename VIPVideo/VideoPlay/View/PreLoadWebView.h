//
//  PreLoadWebView.h
//  VIPVideo
//
//  Created by lichanghong on 2/11/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PreLoadWebView : UIView

+ (instancetype)createLoadWebViewWithURL:(NSString *)url removeAD:(void(^)(NSString *noADContent))removeAD;;

@end

NS_ASSUME_NONNULL_END
