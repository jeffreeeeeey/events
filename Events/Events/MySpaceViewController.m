//
//  SecondViewController.m
//  Events
//
//  Created by mac on 5/5/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "MySpaceViewController.h"
#import "MyEventsTableViewController.h"
#import "LoginViewController.h"
#import "Settings.h"
#import "UIImageView+AFNetworking.h"
#import "UIAlertView+AFNetworking.h"

@interface MySpaceViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITableView *funcTableView;

@end

@implementation MySpaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
    
    self.user = [User getCurrentUser];
    if (self.user) {
        [self setUserInfo];
        
    } else {
        
        [self clearUserInfo];
    }
}

//- (void)handleLogin:(NSNotification *)sender {
//    //NSLog(@"\n=======got it========\n%@", sender);
//    
//    // Sender is the object from notification, userInfo is the dictionary in it.
//    self.user = sender.userInfo;
//    NSLog(@"user:%@", self.user);
//    [self setUserInfo];
//    
//}

//set the user info

- (void)setUserInfo {
    
    NSString *imageString = _user.avatarURLString;
    [_avatarImageView setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"avatar1.jpeg"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    
    _userNameLabel.text = _user.nickName;
}

- (void)clearUserInfo {
    self.user = nil;
    self.navigationItem.rightBarButtonItem = nil;
    [_avatarImageView setImage:[UIImage imageNamed:@"avatar2.png"]];
    _userNameLabel.text = @"点击头像登录";
}

- (void)logout {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"您已退出登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
    [User logoutCurrentUser];
    [self clearUserInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"我参与的";
        cell.detailTextLabel.text = @"0";
    } else {
        cell.textLabel.text = @"我主办的";
        cell.detailTextLabel.text = @"0";
    }
    
    return cell;
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    if (touch.view == _avatarImageView) {
        NSLog(@"touch imageView began");
    }else {
        NSLog(@"get touch began");
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    if (touch.view == _avatarImageView) {
        NSLog(@"touch imageView");
    }else {
        NSLog(@"get touch");
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    if (touch.view == _avatarImageView) {
        NSLog(@"touch imageView");
    }else {
        NSLog(@"get touch");
    }
}
*/

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.user = [User getCurrentUser];
    if (!self.user) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请登录账户" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }

}
*/


#pragma -mark navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"login"]) {
        // If the current user is no logout, no need to login
        self.user = [User getCurrentUser];
        if (self.user) {
            return NO;
        }
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"participated"]) {

        self.user = [User getCurrentUser];
        if (!self.user) {
            NSLog(@"redirect");
            [self performSegueWithIdentifier:@"login" sender:self];
            
        }else {
            MyEventsTableViewController *vc = segue.destinationViewController;
            vc.contentType = @"participated";
        }
    }
    if ([segue.identifier isEqualToString:@"hostedEvents"]) {
        self.user = [User getCurrentUser];
        if (!self.user) {
            NSLog(@"redirect");
            [self performSegueWithIdentifier:@"login" sender:self];
        }else {
            MyEventsTableViewController *vc = segue.destinationViewController;
            vc.contentType = @"hosted";
        }
    }
    
    if ([segue.identifier isEqualToString:@"login"]) {
        LoginViewController *vc = (LoginViewController *)[segue.destinationViewController topViewController];
        vc.loginDismissBlock = ^(User *user){
            self.user = user;
            NSLog(@"block get user:%@", self.user);
            [self setUserInfo];

        };
    }
}



@end
