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
#import "EditLogoViewController.h"

@interface PerformanceTableViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *capacitySegment;
@property (weak, nonatomic) IBOutlet UITextField *capacityLimitTextField;

@property (weak, nonatomic) IBOutlet UILabel *capacityUnitLabel;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (strong, nonatomic) NSDate *applyEndDate;

@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *applyEndDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@end


@implementation PerformanceTableViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        // Init the date
        _startDate = [[NSDate alloc]init];
        _endDate = [[NSDate alloc] initWithTimeIntervalSinceNow:3600];
        _applyEndDate = [[NSDate alloc] initWithTimeIntervalSinceNow:3600];
        
        NSLog(@"====initializing====%@", _startDate);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.title = @"时间/地点/人数";
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:nil];
    // Set the back button of next view
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    
    // Set the segmentedControl
    _capacitySegment.selectedSegmentIndex = 1;
    [_capacitySegment addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    
    _addressTextField.text = @"住邦2000商务中心";
    [self setLabelContent];
}

- (void)setLabelContent {
    // Set the content
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    if (_startDate) {
        _startDateLabel.text = [formatter stringFromDate:_startDate];
        NSLog(@"set start date:%@", [formatter stringFromDate:_startDate]);
    }
    if (_endDate) {
        _endDateLabel.text = [formatter stringFromDate:_endDate];
    }
    if (_applyEndDate) {
        _applyEndDateLabel.text = [formatter stringFromDate:_applyEndDate];
    }
    _capacityLimitTextField.text = [NSString stringWithFormat:@"%d", 50];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
        [_capacityLimitTextField setHidden:YES];
        [_capacityLimitTextField setEnabled:NO];
        _capacityUnitLabel.hidden = YES;
    }else {
        [_capacityLimitTextField setEnabled:YES];
        [_capacityLimitTextField setHidden:NO];
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

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    BOOL shouldPerform = true;
    if ([identifier isEqualToString:@"logo"]) {
        if (_addressTextField.text.length == 0) {
            [self showAlert:@"请填写地址"];
            shouldPerform = false;
        }else if (_capacitySegment.selectedSegmentIndex == 1 && _capacityLimitTextField.text.length == 0) {
            [self showAlert:@"请填写参与人数"];
            shouldPerform = false;
        }else if (_capacitySegment.selectedSegmentIndex == 1) {
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
            
            if ([formatter numberFromString:_capacityLimitTextField.text]) {
                if ([formatter numberFromString:_capacityLimitTextField.text] == 0) {
                    [self showAlert:@"参与人数不能为零"];
                } else {
                    
                }
            }else {
                [self showAlert:@"请填写正确的人数"];
            }
            
        }
    }
    
    
    return shouldPerform;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"setStartDate"]) {

        setDateViewController *vc = (setDateViewController *)[[segue destinationViewController] topViewController];
        //vc.event = _event;
        vc.dateType = 0;
        vc.thisDate = _startDate;
        vc.getDateBlock = ^(NSDate *date){
            _startDate = date;

            [self setLabelContent];
        };
    }else if ([segue.identifier isEqualToString:@"setEndDate"]) {
        setDateViewController *vc = (setDateViewController *)[[segue destinationViewController] topViewController];
        //vc.event = _event;
        vc.dateType = 1;
        vc.thisDate = _endDate;
        vc.getDateBlock = ^(NSDate *date){
            _endDate = date;
            [self setLabelContent];
        };
    }else if ([segue.identifier isEqualToString:@"setApplyEndDate"]) {
        setDateViewController *vc = (setDateViewController *)[[segue destinationViewController] topViewController];
        //vc.event = _event;
        vc.dateType = 2;
        vc.thisDate = _applyEndDate;
        vc.getDateBlock = ^(NSDate *date){
            _applyEndDate = date;
            [self setLabelContent];
        };
    }else if ([segue.identifier isEqualToString:@"logo"]) {
        
        _event.startDate = _startDate;
        _event.endDate = _endDate;
        _event.deadline = _applyEndDate;
        _event.address = _addressTextField.text;
        if (_capacitySegment.selectedSegmentIndex == 0) {
            _event.capacity = [[NSNumber numberWithInt:0] integerValue];
        } else {
            NSString *capacityString = _capacityLimitTextField.text;
            double doublaValue = [capacityString doubleValue];
            int intValue = ceil(doublaValue);
            _event.capacity = [[NSNumber numberWithInt:intValue] integerValue];
            
        }
        
        EditLogoViewController *vc = [segue destinationViewController];
        vc.event = _event;
    }
}

#pragma mark - alert

- (void)showAlert:(NSString *)noteString {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:noteString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
