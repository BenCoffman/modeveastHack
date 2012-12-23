//
//  TGWSecondViewController.m
//  TGW
//
//  Created by Coffman, Ben on 12/1/12.
//  Copyright (c) 2012 Coffman, Ben. All rights reserved.
//

#import "Constants.h"
#import "TGWSecondViewController.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"

@interface TGWSecondViewController ()

@end

@implementation TGWSecondViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)takeVideo:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate					= self;
	picker.allowsEditing			= YES;
	picker.sourceType				= UIImagePickerControllerSourceTypeCamera;
    picker.showsCameraControls      = YES;
    picker.mediaTypes               = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    picker.videoMaximumDuration     = 15;
	[self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSData *videoData = [NSData dataWithContentsOfURL:[info objectForKey:UIImagePickerControllerMediaURL]];
    NSLog(@"Boop: %@%@", [NSString stringWithFormat:@"%@", kUrl], [NSString stringWithFormat:@"touts?access_token=%@", kAPIToken]);
    
    AFHTTPClient *httpClient       = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", kUrl]]];
    NSMutableURLRequest *afRequest = [httpClient multipartFormRequestWithMethod:@"POST"
                                                                           path:[NSString stringWithFormat:@"touts?access_token=%@", kAPIToken]
                                       parameters:nil constructingBodyWithBlock:^(id <AFMultipartFormData>formData)
                                      {
                                          [formData appendPartWithFileData:videoData name:@"tout[data]" fileName:@"filename.mov" mimeType:@"video/quicktime"];
                                          
                                          NSString  *tagStr  = @"#toutgonewild";
                                          NSData    *tagData = [tagStr dataUsingEncoding:NSUTF8StringEncoding];
                                          [formData appendPartWithFormData:tagData name:@"tout[text]"];
                                      }];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:afRequest];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten,long long totalBytesWritten,long long totalBytesExpectedToWrite)
     {
         //use a progress indicator here
         NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
     }];
    
    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {NSLog(@"error: %@",  operation.responseString);}];
    
    [operation start];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
