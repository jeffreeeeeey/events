//
//  SecondViewController.m
//  Events
//
//  Created by mac on 5/5/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "MySpaceViewController.h"
#import "MyEventsViewController.h"
#import "LoginViewController.h"
#import "User.h"

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
    
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(handleLogin:) name:@"login" object:nil];
    NSDictionary *currentUser = [User getCurrentUser];
    if (currentUser) {
        _user = currentUser;
        [self setUserInfo];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    } else {
        self.userNameLabel.text = @"登录账户";
        self.avatarImageView.image = nil;
        self.navigationItem.rightBarButtonItem = nil;
        self.loginButton.hidden = false;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)handleLogin:(NSNotification *)sender {
    //NSLog(@"\n=======got it========\n%@", sender);
    
    // Sender is the object from notification, userInfo is the dictionary in it.
    self.user = sender.userInfo;
    NSLog(@"user:%@", self.user);
    [self setUserInfo];
    
}

//set the user info

- (void)setUserInfo {
    NSString *imageString = [_user objectForKey:@"avatar"];
    
    UIImage *avatarImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]]];
    _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    _avatarImageView.image = avatarImage;
    
    
    self.userNameLabel.text = [_user objectForKey:@"name"];
    self.loginButton.hidden = true;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];

}

- (void)logout {
    [User logoutCurrentUser];
    self.user = nil;
    
    [self viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    } else {
        cell.textLabel.text = @"我主办的";
    }
    
    return cell;
    
}

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"myEvents"]) {
        self.user = [User getCurrentUser];
        if (!self.user) {
            //[self performSegueWithIdentifier:@"login" sender:self];
            
        }else {
        
            NSIndexPath *indexPath = [_funcTableView indexPathForSelectedRow];
            MyEventsViewController *vc = segue.destinationViewController;
            if (indexPath.row == 0) {
                vc.contentType = @"participated";
            } else if (indexPath.row == 1) {
                vc.contentType = @"hosted";
            }
        }
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"myEvents"]) {
        self.user = [User getCurrentUser];
        if (self.user) {
            return true;
        }
        return false;
    }
    return true;
}



@end
