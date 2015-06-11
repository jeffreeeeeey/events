//
//  setApplicationsTableViewController.m
//  Events
//
//  Created by mac on 5/19/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//
#import "Settings.h"
#import "NetworkServices.h"
#import "setApplicationsTableViewController.h"


@interface setApplicationsTableViewController ()

@end

@implementation setApplicationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (IBAction)finishBtnPressed:(UIBarButtonItem *)sender {
    NSString *requirement = [[NSMutableString alloc]init];
    NSArray *selections = [NSArray arrayWithArray:[self.tableView indexPathsForSelectedRows]] ;
    NSLog(@"choosen count:%ld", [self.tableView indexPathsForSelectedRows].count);
    if (selections) {
        for (int i = 0; i < selections.count; i++) {
            NSIndexPath *ip = [selections objectAtIndex:i];
            NSString *factor = applicationFactorsName[ip.row];
            //NSLog(@"factor:%@", factor);
            if (i == 0) {
                requirement = [requirement stringByAppendingFormat:@"%@", factor];
            }else {
                requirement = [requirement stringByAppendingFormat:@",%@", factor];
            }
        }
        _event.requirements = requirement;

        NSLog(@"event requirement:%@", _event.requirements);
    }else {
        NSLog(@"no selections");
    }
    
    NSDictionary *eventDic = _event.getEventDic;
    NSLog(@"event dic:%@", eventDic);
    
    //NSString *testURLString = @"http://192.168.1.80:9090/huodong/api/admin/activity";
    
    [self submitEvent:eventDic toURL:createEvent];
    
    //[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)submitEvent:(NSDictionary *)dic toURL:(NSString *)urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *title = [dic valueForKey:@"title"];
    NSString *subtitle = [dic valueForKey:@"subtitle"];
    NSString *content = [dic valueForKey:@"content"];
    NSString *img = [dic valueForKey:@"img"];
    NSString *requirement = [dic valueForKey:@"requirement"];
    NSString *startTime = [dic valueForKey:@"start_time"];
    NSString *endTime = [dic valueForKey:@"end_time"];
    NSString *deadline = [dic valueForKey:@"deadline"];
    NSInteger price =  [[dic valueForKey:@"price"] integerValue];
    NSString *location = [dic valueForKey:@"location"];
    NSInteger capacity = [[dic valueForKey:@"capacity"] integerValue];
    NSString *params = [NSString stringWithFormat:@"title=%@&subtitle=%@&content=%@&img=%@&requirement=%@&start_time=%@&end_time=%@&deadline=%@&price=%lu&location=%@&capacity=%lu", title, subtitle, content, img, requirement, startTime, endTime, deadline, price, location, capacity];
    //for test fail condition
    //NSString *params = [NSString stringWithFormat:@"title=%@&subtitle=%@&content=%@&img=%@&requirement=%@&start_time=%@&end_time=%@&deadline=%@&location=%@&capacity=%@", title, subtitle, content, img, requirement, startTime, endTime, deadline, location, capacity];
    
    NSLog(@"createEvent:post:%@\n url:%@", url, params);
    
    //NSString *postLength = [NSString stringWithFormat:@"%lud", (unsigned long)[params length]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    //[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[NSData dataWithBytes:[params UTF8String] length:strlen([params UTF8String])]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length > 0 && connectionError == nil) {
            NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            //NSString *fixedString = [self fixJSON:dataString];
            
            NSLog(@"data:%@", dataString);
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSNumber *success = [NSNumber numberWithBool:dic[@"isSuccess"]];
            
            NSLog(@"dic:%@", success);
                
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            
        }else {
            // if no data returned, send an alert
            NSLog(@"create event, get no data response");
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"活动创建失败" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            UIAlertAction *quit = [UIAlertAction actionWithTitle:@"取消创建" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:action];
            [alert addAction:quit];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger n = applicationFactors.count;
    
    return n;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"factors" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = applicationFactors[indexPath.row];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"select row %ld", indexPath.row);
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}

- (void)deselectedRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    NSLog(@"deselect row %ld", indexPath.row);
    
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
