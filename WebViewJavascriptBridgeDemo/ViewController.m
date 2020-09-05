//
//  ViewController.m
//  WebViewJavascriptBridgeDemo
//
//  Created by pacific on 2020/9/4.
//  Copyright © 2020 pacific. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "WKWebViewJavascriptBridge.h"
@interface ViewController ()
@property(nonatomic, strong)WKWebView *webView;
@property(nonatomic, strong)WKWebViewJavascriptBridge *bridge;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WebViewJavascriptBridgeDemo" ofType:@"html"];
    WKWebViewConfiguration *config= [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [WKWebViewJavascriptBridge enableLogging];
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:_webView];
    //H5调用原生
    [_bridge registerHandler:@"ObjC Echo" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"%@",data);//打印H5传的参数
        responseCallback(@"callback_JSCallOC");//回调H5
    }];
    
    //原生调用H5
    [_bridge callHandler:@"JS Echo" data:@{@"wtw":@"OCCallJS"} responseCallback:^(id responseData) {
        NSLog(@"%@",responseData);
    }];
    
}




@end
