//
//  ChooseClassificationViewController.m
//  Events
//
//  Created by mac on 5/13/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "CreateEventViewController.h"
#import "ChooseClassificationViewController.h"
#import "Settings.h"


@interface ChooseClassificationViewController () <UITableViewDataSource, UITableViewDelegate>




@end

@implementation ChooseClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsMultipleSelection = YES;
    /*
    if (_event != nil) {
        NSArray *selectedTypes = [NSArray arrayWithArray:_event.activityTypes];
        NSLog(@"type count:%d", (int)selectedTypes.count);
        
        for (int i = 0; i < selectedTypes.count; i++) {
            NSIndexPath *ip = [NSIndexPath indexPathForRow:[[selectedTypes objectAtIndex:i] integerValue] inSection:0];
            [self.tableView selectRowAtIndexPath:ip animated:NO scrollPosition:UITableViewScrollPositionNone];
            NSLog(@"select row:%d", (int)ip.row);
            
        }

    }else {
        NSLog(@"types is null");
    }
    
    */
    
    //[self.tableView cellForRowAtIndexPath:ip].accessoryType = UITableViewCellAccessoryCheckmark;
    
}

- (IBAction)confirmBtnPressed:(id)sender {

    NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
    NSInteger rowsCount = selectedRows.count;
    if (rowsCount > 0) {
        NSNumber *n = nil;
        
        _classificationsArray= [[NSMutableArray alloc]init];
        for (int i = 0; i < rowsCount; i++) {
            NSIndexPath *ip = selectedRows[i];

            n = [NSNumber numberWithInteger:ip.row];
            
            [_classificationsArray addObject:n];
        }

        for (NSNumber *typeNumber in _classificationsArray) {
            NSLog(@"choosed %d", typeNumber.intValue);
        }
        NSLog(@"activityTypes count:%d", (int)_classificationsArray.count);
        
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        self.getClassificationsBlock(_classificationsArray);
    }];
}

- (IBAction)cancelBtnPressed:(id)sender {
    
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return eventClassifications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString * className = eventClassifications[indexPath.row];
    
    cell.textLabel.text = className;

    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *selectedRows = [tableView indexPathsForSelectedRows];
    NSLog(@"already select rows count:%d", (int)selectedRows.count);
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
    NSLog(@"Did select %d", (int)indexPath.row);
    // Change the classification of event
    //self.event.activityType = indexPath.row;
}

@end
