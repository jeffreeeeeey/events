//
//  ApplicationsTableViewController.m
//  Events
//
//  Created by mac on 5/28/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "ApplicationsTableViewController.h"
#import "Settings.h"
#import "UIAlertView+AFNetworking.h"

@interface ApplicationsTableViewController () <NSURLSessionDelegate, NSURLSessionDataDelegate>

@property (nonatomic) NSArray *applicationsArray;

@end

@implementation ApplicationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //NSNumber *eventID = [_eventDic valueForKey:@"id"];
    NSInteger eventID = _event.eventID;
    [self getEventApplications:eventID];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getEventApplications:(NSInteger)eventID
{
    NSString *urlString = [NSString stringWithFormat:@"%@%lu%@", applications, eventID, @"/applies"];
    NSLog(@"get applications:%@", urlString);
    NSURLSessionDataTask *task = [[AFLLZGEventsAPIClient sharedClient] GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"sucess, %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error, %@", error);
    }];
    
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    
    
//    __block NSArray *array;
//    __block NSDictionary *dic;
//    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//    
//    
//    NSLog(@"%@",urlString);
//    NSURL *url = [NSURL URLWithString:urlString];
//    
//    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if (data.length > 0 && error == nil) {
//            array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            NSLog(@"array:%@", array);
//            
//            self.applicationsArray = array;
//            [self.tableView reloadData];
//        } else if(error) {
//            NSLog(@"error:%@",error);
//        } else {
//            NSLog(@"get nothing");
//        }
//    }];
//    [dataTask resume];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _applicationsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"application" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *dic = [_applicationsArray objectAtIndex:indexPath.row];
    if (dic) {
        NSLog(@"======this one=======:%@",dic);
        NSString *info = [dic objectForKey:@"info"];
        //NSDictionary *infoDic = [NSJSONSerialization JSONObjectWithData:info options:NSJSONReadingAllowFragments error:nil];
        
        //NSString *username = [info objectForKey:@"username"];
        NSData *jsonData = [info dataUsingEncoding:NSUTF8StringEncoding];
        NSError *e;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&e];
        
        NSLog(@"%@",dic[@"username"]);
        cell.textLabel.text = dic[@"username"];
    } else {
        NSLog(@"nil dic");
    }
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
