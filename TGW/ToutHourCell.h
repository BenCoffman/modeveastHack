//
//  ToutHourCell.h
//  TGW
//
//  Created by Firoze Lafeer on 12/1/12.
//  Copyright (c) 2012 Coffman, Ben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToutHourCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelHour;

@property (nonatomic,strong) NSMutableArray *thumbs;
@property (nonatomic, strong) NSMutableArray *thumbViews;

-(void)addThumb:(UIImage*)thumb;

-(void)resetThumbs;

@end
