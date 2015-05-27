//
//  TopicDetailsViewController.m
//  Events
//
//  Created by mac on 5/7/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//
#import "Settings.h"
#import "EventDetailsViewController.h"
#import "ApplyTableViewController.h"

#define introductionTextViewRow 8

@interface EventDetailsViewController () <NSURLSessionDataDelegate, UIWebViewDelegate, UITextViewDelegate>

@property (nonatomic) NSDictionary *eventDic;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *closingDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *capacityLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextView *introductionTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong,nonatomic) NSNumber *introductionTextViewHeight;

@end

@implementation EventDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"活动详情";
    
    [self getEventDetail:self.topicDic];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    self.introductionTextViewHeight = [NSNumber numberWithFloat:44.0];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidChange:(UITextView *)textView theCell:(UITableViewCell *)cell {
    
//    [self.tableView reloadData];
}


#pragma mark - tableView



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == introductionTextViewRow) {
//        CGFloat fixedWidth = _introductionTextView.frame.size.width;
//        CGSize newSize = [_introductionTextView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
//        CGRect newFrame = _introductionTextView.frame;
//        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
//        //cell = [self.tableView dequeueReusableCellWithIdentifier:@"introductionCell"];
//    
//        _introductionTextView.frame = newFrame;
//        CGFloat height = _introductionTextView.frame.size.height;
//        NSLog(@"height:%f", newSize.height);
        NSLog(@"height for row:%f", [_introductionTextViewHeight floatValue]);
        return [_introductionTextViewHeight floatValue];

    } else {
    
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"apply"]) {
        ApplyTableViewController *vc = (ApplyTableViewController *)[segue.destinationViewController topViewController];
        vc.EventDic = self.eventDic;
    }
}


- (void)getEventDetail:(NSDictionary *)topicDic
{
    NSNumber *topicID = [topicDic valueForKey:@"id"];
    //NSLog(@"topic id:%@", topicID);
    
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
                _subtitleLabel.text = [_eventDic valueForKey:@"subtitle"];
                
                NSString *imageURLString = [_eventDic valueForKey:@"img"];
                //NSLog(@"image url:%@", imageURLString);
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLString]]];
                _eventImageView.contentMode = UIViewContentModeScaleAspectFit;
                _eventImageView.image = image;
                
                _startDateLabel.text = [_eventDic valueForKey:@"start_time"];
                _endDateLabel.text = [_eventDic valueForKey:@"end_time"];
                _closingDateLabel.text = [_eventDic valueForKey:@"deadline"];
                _addressLabel.text =[_eventDic valueForKey:@"location"];
                _capacityLabel.text = [NSString stringWithFormat:@"%@",[_eventDic valueForKey:@"capacity"]];
                // Handle price
                NSNumber *priceNumber = [_eventDic valueForKey:@"price"];
                NSString *priceString;
                if ([priceNumber isEqualToNumber:[NSNumber numberWithInteger:0]]) {
                    priceString = @"免费";
                } else {
                    priceString = [NSString stringWithFormat:@"%@", priceNumber];
                }
                
                _priceLabel.text = priceString;
                
                // Handle text view
                _introductionTextView.text = [_eventDic valueForKey:@"content"];
                // Get the size of textView
                CGSize textViewSize = [_introductionTextView sizeThatFits:_introductionTextView.frame.size];
                //NSLog(@"size width: %f height:%f", textViewSize.width, textViewSize.height);
                
                _introductionTextViewHeight = [NSNumber numberWithFloat:textViewSize.height];
                //NSLog(@"revise height:%@",_introductionTextViewHeight);
                
                
                
                [self.activityIndicator stopAnimating];
                
                // Resize introduction textView

                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:introductionTextViewRow inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];

                [self.tableView reloadData];
                
                
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
