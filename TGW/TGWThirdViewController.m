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
    
    [self.mapView setRegion:viewRegion animated:NO];
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

#pragma mark - MapView Delegates
- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString *identifier = @"MyLocation";
    
    
    if ([annotation isKindOfClass:[TGWPartySpot class]]) {
        MKPinAnnotationView *pinAnn      = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (pinAnn == nil) {
            pinAnn = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            pinAnn.annotation = annotation;
        }
        
        pinAnn.enabled                   = YES;
        pinAnn.canShowCallout            = YES;
        pinAnn.pinColor                  = MKPinAnnotationColorGreen;
        pinAnn.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return pinAnn;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control
{
    
    TGWPartySpot *ann = (TGWPartySpot *)view.annotation;
    
    if (control == view.rightCalloutAccessoryView)
    {
        
    }
}

@end
