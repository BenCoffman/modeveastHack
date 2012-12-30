//
//  TGW.h
//  TGW
//
//  Created by Coffman, Ben on 12/1/12.
//  Copyright (c) 2012 Coffman, Ben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface TGWPartySpot : NSObject <MKAnnotation>

@property (assign, nonatomic) CLLocationCoordinate2D cord;
@property (copy, nonatomic)   NSString               *partyTitleName;
@property (copy, nonatomic)   NSString               *partySubtitleName;

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d;

@end
