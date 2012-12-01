//
//  ToutHashtagService.h
//  TGW
//
//  Created by Firoze Lafeer on 12/1/12.
//  Copyright (c) 2012 Coffman, Ben. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToutHashtagService : NSObject

+ (ToutHashtagService*) sharedInstance;

-(void)refreshHashtag;

@property (nonatomic, readonly) NSArray *ourTouts;

@end
