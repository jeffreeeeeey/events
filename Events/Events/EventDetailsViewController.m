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
#import "ApplicationsTableViewController.h"
#import "EventTitleTableViewCell.h"
#import "EventLogoTableViewCell.h"
#import "EventContentTableViewCell.h"
#import "User.h"

#define introductionRowCount 8
float contentWebViewHeight;

@interface EventDetailsViewController () <NSURLSessionDataDelegate, UIWebViewDelegate, UITextViewDelegate>

@property (nonatomic) NSDictionary *eventDic;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *applyBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *applicationsBtn;

@property (strong,nonatomic) NSNumber *introductionTextViewHeight;

@end

@implementation EventDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navigationItem.rightBarButtonItem = nil;
    // Set the bottom bar
    self.navigationController.toolbarHidden = NO;
    if (_event.requirements.length == 0) {
        _applyBtn.enabled = false;
        _applicationsBtn.enabled = false;
    }
    
    User *user = [User getCurrentUser];
    NSLog(@"user identity:%@", user.identity);
    NSLog(@"event requirements:%@", _event.requirements);
    
    if (user && [user.identity isEqualToString:@"admin"]) {
        self.navigationController.toolbarHidden = NO;
        NSLog(@"show tool bar");
    }
    else {
        self.navigationController.toolbarHidden = YES;
        NSLog(@"hide tool bar");
    }
    
    //[self getEventDetail:self.topicDic];
    
    NSInteger topicID = _event.eventID;
    NSString *urlString = [eventDetail stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)topicID]];
    NSLog(@"eventDetailURL:%@", eventDetail);
    NSLog(@"==========urlString:%@", urlString);

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    
    NSLog(@"content:%@", _event.content);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    

    
}

- (NSDateFormatter *)setDateFormatter {
    NSDateFormatter *visiableDateFormatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [visiableDateFormatter setTimeZone:timeZone];
    [visiableDateFormatter setDateFormat:@"yyyy'-'MM'-'dd HH':'mm"];
    return visiableDateFormatter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    NSDateFormatter *formatter = [self setDateFormatter];
    
    switch (row) {
        case 0://title and subtitle
        {
            EventTitleTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"title" forIndexPath:indexPath];
            cell.titleLabel.text = _event.title;
            cell.subtitleLabel.text = _event.subtitle;
            return cell;

            break;
        }
        case 1://logo image
        {
            EventLogoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"logo" forIndexPath:indexPath];
            [cell.LogoImageView setImageWithURL:_event.logoImageURL placeholderImage:[UIImage imageNamed:@"logo.png"]];
            return cell;
            break;
        }
        case 2://start date
        {
            UITableViewCell *normalCell = [self.tableView dequeueReusableCellWithIdentifier:@"normal" forIndexPath:indexPath];
            normalCell.textLabel.text = @"开始时间";
            normalCell.detailTextLabel.text = [formatter stringFromDate:_event.startDate];
            return normalCell;
            break;
        }
        case 3://end date
        {
            UITableViewCell *normalCell = [self.tableView dequeueReusableCellWithIdentifier:@"normal" forIndexPath:indexPath];
            normalCell.textLabel.text = @"结束时间";
            normalCell.detailTextLabel.text = [formatter stringFromDate:_event.endDate];
            return normalCell;
            break;
        }
        case 4://deadline
        {
            UITableViewCell *normalCell = [self.tableView dequeueReusableCellWithIdentifier:@"normal" forIndexPath:indexPath];
            normalCell.textLabel.text = @"报名截止";
            normalCell.detailTextLabel.text = [formatter stringFromDate:_event.deadline];
            return normalCell;
            break;
        }
        case 5: //address
        {
            UITableViewCell *normalCell = [self.tableView dequeueReusableCellWithIdentifier:@"normal" forIndexPath:indexPath];
            normalCell.textLabel.text = @"地址";
            normalCell.detailTextLabel.text = _event.address;
            return normalCell;
            break;
        }
        case 6: //capacity
        {
            UITableViewCell *normalCell = [self.tableView dequeueReusableCellWithIdentifier:@"normal" forIndexPath:indexPath];
            normalCell.textLabel.text = @"人数";
            normalCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", _event.capacity];
            return normalCell;
            break;
        }
        case 7: //costs
        {
            UITableViewCell *normalCell = [self.tableView dequeueReusableCellWithIdentifier:@"normal" forIndexPath:indexPath];
            normalCell.textLabel.text = @"费用";
            normalCell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", _event.costs];
            return normalCell;
            break;
        }
        case 8: //content
        {
            EventContentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"content"];
            cell.hasFixedRowHeight = NO;
            
            //EventContentTableViewCell *cell = [[EventContentTableViewCell alloc]initWithReuseIdentifier:@"content"];
            [cell setHTMLString:_event.content];
            
            return cell;
            break;
        }
        default:
            return nil;
            break;
    }

    
}

#pragma -mark webView

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (void)textViewDidChange:(UITextView *)textView theCell:(UITableViewCell *)cell {
    
//    [self.tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == introductionRowCount) {
        
        EventContentTableViewCell *cell = [[EventContentTableViewCell alloc]init];
        [cell setHTMLString:_event.content];
        CGFloat height = [cell requiredRowHeightInTableView:self.tableView];
        NSLog(@"content height:%f", height);
        if (height < 44.0) {
            height = 44.0f;
        }
        return height;

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
        vc.event = self.event;
    } else {
        if ([segue.identifier isEqualToString:@"applications"]) {
            ApplicationsTableViewController *vc = [segue destinationViewController];
            vc.eventDic = self.eventDic;
            vc.event = self.event;
        }
    }
}


@end
