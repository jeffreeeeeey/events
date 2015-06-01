//
//  setDateViewController.h
//  Events
//
//  Created by mac on 5/17/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface setDateViewController : UIViewController

@property (nonatomic) NSInteger dateType; //0:start 1:end 2:apply end

@property (nonatomic, copy)void (^getDateBlock)(NSDate *date);

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) NSDate *thisDate;

@end
