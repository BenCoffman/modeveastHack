//
//  TGW.m
//  TGW
//
//  Created by Coffman, Ben on 12/1/12.
//  Copyright (c) 2012 Coffman, Ben. All rights reserved.
//

#import "TGWPartySpot.h"

@implementation TGWPartySpot
@synthesize coordinate   = _coordinate;
@synthesize description  = _description;

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d {
	self = [super init];
	if(self){
        self.description = ttl;
        _coordinate  = c2d;
        return self;
    }
}
@end
