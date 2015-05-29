//
//  CreateEventViewController.m
//  Events
//
//  Created by mac on 5/6/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "CreateEventViewController.h"
#import "Event.h"
#import "EventClassifications.h"
#import "ChooseClassificationViewController.h"
#import "PerformanceTableViewController.h"


@interface CreateEventViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate>
@property (nonatomic, strong) Event *event;
@property (weak, nonatomic) IBOutlet UITextField *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *subtitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *introductionTextView;

@end

@implementation CreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _event = [[Event alloc]init];
    NSLog(@"init type count:%ldu", _event.activityTypes.count);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    //NSLog(@"%@", EventClassifications[_event.activityType]);
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextBtnPressed:(id)sender {
    
    
}

- (IBAction)cancelButtonPressed:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"活动尚未创建，已填写的数据将不被保存" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"停止创建" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"继续编辑" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:yesAction];
    [alert addAction:noAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    BOOL shouldPerform = false;
    
    // Varifify if title is empty
    if (_titleLabel.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请填写活动标题" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else {
        shouldPerform = true;
    }
    
    return shouldPerform;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"chooseClassification"]) {
        ChooseClassificationViewController *vc = (ChooseClassificationViewController *)[segue.destinationViewController topViewController];
        vc.event = self.event;
        vc.dismissBlock = ^{
            [self.tableView reloadData];
        };
    }else if ([segue.identifier isEqualToString:@"performance"]) {
        if (_titleLabel.text.length > 0) {
            _event.title = _titleLabel.text;
        }
        if (_subtitleLabel.text.length > 0) {
            _event.subtitle = _titleLabel.text;
        }
        if (_introductionTextView.text.length > 0) {
            _event.content = _introductionTextView.text;
        }
        
        
        PerformanceTableViewController *vc = segue.destinationViewController;
        vc.event = self.event;
    }
    
}




#pragma mark - TableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1){
        return 1;
    } else {
        return 1;
    }
}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @" ";
    } else {
        return @"  ";
    }
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25.0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subtitle" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1 && indexPath.row == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"classification" forIndexPath:indexPath];
        NSString *classification = EventClassifications[_event.activityType];
        cell.detailTextLabel.text = classification;
        return cell;
    }else if (indexPath.section == 2 && indexPath.row == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"introduction" forIndexPath:indexPath];
        return cell;
    }
    
    else {
        return nil;
    }
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = self.tableView.rowHeight;
    if (indexPath.section == 1 && indexPath.row == 0) {
        height = 50;
    }
    return height;
}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - TextView delegate

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
    return YES;
}

@end
