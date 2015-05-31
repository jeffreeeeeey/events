//
//  ChooseClassificationViewController.h
//  Events
//
//  Created by mac on 5/13/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface ChooseClassificationViewController : UITableViewController
@property (nonatomic, strong) Event *event;
@property (nonatomic, strong) NSMutableArray *classificationsArray;
@property (nonatomic, copy) void (^getClassificationsBlock)(NSArray *classifications);

@end
