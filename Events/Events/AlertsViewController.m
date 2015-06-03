//
//  AlertsViewController.m
//  Events
//
//  Created by mac on 6/2/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "AlertsViewController.h"

@interface AlertsViewController ()

@end

@implementation AlertsViewController

+ (id)createAlert:(NSString *)title setMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    return alert;
    
}

@end
