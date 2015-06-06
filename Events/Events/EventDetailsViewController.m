//
//  TopicDetailsViewController.m
//  Events
//
//  Created by mac on 5/7/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//
#import "Settings.h"
#import "NetworkServices.h"
#import "EventDetailsViewController.h"
#import "ApplyTableViewController.h"
#import "ApplicationsTableViewController.h"

#define introductionRowCount 8
float introWebViewHeight;

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
@property (weak, nonatomic) UITextView *introductionTextView;
@property (strong, nonatomic) IBOutlet UIWebView *introWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *applyBtn;

@property (strong,nonatomic) NSNumber *introductionTextViewHeight;

@end

@implementation EventDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"活动详情";
    self.navigationController.toolbarHidden = NO;
    //Set the web view
    _introWebView.delegate = self;
    
    //[self getEventDetail:self.topicDic];
    
    NSNumber *topicID = [_topicDic valueForKey:@"id"];
    NSString *urlString = [eventDetail stringByAppendingString:[NSString stringWithFormat:@"%@", topicID]];
    NSLog(@"eventDetailURL:%@", eventDetail);
    NSLog(@"==========urlString:%@", urlString);

    [NetworkServices fetchData:urlString getData:^(NSData *data, NSError *error) {
        
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"json:%@", dic);
            
            _eventDic = dic;
            
            _titleLabel.text = [_eventDic valueForKey:@"title"];
            _subtitleLabel.text = [_eventDic valueForKey:@"subtitle"];
            
            NSString *imageURLString = [_eventDic valueForKey:@"img"];
            NSLog(@"image url:%@", imageURLString);
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
            
            // if no requirement for apply, remove the button
            NSString *requirement = [_eventDic valueForKey:@"requirement"];
            if (requirement.length == 0) {
                self.navigationItem.rightBarButtonItem = nil;
            }
            
            // caculate the height of UIWebView based on content
            NSString *intro = [_eventDic valueForKey:@"content"];
            [_introWebView loadHTMLString:intro baseURL:nil];
            
            /*
             //For TextView
            // Get the size of textView
            CGSize textViewSize = [_introductionTextView sizeThatFits:_introductionTextView.frame.size];
            //NSLog(@"size width: %f height:%f", textViewSize.width, textViewSize.height);
            
            _introductionTextViewHeight = [NSNumber numberWithFloat:textViewSize.height];
            //NSLog(@"revise height:%@",_introductionTextViewHeight);
             [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:introductionTextViewRow inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
             
             [self.tableView reloadData];
             
             */
            
            //[self.activityIndicator stopAnimating];

        }
        
    }];
        
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    //self.introductionTextViewHeight = [NSNumber numberWithFloat:44.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - webView

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (error) {
        NSLog(@"load webView error:%@", error);
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    CGRect frame = _introWebView.frame;
    frame.size.height = 1;
    _introWebView.frame = frame;
    frame.size = [_introWebView sizeThatFits:CGSizeZero];
    frame.size.height += 44.0f;
    _introWebView.frame = frame;
    
    float height = frame.size.height;
    introWebViewHeight = height;
    
    //[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:introductionRowCount inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];

    [self.tableView reloadData];
    NSLog(@"webView finish load, frame height:%lf", height);
}

#pragma mark - tableView

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    
    return cell;
}
*/
- (void)textViewDidChange:(UITextView *)textView theCell:(UITableViewCell *)cell {
    
//    [self.tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == introductionRowCount) {

        NSLog(@"height for row:%f", introWebViewHeight);
        return introWebViewHeight;

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
    } else {
        if ([segue.identifier isEqualToString:@"applications"]) {
            ApplicationsTableViewController *vc = [segue destinationViewController];
            vc.eventDic = self.eventDic;
        }
    }
}


@end
