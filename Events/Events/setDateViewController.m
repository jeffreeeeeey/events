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
    
    switch (_dateType) {
        case 0:
            self.navigationItem.title = @"选择开始时间";
            [self.datePicker setDate:_event.startDate animated:NO];
            break;
        case 1:
            self.navigationItem.title = @"选择结束时间";
            [self.datePicker setDate:_event.endDate animated:NO];
            break;
        case 2:
            self.navigationItem.title = @"选择报名截止时间";
            [self.datePicker setDate:_event.applyEndDate animated:NO];
            break;

        default:
            break;
    }

}
- (IBAction)confirmBtnPressed:(id)sender {
    
    NSDate *chooseDate = _datePicker.date;
    NSLog(@"%@", _datePicker.date);
    switch (_dateType) {
        case 0:
            _event.startDate = chooseDate;
            break;
        case 1:
            _event.endDate = chooseDate;
            break;
        case 2:
            _event.applyEndDate = chooseDate;
            break;
        default:
            break;
    }
    
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:_confirmBlock];
    
}

- (IBAction)cancelBtnPressed:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
