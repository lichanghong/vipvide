//
//  WebViewController.m
//  VIPVideo
//
//  Created by lichanghong on 2/8/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import "WebViewController.h"
#import <MBProgressHUD.h>
#import <UIView+CHFrame.h>
#import "WebActionView.h"
#import "ServerManager.h"
#import "PreLoadWebView.h"

@interface WebViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic ,strong) MBProgressHUD *progressHUD;
@property (nonatomic ,strong) WebActionView *actionContentView;
@property (nonatomic,copy) void(^completion)(NSString *html);
@property (nonatomic,strong) PreLoadWebView *preloadWebView;

@end

@implementation WebViewController

- (void)dealloc
{
    NSLog(@"WebViewController dealloc...");

    self.webView.UIDelegate = nil;
    self.webView.navigationDelegate = nil;
    [_webView removeFromSuperview];
    [self.actionContentView removeFromSuperview];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.webView.UIDelegate = self;
        self.webView.navigationDelegate = self;
        [self.view addSubview:_webView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initUI];

}

- (void)webViewLoadURL:(NSString *)urlstr
{
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)webViewLoadHTML:(NSString *)html
{
    [_webView loadHTMLString:html baseURL:nil];
}
- (void)webViewLoadURL:(NSString *)urlstr completion:(void (^)(NSString * _Nonnull))completion
{
    [self webViewLoadURL:urlstr];
    self.completion = completion;
}

- (WKWebView *)webView
{
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        //设置为YES即可
        config.allowsInlineMediaPlayback = YES;
        _webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];

    }
    return _webView;
}
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHUD.label.text = @"加载中";
    
    NSLog(@"didStartProvisionalNavigation");
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
//    [self.progressView setProgress:0.0f animated:NO];
    NSLog(@"didFailProvisionalNavigation %@",error);
    [self.progressHUD hideAnimated:YES];

}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"didCommitNavigation");

}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.progressHUD hideAnimated:YES];
    NSLog(@"didFinishNavigation");

}
//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailNavigation");
    self.progressHUD.label.text = @"发生错误";
    [self.progressHUD hideAnimated:YES afterDelay:2];
}
// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");
}

// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    NSLog(@"当前跳转地址-：%@",urlStr);
//    __weak typeof(self) weakself = self;
//    if ([urlStr containsString:@"vip_all/index.php"]) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            weakself.completion(urlStr);
//        });
//    }
//    [[NSUserDefaults standardUserDefaults] setObject:urlStr forKey:@"iqiyiURL"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    //允许跳转
       decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)initUI {
    __weak typeof(self) weakself = self;
    self.actionContentView = [[WebActionView alloc]initWithFrame:CGRectMake(0, self.view.height-70, self.view.width, 70)];
    self.actionContentView.backAction = ^{
        [weakself.webView goBack];
    };
    self.actionContentView.forwardAction = ^{
        [weakself.webView goForward];
    };
    self.actionContentView.playAction = ^{
        NSString *server = [ServerManager sharedInstance].currentServer;
        NSString *currenturl = weakself.webView.backForwardList.currentItem.URL.absoluteString;
        NSString *newURL = [NSString stringWithFormat:@"%@%@",server,currenturl];
        WebViewController *webViewController = [[WebViewController alloc]init];
        webViewController.founded = YES;
        [webViewController webViewLoadURL:newURL];
        [weakself.navigationController pushViewController:webViewController animated:YES];
        
//        weakself.preloadWebView = [PreLoadWebView createLoadWebViewWithURL:newURL removeAD:^(NSString * _Nonnull playerURL) {
//            WebViewController *webViewController = [[WebViewController alloc]init];
//            webViewController.founded = YES;
//            [webViewController webViewLoadURL:playerURL completion:^(NSString * _Nonnull html) {
//                NSLog(@"html.....=%@",html);
//            }];
//            [weakself.navigationController pushViewController:webViewController animated:YES];
//        }];
//        weakself.preloadWebView.frame = CGRectMake(0, 0, 300, 300);
    };
    self.actionContentView.reloadAction = ^{
        [weakself.webView reload];
    };
    self.actionContentView.saveAction = ^{
        //收藏
        
    };
    [self.view addSubview:self.actionContentView];
}

@end
