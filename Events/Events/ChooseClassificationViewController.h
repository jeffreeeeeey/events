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
@property (nonatomic) Event *event;
@property (nonatomic, copy) void (^dismissBlock)(void);

@end
