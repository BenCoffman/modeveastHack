//
//  Tout.m
//  TGW
//
//  Created by Firoze Lafeer on 12/1/12.
//  Copyright (c) 2012 Coffman, Ben. All rights reserved.
//

#import "Tout.h"

@implementation Tout

-(NSString *)description {
    
    return [NSString stringWithFormat:@"Tout in hour %@",[self hourBucket]];
}

-(NSNumber*)hourBucket {
    
    NSNumber *result = @0;
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *weekdayComponents =
    [gregorian components:NSHourCalendarUnit fromDate:self.recordedDate];
    
    result = @([weekdayComponents hour]);
    
    return result;
}

+(Tout *)toutForDictionary:(NSDictionary *)toutDict {
    
    static NSDateFormatter *formatter = nil;
    
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{

        formatter = [[NSDateFormatter alloc] init];
        
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        
        [formatter setLocale:enUSPOSIXLocale];
        [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    });
    
    Tout *tout = [[Tout alloc] init];
    
    
    NSString *recordedDateString = [toutDict objectForKey:@"recorded_at"];
    tout.recordedDate = [formatter dateFromString:recordedDateString];
    
    tout.thumbnailURL = [NSURL URLWithString:[toutDict valueForKeyPath:@"image.thumbnail.http_url"]];
    tout.videoURL = [NSURL URLWithString:[toutDict valueForKeyPath:@"video.mp4.http_url"]];
    
    // assume we aren't on the main thread here and just serially grab the image
    
    NSData *thumbData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:tout.thumbnailURL]
                                              returningResponse:nil
                                                          error:nil];
    
    tout.thumbnail = [UIImage imageWithData:thumbData scale:1.0];
    NSLog(@"Recorded at %@",tout.recordedDate);
    NSLog(@"Hour bucket: %@",[tout hourBucket]);

    
    return tout;
}

@end
