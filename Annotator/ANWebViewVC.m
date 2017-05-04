//
//  ANWebViewVC.m
//  Annotator
//
//  Created by Karan Satia on 9/5/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import "ANWebViewVC.h"
#import "UIWebView+AFNetworking.h"

@interface ANWebViewVC ()

@end

@implementation ANWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.webView];
    
    [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:req
                 progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite){
                 } success:^NSString *(NSHTTPURLResponse *response, NSString *HTML) {
                   //  NSLog(@"%@", response);
                     [MBProgressHUD hideHUDForView:self.webView animated:YES];
                     return HTML;
                 } failure:^(NSError *error){
                     NSLog(@"%@", error.localizedDescription);
                     
                 }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
