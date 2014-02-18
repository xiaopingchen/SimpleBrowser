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
    MBProgressHUD *progressHUD;
    long long totalLength;
    double currentDownloadLength;
    NSMutableData *htmlData;
    NSURLConnection *requestConnection;
}
@end

@implementation BrowserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    htmlData = [NSMutableData new];
    
    webView =  [[UIWebView alloc] initWithFrame:self.view.frame];
    webView.delegate = self;
    [self.view addSubview:webView];
    //[webView loadRequest: ];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://192.168.1.101:8090/jQueryMobile"]];
    requestConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progressHUD.mode = MBProgressHUDModeAnnularDeterminate;
    progressHUD.labelText = @"Loading";

}

#pragma mark - connection

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    currentDownloadLength += data.length;
    [htmlData appendData:data];
    progressHUD.progress = currentDownloadLength / (float)totalLength;
    //[NSThread sleepForTimeInterval:10];
    NSLog(@"progress:%f",progressHUD.progress);
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    totalLength = MAX(response.expectedContentLength,1);
    currentDownloadLength = 0;
    progressHUD.mode = MBProgressHUDModeDeterminate;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [webView loadData:htmlData MIMEType:nil textEncodingName:nil baseURL:nil];
    [progressHUD hide:YES afterDelay:0.5];
}


#pragma mark - webrequest

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [progressHUD hide:NO];
    progressHUD.progress = 0.1;
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        [htmlData setLength:0];
        requestConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
        
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{

}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
