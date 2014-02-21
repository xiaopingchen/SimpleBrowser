//
//  BrowserViewController.h
//  SimpleBrowser
//
//  Created by xiaoping on 2/18/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"


@interface BrowserViewController : UIViewController<UIWebViewDelegate,NSURLConnectionDataDelegate,NJKWebViewProgressDelegate>


@end
