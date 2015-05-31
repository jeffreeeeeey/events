//
//  CreateEventViewController.h
//  Events
//
//  Created by mac on 5/6/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface CreateEventViewController : UITableViewController 

@property (nonatomic, strong) Event *event;
@property (nonatomic, strong) NSArray *classificationsArray;


@end
