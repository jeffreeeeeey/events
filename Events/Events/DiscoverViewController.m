//
//  FirstViewController.m
//  Events
//
//  Created by mac on 5/5/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//


#import "DiscoverViewController.h"


@interface DiscoverViewController () <UITableViewDataSource, UITableViewDelegate,NSURLSessionDataDelegate>

@property (nonatomic)  NSDictionary *jsonDic;
@property (nonatomic)  NSArray *topics;

@end

@implementation DiscoverViewController

- (void)getData:(__unused id)sender {
    
    //Use AFNetwork
    NSURLSessionDataTask *task = [Event getEventsWithBlock:^(NSArray *events, NSError *error) {
        if (!error) {
            _topics = events;
            NSLog(@"topics,%@", events);
            [self.tableView reloadData];
        }else {
            NSLog(@"network error:%@", error);
        }
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    
    
    [self.refreshControl setRefreshingWithStateOfTask:task];
    
    //    [NetworkServices fetchData:eventList getData:^(NSData *data, NSError *error) {
    //        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //        NSLog(@"eventListURL:%@", eventList);
    //        NSLog(@"eventList:%@", array);
    //        self.topics = array;
    //        [self.tableView reloadData];
    //        [self.refreshControl endRefreshing];
    //    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
/*
    [self getTopics:^(NSArray *array) {
        NSLog(@"json:%@", array);
        //NSLog(@"data:%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        
        self.topics = array;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
*/

    // pull to refresh
    self.refreshControl = [[UIRefreshControl alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 100.0f)];
    [self.refreshControl addTarget:self action:@selector(getData:) forControlEvents:UIControlEventValueChanged];
    [self.tableView.tableHeaderView addSubview:self.refreshControl];
    
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight =120.0;
    [self getData:nil];
}

- (void)didFinishRequestWithData:(NSData *)responseData {
//    NSArray *array = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
//    NSLog(@"get data:%@", [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
//    self.topics = array;
//    [self.tableView reloadData];
//    [self.refreshControl endRefreshing];
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.toolbarHidden = YES;

}

- (void)refreshInvoked{
    [self getData:nil];
    NSLog(@"===========refreshing===========");
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
/*
- (void)getTopics:(void(^)(NSArray *array))handler
{
    __block NSDictionary *dic;

    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultConfigObject.timeoutIntervalForRequest = 10;
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:eventList];
    NSLog(@"get event list:%@", url);
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data.length > 0 && error == nil) {
            
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            // Send it back
            handler(array);
            
        } else if (data.length == 0 && error == nil){
            NSLog(@"no events around");
            
        } else if (error) {
            NSString *description = [error localizedDescription];
            
            NSLog(@"error:%@", error);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:description preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:^{

                CGRect frameRect = CGRectMake(0, 0, self.tableView.frame.size.width, 100);
                UIView *notiView = [[UIView alloc]initWithFrame:frameRect];
                notiView.backgroundColor = [UIColor grayColor];
                
                [self.parentViewController.view addSubview:notiView];
                
            }];

        }
    }];
    [dataTask resume];
}
*/
@end
