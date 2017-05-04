//
//  ANWebViewVC.h
//  Annotator
//
//  Created by Karan Satia on 9/5/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ANWebViewVC : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSString *url;

- (IBAction)backButton:(id)sender;

@end
