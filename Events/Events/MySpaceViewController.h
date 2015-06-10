//
//  SecondViewController.h
//  Events
//
//  Created by mac on 5/5/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface MySpaceViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) User *user;

@end

