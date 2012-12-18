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

#import <MediaPlayer/MediaPlayer.h>

@interface TimelineViewController ()


@property(nonatomic,copy) NSArray *touts;

@property(nonatomic,strong) MPMoviePlayerController *movieController;
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
    
    cell.labelHour.text = [NSString stringWithFormat:@"%@:00",[thisHour objectForKey:@"hour"]];
    
    [cell resetThumbs];
    
    NSArray *touts = [thisHour objectForKey:@"touts"];
    
    for (Tout *tout in touts) {
        
        [cell addThumb:tout.thumbnail];
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog (@"Ouch");
    
    NSDictionary *thisHour = [self.touts objectAtIndex:indexPath.row];
    NSArray *touts = [thisHour objectForKey:@"touts"];
    
    Tout *lastOne = [touts objectAtIndex:0];

    
    self.movieController = [[MPMoviePlayerController alloc] initWithContentURL: lastOne.videoURL];
    [self.movieController prepareToPlay];
    [self.movieController.view setFrame: self.view.bounds];  // player's frame must match parent's
    [self.view addSubview: self.movieController.view];
    [self.movieController play];
}

-(void)viewWillAppear:(BOOL)animated {
    
    ToutHashtagService *service = [ToutHashtagService sharedInstance];
    
    //self.touts = [service ourTouts];
    

    [service refreshHashtag];
    
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
