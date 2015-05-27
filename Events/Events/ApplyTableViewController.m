//
//  ApplyTableViewController.m
//  Events
//
//  Created by mac on 5/27/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "ApplyTableViewController.h"
#import "Settings.h"
#import "Event.h"

@interface ApplyTableViewController ()

@property (nonatomic) NSArray *requirementsArray;

@end

@implementation ApplyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 144.0;
    NSString *require = [_EventDic valueForKey:@"requirement"];
    NSLog(@"%@",require);
    
    if (require.length > 0) {
        NSMutableArray *requireMutableArray = [[NSMutableArray alloc]init];
        
        NSArray *array = [require componentsSeparatedByString:@","];
        NSLog(@"array count:%lul", (unsigned long)array.count);
        UITableViewCell *cell;
        int n = nil;
        
        for (NSString *requireString in array) {
            if ([requireString isEqualToString:@"username"]) {
                n = 0;
                
            }else if ([requireString isEqualToString:@"gender"]) {
                n = 1;
            }else if ([requireString isEqualToString:@"age"]) {
                n = 2;
            }else if ([requireString isEqualToString:@"idcard"]) {
                n = 3;
            }else if ([requireString isEqualToString:@"address"]) {
                n = 4;
            }else if ([requireString isEqualToString:@"phone"]) {
                n = 5;
            }else if ([requireString isEqualToString:@"qq"]) {
                n = 6;
            }else if ([requireString isEqualToString:@"industry"]) {
                n = 8;
            }else if ([requireString isEqualToString:@"company"]) {
                n = 7;
            }else if ([requireString isEqualToString:@"position"]) {
                n = 9;
            }
            [requireMutableArray addObject:[NSNumber numberWithInt:n]];
            cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:n inSection:0]];
            cell.hidden = false;
        }
        _requirementsArray = requireMutableArray;
        
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelBtnPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _requirementsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.hidden)  {
        return 0;
    }else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];;
    }
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
