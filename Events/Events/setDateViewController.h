//
//  setDateViewController.h
//  Events
//
//  Created by mac on 5/17/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface setDateViewController : UIViewController

@property (nonatomic) Event *event;

@property (nonatomic) NSInteger dateType; //0:start 1:end 2:apply end

@property (nonatomic, copy)void (^confirmBlock)(void);

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
