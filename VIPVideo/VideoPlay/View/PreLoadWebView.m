//
//  PreLoadWebView.m
//  VIPVideo
//
//  Created by lichanghong on 2/11/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import "PreLoadWebView.h"

@interface PreLoadWebView() <WKNavigationDelegate>
@property (nonatomic,copy) void(^removeAD)(NSString *noAD);
@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,assign) BOOL founded;

@end

@implementation PreLoadWebView

- (void)dealloc
{
    NSLog(@"PreLoadWebView dealloc....");
}

+ (instancetype)createLoadWebViewWithURL:(NSString *)url removeAD:(nonnull void (^)(NSString * _Nonnull))removeAD
{
    PreLoadWebView *preview = [[PreLoadWebView alloc]init];
    preview.founded = NO;
    preview.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    preview.webView.navigationDelegate = preview;
    [preview.webView loadRequest:request];
    preview.removeAD = removeAD;
    [preview addSubview:preview.webView];
    return preview;
}

//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailNavigation");
}

// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    if ([urlStr containsString:@"vip/player.php?"]) {
        //允许跳转
        NSLog(@"当前允许跳转地址：%@",urlStr);
        self.founded = YES;
        self.removeAD(urlStr);
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
    else
    {
        NSLog(@"当前不许跳转地址：%@",urlStr);
        //不许跳转
        if (self.founded) {
            decisionHandler(WKNavigationResponsePolicyCancel);
        }
        else
        {
            decisionHandler(WKNavigationResponsePolicyAllow);
        }
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"didFinishNavigation：....");
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSString *doc = @"document.documentElement.innerHTML";
//        __weak typeof(self) weakself = self;
//        [self.webView evaluateJavaScript:doc completionHandler:^(id _Nullable htmlStr, NSError * _Nullable error) {
//            if (error) {
//                NSLog(@"md5 error=%@",error);
//            }
//            else
//            {
//                NSLog(@"md5 :%@",htmlStr);
//            }
//        }];
//    });
   
}


@end
