//
//  BrowserViewController.m
//  SimpleBrowser
//
//  Created by xiaoping on 2/18/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "BrowserViewController.h"
#import "MBProgressHUD.h"


@interface BrowserViewController ()
{
    UIWebView *webView;
    NJKWebViewProgress *_progressProxy;
    MBProgressHUD *progressHUD;
}
@end

@implementation BrowserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        NSLog(@"test");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
   // NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"error" ofType:@"html" ];
   // NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    webView =  [[UIWebView alloc] initWithFrame:self.view.frame];
    _progressProxy = [[NJKWebViewProgress alloc] init];
    webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    [self.view addSubview:webView];
    //[webView loadRequest: ];
    //
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://192.168.1.101:8090/jQueryMobile"]];
    [webView loadRequest:request];

    
    progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progressHUD.mode = MBProgressHUDModeAnnularDeterminate;
    progressHUD.labelText = @"Loading";

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"failed");
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"error" ofType:@"html" ];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSURL *bundleBaseURL = [NSURL fileURLWithPath: bundlePath];
    [webView loadHTMLString:htmlString baseURL:bundleBaseURL];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [progressHUD hide:NO];
}

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    progressHUD.progress = progress;
    if (progress == 0.0)
    {
        [progressHUD hide:NO];
    }
    else if (progress == 1.0)
    {
        [progressHUD hide:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
