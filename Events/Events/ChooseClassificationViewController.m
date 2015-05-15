//
//  ChooseClassificationViewController.m
//  Events
//
//  Created by mac on 5/13/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "ChooseClassificationViewController.h"
#import "EventClassifications.h"
#import "Event.h"

@interface ChooseClassificationViewController () <UITableViewDataSource, UITableViewDelegate>




@end

@implementation ChooseClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择活动类型";
}

- (IBAction)confirmBtnPressed:(id)sender {
    
}

- (IBAction)cancelBtnPressed:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString * className = EventClassifications[indexPath.row];
    
    cell.textLabel.text = className;
    if (indexPath.row == _event.activityType) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Set the check mark of previous and current selection
    NSIndexPath *ip = [NSIndexPath indexPathForRow:_event.activityType inSection:0];
    [tableView cellForRowAtIndexPath:ip].accessoryType = UITableViewCellAccessoryNone;
    
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    // Change the classification of event
    self.event.activityType = indexPath.row;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
