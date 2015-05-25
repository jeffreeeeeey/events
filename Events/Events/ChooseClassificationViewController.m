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
    
    self.tableView.allowsMultipleSelection = YES;
    if (_event.activityTypes != nil) {
        NSArray *selectedTypes = [NSArray arrayWithArray:_event.activityTypes];
        NSLog(@"type count:%lud", selectedTypes.count);
        
        for (int i = 0; i < selectedTypes.count; i++) {
            NSIndexPath *ip = [NSIndexPath indexPathForRow:[[selectedTypes objectAtIndex:i] integerValue] inSection:0];
            [self.tableView selectRowAtIndexPath:ip animated:NO scrollPosition:UITableViewScrollPositionNone];
            NSLog(@"select row:%ld", (long)ip.row);
            
        }

    }else {
        NSLog(@"types is null");
    }
    
    
    
    //[self.tableView cellForRowAtIndexPath:ip].accessoryType = UITableViewCellAccessoryCheckmark;
    
}

- (IBAction)confirmBtnPressed:(id)sender {

    NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
    NSInteger rowsCount = selectedRows.count;
    if (rowsCount > 0) {
        NSInteger m = 0;
        NSNumber *n = nil;

        NSMutableArray *types = [[NSMutableArray alloc]init];
        for (int i = 0; i < rowsCount; i++) {
            NSIndexPath *ip = selectedRows[i];
            m = ip.row;
            n = [NSNumber numberWithInteger:m];
            
            [types addObject:n];
        }
        _event.activityTypes = types;

    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)cancelBtnPressed:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return EventClassifications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString * className = EventClassifications[indexPath.row];
    
    cell.textLabel.text = className;

    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *selectedRows = [tableView indexPathsForSelectedRows];
    NSLog(@"selected:%lu", (unsigned long)selectedRows.count);
    if (selectedRows.count == 2) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"最多选择两种类型" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        return nil;
    }else {
        return indexPath;
    }

}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"deselected:%ld", (long)indexPath.row);
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Set the check mark of previous and current selection
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else if(cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    // Change the classification of event
    //self.event.activityType = indexPath.row;
}

@end
