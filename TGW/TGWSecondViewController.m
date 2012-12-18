//
//  TGWSecondViewController.m
//  TGW
//
//  Created by Coffman, Ben on 12/1/12.
//  Copyright (c) 2012 Coffman, Ben. All rights reserved.
//

#import "TGWSecondViewController.h"

@interface TGWSecondViewController ()

@end

@implementation TGWSecondViewController
@synthesize webView = _webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://dl.dropbox.com/u/79429/hackathon/tout.html"]]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)webViewBackbtn:(id)sender {
    [self.webView goBack];
}
@end
