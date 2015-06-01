//
//  setDateViewController.m
//  Events
//
//  Created by mac on 5/17/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "setDateViewController.h"

@implementation setDateViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (_dateType) {
        case 0:
            self.navigationItem.title = @"选择开始时间";
            break;
        case 1:
            self.navigationItem.title = @"选择结束时间";
            break;
        case 2:
            self.navigationItem.title = @"选择报名截止时间";
            break;

        default:
            break;
    }
    if (_thisDate != nil) {
        [self.datePicker setDate:_thisDate animated:YES];
    }
    

}
- (IBAction)confirmBtnPressed:(id)sender {
    
    NSDate *chooseDate = _datePicker.date;
    //NSLog(@"%@", _datePicker.date);
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        self.getDateBlock(chooseDate);
    }];
    
}

- (IBAction)cancelBtnPressed:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
