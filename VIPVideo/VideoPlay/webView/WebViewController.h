//
//  WebViewController.h
//  VIPVideo
//
//  Created by lichanghong on 2/8/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController
@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,assign) BOOL founded;

- (void)webViewLoadURL:(NSString *)urlstr;
- (void)webViewLoadHTML:(NSString *)html;
- (void)webViewLoadURL:(NSString *)urlstr completion:(void(^)(NSString *))completion;

@end

NS_ASSUME_NONNULL_END
