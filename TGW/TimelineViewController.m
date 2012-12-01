//
//  TimelineViewController.m
//  TGW
//
//  Created by Firoze Lafeer on 12/1/12.
//  Copyright (c) 2012 Coffman, Ben. All rights reserved.
//

#import "TimelineViewController.h"
#import "Constants.h"
#import "ToutHashtagService.h"
#import "ToutHourCell.h"
#import "Tout.h"

@interface TimelineViewController ()


@property(nonatomic,copy) NSArray *touts;

@end

@implementation TimelineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.touts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ToutHourCell *cell = (ToutHourCell*)[tableView dequeueReusableCellWithIdentifier:@"HourCell" forIndexPath:indexPath];
    
    NSDictionary *thisHour = [self.touts objectAtIndex:indexPath.row];
    
    cell.labelHour.text = [NSString stringWithFormat:@"Hour %@",[thisHour objectForKey:@"hour"]];
    
    return cell;
}

-(void)viewWillAppear:(BOOL)animated {
    
    ToutHashtagService *service = [ToutHashtagService sharedInstance];
    
    self.touts = [service ourTouts];
    

    
    [[NSNotificationCenter defaultCenter] addObserverForName:kNoteToutsAreIn
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      
                                                      self.touts = [service ourTouts];
                                                      
                                                      [(UITableView*)self.view reloadData];
                                                  }];
    
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

@end
