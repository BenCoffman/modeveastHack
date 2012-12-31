//
//  TGW.m
//  TGW
//
//  Created by Coffman, Ben on 12/1/12.
//  Copyright (c) 2012 Coffman, Ben. All rights reserved.
//

#import "TGWPartySpot.h"

@implementation TGWPartySpot
@synthesize coordinate          = _coordinate;
@synthesize partyTitleName      = _partyTitleName;
@synthesize partySubtitleName   = _partySubtitleName;

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d {
	self = [super init];
	if(self){
        _partyTitleName = ttl;
        _coordinate  = c2d;
    }
    return self;
}

- (NSString *)title {
    return self.partyTitleName;
}

// currently nil, in here if needed.
- (NSString *)subtitle{
    return self.partySubtitleName;
}

@end
