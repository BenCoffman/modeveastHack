//
//  Tout.h
//  TGW
//
//  Created by Firoze Lafeer on 12/1/12.
//  Copyright (c) 2012 Coffman, Ben. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tout : NSObject

@property(nonatomic,strong) NSDate *recordedDate;
@property(nonatomic,strong) NSURL *thumbnailURL;
@property(nonatomic,strong) NSURL *videoURL;
@property(nonatomic,strong) UIImage *thumbnail;

+(Tout*)toutForDictionary:(NSDictionary*)toutDict;

-(NSNumber*)hourBucket;

@end
