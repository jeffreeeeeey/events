//
//  SecondViewController.m
//  Events
//
//  Created by mac on 5/5/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "MySpaceViewController.h"

@interface MySpaceViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;


@end

@implementation MySpaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(handleLogin:) name:@"login" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)handleLogin:(NSNotification *)sender {
    //NSLog(@"\n=======got it========\n%@", sender);
    
    // Sender is the object from notification, userInfo is the dictionary in it.
    self.user = sender.userInfo;
    NSLog(@"user:%@", self.user);
    
    // Set the content of user
    NSString *imageString = [_user objectForKey:@"avatar"];
    
    UIImage *avatarImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]]];
    _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    _avatarImageView.image = avatarImage;
    
    
    self.userNameLabel.text = [_user objectForKey:@"name"];
    
    
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

@end
