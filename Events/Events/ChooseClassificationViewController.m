//
//  ChooseClassificationViewController.m
//  Events
//
//  Created by mac on 5/13/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "ChooseClassificationViewController.h"
#import "EventClassifications.h"

@interface ChooseClassificationViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *classPicker;

@end

@implementation ChooseClassificationViewController
- (IBAction)confirmBtnPressed:(id)sender {
    
}

- (IBAction)cancelBtnPressed:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PickerView delegate and data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = nil;
    
    switch (row) {
        case 0:
            title = @"在线活动";
            break;
        case 1:
            title = @"聚会 Party";
            break;
        case 2:
            title = @"户外郊游";
            break;

            
        default:
            title = @"song";
            break;
    }
    
    return title;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

@end
