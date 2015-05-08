//
//  TopicDetailsViewController.m
//  Events
//
//  Created by mac on 5/7/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "TopicDetailsViewController.h"

@interface TopicDetailsViewController () <NSURLSessionDataDelegate>

@end

@implementation TopicDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"活动详情";
    [self getEventDetail:self.eventDic];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    NSLog(@"appear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)getEventDetail:(NSDictionary *)eventDic
{
    NSNumber *topicID = [eventDic valueForKey:@"id"];
    NSLog(@"topic id:%@", topicID);
    
    __block NSDictionary *dic;
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *urlString = [NSString stringWithFormat:@"http://mpc.issll.com/llzgmri/m/p/topic/queryTopic?topicid=%@&page=1&userid=",topicID];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data.length > 0 && error == nil) {
            dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"json:%@", dic);
            
            /*
            // Have to use dispatch_async to make it work. NSURLSession get data asynchronously
            dispatch_async(dispatch_get_main_queue(), ^{
                self.topics = array;
                [self.topicsTable reloadData];
                }
            });
            */

        } else {
            NSLog(@"error:%@",error);
        }
    }];
    [dataTask resume];
}

@end
