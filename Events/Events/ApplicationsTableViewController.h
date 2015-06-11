//
//  ApplicationsTableViewController.h
//  Events
//
//  Created by mac on 5/28/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface ApplicationsTableViewController : UITableViewController
@property (nonatomic, strong) NSDictionary *eventDic;
@property (nonatomic, strong) Event *event;

@end
