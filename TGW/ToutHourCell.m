//
//  ToutHourCell.m
//  TGW
//
//  Created by Firoze Lafeer on 12/1/12.
//  Copyright (c) 2012 Coffman, Ben. All rights reserved.
//

#import "ToutHourCell.h"
#import <QuartzCore/QuartzCore.h>


@implementation ToutHourCell {
    
    NSInteger offset;
    NSInteger count;
}

-(void)resetThumbs {
    
    offset = 0;
    count = 0;
    self.thumbs = [NSMutableArray array];
    
    for (UIView *view in self.thumbViews) {
        
        [view removeFromSuperview];
    }
    
    self.thumbViews = [NSMutableArray array];
    
}

-(void)addThumb:(UIImage *)thumb {
    
    offset += 20;
    count++;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:thumb];
    
    imageView.layer.shadowColor = [[UIColor grayColor] CGColor];
    imageView.layer.shadowOpacity = 0.4;
    
    imageView.frame = CGRectMake(offset, (10*(count%2))+15.0, imageView.bounds.size.width, imageView.bounds.size.height);
    
    [self.thumbViews addObject:imageView];
    
    [self addSubview:imageView];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
