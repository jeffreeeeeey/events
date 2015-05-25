//
//  TimeLocationTableViewController.m
//  Events
//
//  Created by mac on 5/15/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "PerformanceTableViewController.h"
#import "setDateViewController.h"
#import "CapacityCell.h"

@interface PerformanceTableViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *capacitySegment;
@property (weak, nonatomic) IBOutlet UITextField *capacityTextField;
@property (weak, nonatomic) IBOutlet UILabel *capacityUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *applyEndDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *capacityLimitTextField;

@end


@implementation PerformanceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _event = [[Event alloc]init];
    //self.navigationItem.title = @"时间/地点/人数";
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:nil];
    // Set the back button of next view
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [self setLabelContent];
    
    // Set the segmentedControl
    _capacitySegment.selectedSegmentIndex = 1;
    [_capacitySegment addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];

}

- (void)setLabelContent {
    // Set the content
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    if (_event.startDate) {
        _startDateLabel.text = [formatter stringFromDate:_event.startDate];
    }
    if (_event.endDate) {
        _endDateLabel.text = [formatter stringFromDate:_event.endDate];
    }
    if (_event.applyEndDate) {
        _applyEndDateLabel.text = [formatter stringFromDate:_event.applyEndDate];
    }
    _capacityTextField.text = [NSString stringWithFormat:@"%d", 50];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setLabelContent];
    [self.tableView reloadData];
}


#pragma mark - TableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger n = 0;
    switch (section) {
        case 0:
            n = 3;
            break;
        case 1:
            n = 1;
        case 2:
            n = 1;
        default:
            break;
    }
    return n;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    CapacityCell *capacityCell = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"startDate" forIndexPath:indexPath];
        NSString *dateString =  [formatter stringFromDate:_event.startDate];
        //NSLog(@"date:%@", dateString);
        cell.detailTextLabel.text = dateString;
        return cell;

    } else if (indexPath.section == 0 && indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"endDate" forIndexPath:indexPath];
        cell.detailTextLabel.text = [formatter stringFromDate:_event.endDate];
        return cell;
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"applyEndDate" forIndexPath:indexPath];
        cell.detailTextLabel.text = [formatter stringFromDate:_event.applyEndDate];
        return cell;
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"location" forIndexPath:indexPath];
        cell.detailTextLabel.text = @"选择地点";
        return cell;
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        capacityCell = [tableView dequeueReusableCellWithIdentifier:@"capacity" forIndexPath:indexPath];
 
        return capacityCell;

    }else {
        return cell;
    }
}
 */

// Handle the change event of capacity segment
- (void)segmentChanged:(UISegmentedControl *)paramSender {
    
        NSInteger selectedSegmentIndex = [paramSender selectedSegmentIndex];
    if (selectedSegmentIndex == 0) {
        _capacityTextField.hidden = YES;
        _capacityUnitLabel.hidden = YES;
    }else {
        _capacityTextField.hidden = NO;
        _capacityUnitLabel.hidden = NO;
    }
        NSString *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        NSLog(@"Segment:%@ is selected", selectedSegmentText);

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25.0;
}

#pragma mark - navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"setStartDate"]) {

        setDateViewController *vc = (setDateViewController *)[[segue destinationViewController] topViewController];
        vc.event = _event;
        vc.dateType = 0;
        vc.confirmBlock = ^{
            [self.tableView reloadData];
            //NSLog(@"start:%@", _event.startDate);
        };
    }
    if ([segue.identifier isEqualToString:@"setEndDate"]) {
        setDateViewController *vc = (setDateViewController *)[[segue destinationViewController] topViewController];
        vc.event = _event;
        vc.dateType = 1;
        vc.confirmBlock = ^{
            [self.tableView reloadData];
            //NSLog(@"end:%@", _event.endDate);
        };
    }
    if ([segue.identifier isEqualToString:@"setApplyEndDate"]) {
        setDateViewController *vc = (setDateViewController *)[[segue destinationViewController] topViewController];
        vc.event = _event;
        vc.dateType = 2;
        vc.confirmBlock = ^{
            [self.tableView reloadData];
            //NSLog(@"apply:%@", _event.applyEndDate);
        };
    }
}



@end
