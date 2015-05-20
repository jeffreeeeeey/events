//
//  FirstViewController.m
//  Events
//
//  Created by mac on 5/5/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "Settings.h"
#import "DiscoverViewController.h"
#import "TopicDetailsViewController.h"

@interface DiscoverViewController () <UITableViewDataSource, UITableViewDelegate,NSURLSessionDataDelegate>

@property (nonatomic)  NSDictionary *jsonDic;
@property (nonatomic)  NSArray *topics;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self getTopics];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topicCell" forIndexPath:indexPath];
    
    NSDictionary *topicDic = [_topics objectAtIndex:indexPath.row];
    NSString *title = [topicDic objectForKey:@"title"];
    //NSLog(@"%@", title);
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //[self performSegueWithIdentifier:@"showEventDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString: @"showEventDetails"]) {
        
        NSIndexPath *indexPath = [self.topicsTable indexPathForSelectedRow];
        NSDictionary *topicDic = [_topics objectAtIndex:indexPath.row];
        TopicDetailsViewController *vc = segue.destinationViewController;
        vc.topicDic = topicDic;
    }
}

#pragma mark - Network

- (void)getTopics
{
    __block NSDictionary *dic;
    __block NSArray *array;
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:eventList];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data.length > 0 && error == nil) {
            array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"json:%@", array);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.topics = array;
                [self.topicsTable reloadData];
            });
            
            
            /* handle forum topics
            array = [dic objectForKey:@"topics"];
            NSLog(@"there are %d topics in array", (unsigned)array.count);
            
            // Have to use dispatch_async to make it work. NSURLSession get data asynchronously
            dispatch_async(dispatch_get_main_queue(), ^{
                self.topics = array;
                [self.topicsTable reloadData];
            });
            */
            //[self.topicsTable reloadData];
        } else {
            NSLog(@"error:%@",error);
        }
    }];
    [dataTask resume];
}

@end
