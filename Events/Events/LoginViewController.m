//
//  LoginViewController.m
//  Events
//
//  Created by mac on 5/6/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"

@interface LoginViewController () <NSURLSessionDataDelegate, NSURLSessionDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
    
    self.userNameTextField.text = @"llzgllzgllzg";
    self.passwordTextField.text = @"123456";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {
    __block NSDictionary *dic;
    __block NSArray *array;
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *urlString = [NSString stringWithFormat:@"http://mpc.issll.com/llzgmri/m/p/user/login?accountName=%@&pwd=%@", self.userNameTextField.text, self.passwordTextField.text];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data.length > 0 && error == nil) {
            dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //NSLog(@"json:%@", dic);
            NSNumber *isSuccess = [dic valueForKey:@"isSuccess"];
            
            if ([isSuccess intValue] == 1) {
                // Get the user information
                NSDictionary *userDic = [dic valueForKey:@"user"];
                [User setUser:userDic];
                
                [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
                    
                    // Pass user dictionary by notification center
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"login" object:self userInfo:userDic];
                }];
            }
            
            
            //[self.topicsTable reloadData];
        } else {
            NSLog(@"error:%@",error);
        }
    }];
    [dataTask resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)cancelButtonPressed {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
