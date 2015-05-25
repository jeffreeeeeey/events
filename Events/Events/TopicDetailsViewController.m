//
//  TopicDetailsViewController.m
//  Events
//
//  Created by mac on 5/7/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//
#import "Settings.h"
#import "TopicDetailsViewController.h"

@interface TopicDetailsViewController () <NSURLSessionDataDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *mainContentView;

@property (nonatomic) NSDictionary *eventDic;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *closingDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *participantsCount;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation TopicDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"活动详情";
    self.scrollView.contentSize = self.mainContentView.bounds.size;
    
    [self getEventDetail:self.topicDic];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

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

- (void)getEventDetail:(NSDictionary *)topicDic
{
    NSNumber *topicID = [topicDic valueForKey:@"id"];
    NSLog(@"topic id:%@", topicID);
    
    __block NSDictionary *dic;
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *urlString = [NSString stringWithFormat:eventDetail,topicID];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data.length > 0 && error == nil) {
            dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"json:%@", dic);
            
            
            // Have to use dispatch_async to make it work. NSURLSession get data asynchronously
            // for event
            dispatch_async(dispatch_get_main_queue(), ^{
                _eventDic = dic;
                
                _titleLabel.text = [_eventDic valueForKey:@"title"];
                
                NSString *imageURLString = [_eventDic valueForKey:@"img"];
                //NSLog(@"image url:%@", imageURLString);
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLString]]];
                _eventImageView.contentMode = UIViewContentModeScaleAspectFit;
                _eventImageView.image = image;
                
                _startTimeLabel.text = [_eventDic valueForKey:@"start_time"];
                _endTimeLabel.text = [_eventDic valueForKey:@"end_time"];
                _closingDateLabel.text = [_eventDic valueForKey:@"deadline"];
                [self.activityIndicator stopAnimating];
                
                /*
                // for forum topics
                NSDictionary *eventTopicDic = [dic valueForKey:@"topic"];
                NSString *title = [eventTopicDic valueForKey:@"title"];
                _titleLabel.text = title;
                
                // Foundamental information are in activity dic
                NSDictionary *activityDic = [eventTopicDic valueForKey:@"activity"];
                
                
                NSString *imageURLString = [activityDic valueForKey:@"image"];
                NSLog(@"image url:%@", imageURLString);
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLString]]];
                _eventImageView.contentMode = UIViewContentModeScaleAspectFit;
                _eventImageView.image = image;
                
                
                NSString *startTimeString = [activityDic valueForKey:@"startTime"];
                NSLog(@"%@", startTimeString);
                _startTimeLabel.text = startTimeString;
                
                NSString *endTimeString = [activityDic valueForKey:@"endTime"];
                _endTimeLabel.text = endTimeString;
                
                NSString *closingDateString = [activityDic valueForKey:@"joinEndTime"];
                _closingDateLabel.text = closingDateString;
                
                NSNumber *n = [activityDic valueForKey:@"man_count"];
                _participantsCount.text = [NSString stringWithFormat:@"%@",n];
                 */
            });

        } else {
            NSLog(@"error:%@",error);
        }
    }];
    [dataTask resume];
}

@end
