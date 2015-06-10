//
//  LoginViewController.h
//  Events
//
//  Created by mac on 5/6/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"


@interface LoginViewController : UIViewController

@property (nonatomic, copy) void (^loginDismissBlock)(User *user);

@end
