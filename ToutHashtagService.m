//
//  ToutHashtagService.m
//  TGW
//
//  Created by Firoze Lafeer on 12/1/12.
//  Copyright (c) 2012 Coffman, Ben. All rights reserved.
//

#import "ToutHashtagService.h"
#import "Tout.h"
#import "Constants.h"


@implementation ToutHashtagService {
    
    NSArray *touts_;
}

+(ToutHashtagService*)sharedInstance {
    
    static ToutHashtagService *instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

-(NSArray*)ourTouts {
    
    
    // FIX THIS!
    
    if (!touts_) {
        
        [self refreshHashtag];
    }
    
    return touts_;
}

-(NSArray*)toutsAsBuckets:(NSArray*)rawTouts {
    
    // return array of dictionaries
    
    NSMutableArray *results = [NSMutableArray array];
    
    NSArray *sortedTouts = [rawTouts sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {

        Tout *t1 = (Tout*) obj1;
        Tout *t2 = (Tout*) obj2;
        
        return [t1.hourBucket compare:t2.hourBucket];
    
    }];
    
    NSNumber *lastHour = nil;
    NSDictionary *lastDict = nil;
    
    for (Tout* thisOne in sortedTouts) {
        
        if ([[thisOne hourBucket] intValue] != [lastHour intValue]) {
            
            lastDict = @{@"hour":[thisOne hourBucket],@"touts":[NSMutableArray array]};
            
            [results addObject:lastDict];
            
            lastHour = [thisOne hourBucket];
            
        }
        
        [[lastDict objectForKey:@"touts"] addObject:thisOne];
    }
    
    return results;
    
}

-(void)refreshHashtag {
    
    static NSString *url = @"http://api.tout.com/api/v1/hashtags/toutgonewild/touts?access_token=291531d7b4ed8460800d14b589b79b9b0d1c33e0eedd1f4adfec52b9679a06f0";
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSOperationQueue *q = [NSOperationQueue mainQueue]; // FIX THIS! There are a bunch of sync calls happening below
    
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:q
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                               
                               NSMutableArray* touts = [result objectForKey:@"touts"];
                               
                               NSMutableArray *results = [NSMutableArray array];
                               
                               for (NSDictionary* wrapper in touts) {
                                   
                                   Tout *thisOne = [Tout toutForDictionary:[wrapper objectForKey:@"tout"]];
                                   [results addObject:thisOne];
                               }
                               
                               NSLog(@"FLDEBUG - Got touts for hashtag");
                               
                               
                               
                               touts_ = [self toutsAsBuckets:results];
                               
                               // Tell the app we got 'em
                               
                               [[NSNotificationCenter defaultCenter] postNotificationName:kNoteToutsAreIn object:self];
                               
                               //NSLog(@"Touts - %@",touts_);
                           }];
    
    
}

@end
