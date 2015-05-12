//
//  MyEventsViewController.m
//  Events
//
//  Created by mac on 5/6/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "MyEventsViewController.h"

@interface MyEventsViewController ()

@end

@implementation MyEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([_contentType isEqualToString:@"participated"]) {
        self.navigationItem.title = @"参与的活动";
    } else if ([_contentType isEqualToString:@"hosted"]) {
        self.navigationItem.title = @"主办的活动";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
