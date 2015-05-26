//
//  FirstViewController.m
//  Events
//
//  Created by mac on 5/5/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "Settings.h"
#import "DiscoverViewController.h"
#import "EventDetailsViewController.h"
#import "EventListTableViewCell.h"

@interface DiscoverViewController () <UITableViewDataSource, UITableViewDelegate,NSURLSessionDataDelegate>

@property (nonatomic)  NSDictionary *jsonDic;
@property (nonatomic)  NSArray *topics;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_indicatorView startAnimating];
    [self getTopics];
    
    // pull to refresh
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(refreshInvoked) forControlEvents:UIControlEventValueChanged];
    
}

- (void)refreshInvoked{
    
    [self getTopics];
    NSLog(@"r===========efresh");
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
    EventListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell" forIndexPath:indexPath];
    
    
    NSDictionary *topicDic = [_topics objectAtIndex:indexPath.row];
    NSString *title = [topicDic objectForKey:@"title"];
    //NSLog(@"%@", title);
    cell.titleLabel.text = title;
    cell.subtitleLabel.text = [topicDic objectForKey:@"subtitle"];
    cell.locationLabel.text = [topicDic objectForKey:@"location"];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[topicDic objectForKey:@"img"]]]];
    cell.eventImageView.image = image;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //[self performSegueWithIdentifier:@"showEventDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString: @"showEventDetails"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *topicDic = [_topics objectAtIndex:indexPath.row];
        EventDetailsViewController *vc = segue.destinationViewController;
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
                [self.tableView reloadData];
                [_indicatorView stopAnimating];
                [self.refreshControl endRefreshing];
            });
            
            
             //handle forum topics
//            dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            NSLog(@"json:%@", dic);
//            
//            array = [dic objectForKey:@"topics"];
//            NSLog(@"there are %d topics in array", (unsigned)array.count);
//            
//            // Have to use dispatch_async to make it work. NSURLSession get data asynchronously
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//            });
//            self.topics = array;
//            [self.topicsTable reloadData];
//            [_indicatorView stopAnimating];
//            [_indicatorView hidesWhenStopped];
            
        } else if (data.length == 0 && error == nil){
            NSLog(@"no events around");
            
        } else if (error) {
            NSString *description = [error localizedDescription];
            
            NSLog(@"error:%@", error);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:description preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:^{
                [_indicatorView stopAnimating];
                
            }];

        }
    }];
    [dataTask resume];
}

@end
