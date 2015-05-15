//
//  TimeLocationTableViewController.m
//  Events
//
//  Created by mac on 5/15/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "PerformanceTableViewController.h"

@interface PerformanceTableViewController ()



@end


@implementation PerformanceTableViewController

- (void)viewDidLoad {
    self.navigationItem.title = @"时间/地点/人数";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem.title = @"上一步";

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"startDate" forIndexPath:indexPath];
        NSString *dateString =  [formatter stringFromDate:_event.startDate];
        //NSLog(@"date:%@", dateString);
        cell.detailTextLabel.text = dateString;

    } else if (indexPath.section == 0 && indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"endDate" forIndexPath:indexPath];
        cell.detailTextLabel.text = [formatter stringFromDate:_event.endDate];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"applyEndDate" forIndexPath:indexPath];
        cell.detailTextLabel.text = [formatter stringFromDate:_event.applyEndDate];
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"location" forIndexPath:indexPath];
        cell.detailTextLabel.text = @"选择地点";
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"capacity" forIndexPath:indexPath];
        
    }

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25.0;
}

@end
