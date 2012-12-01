//
//  TGWFirstViewController.m
//  TGW
//
//  Created by Coffman, Ben on 12/1/12.
//  Copyright (c) 2012 Coffman, Ben. All rights reserved.
//

#import "TGWFirstViewController.h"
#import "ToutHashtagService.h"
#import "Constants.h"

@interface TGWFirstViewController ()

@property(nonatomic,copy) NSArray *touts;

@end

@implementation TGWFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated {
    
      
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
