//
//  TGWThirdViewController.m
//  TGW
//
//  Created by Coffman, Ben on 12/1/12.
//  Copyright (c) 2012 Coffman, Ben. All rights reserved.
//

#import "TGWThirdViewController.h"
#import "TGWPartySpot.h"

@interface TGWThirdViewController ()

@end

@implementation TGWThirdViewController
@synthesize mapView = _mapView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude  = 38.932440;
    zoomLocation.longitude = -77.21878;
    
    CLLocationCoordinate2D partyLocation;
	partyLocation.latitude  = 38.932440;
	partyLocation.longitude = -77.21878;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 20000, 20000);
    TGWPartySpot *newAnnotation = [[TGWPartySpot alloc] initWithTitle:@"Hack This" andCoordinate:partyLocation];
	[self.mapView addAnnotation:newAnnotation];
    
    
    [self.mapView setRegion:viewRegion animated:YES];
    
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
