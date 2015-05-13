//
//  CreateEventViewController.m
//  Events
//
//  Created by mac on 5/6/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "CreateEventViewController.h"


@interface CreateEventViewController () 

@property (weak, nonatomic) IBOutlet UITextField *titileTextField;
@property (weak, nonatomic) IBOutlet UITextField *subTitleTextField;
@property (weak, nonatomic) IBOutlet UILabel *classificationLabel;
@property (weak, nonatomic) IBOutlet UITextView *introTextView;


@end

@implementation CreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseBtnPressed:(id)sender {
    
    
}



#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButtonPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
