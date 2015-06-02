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
#import "AgeTableViewCell.h"
#import "GenderTableViewCell.h"

#define rowsCount (int)10

@interface ApplyTableViewController () <NSURLSessionDataDelegate, NSURLSessionDelegate>

@property (nonatomic) NSArray *requirementsArray;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegment;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UISlider *ageSlider;
@property (weak, nonatomic) IBOutlet UITextField *idcardTextField;
@property (weak, nonatomic) IBOutlet UILabel *residenceLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *qqTextField;
@property (weak, nonatomic) IBOutlet UILabel *industryLabel;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UITextField *positionTextField;

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
        NSMutableArray *requiredCellsMutableArray = [[NSMutableArray alloc]init];
        
        NSArray *array = [require componentsSeparatedByString:@","];
        //NSLog(@"array count:%lul", (unsigned long)array.count);
        
        int n = 0;
        
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
                n = 7;
            }else if ([requireString isEqualToString:@"company"]) {
                n = 8;
            }else if ([requireString isEqualToString:@"position"]) {
                n = 9;
            }else {
                n = 0;
            }
            //NSLog(@"n=%d", n);
            [requireMutableArray addObject:[NSNumber numberWithInt:n]];
            
            // Why need user super to get the cell?
            UITableViewCell *cell = [super tableView:self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:n inSection:0]];
            if (cell) {
                [requiredCellsMutableArray addObject:cell];
                //NSLog(@"add cell to array:%@", cell.reuseIdentifier);
            } else {
                NSLog(@"cell is nil");
            }
            
            //cell.hidden = false;
        }
        
        
        _requirementsArray = requiredCellsMutableArray;
    }
    
    _ageTextField.text = [NSString stringWithFormat:@"%d", (int)_ageSlider.value];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - cancel or submit form
- (IBAction)cancelBtnPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitBtnPressed:(UIBarButtonItem *)sender {
    NSString *eventID = [_EventDic valueForKey:@"id"];
    NSString *username = _usernameTextfield.text;
    NSString *age = _ageTextField.text;
    NSString *gender = @"男";
    NSString *idcard = _idcardTextField.text;

    NSURL *url = [NSURL URLWithString:apply];
    NSString *params = [NSString stringWithFormat:@"activityId=%@&username=%@&age=%@",eventID, username, age];

    NSLog(@"%@ %@", url, params);
    
    NSString *postLength = [NSString stringWithFormat:@"%lud", (unsigned long)[params length]];
    
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
            if (success) {
                
                
                [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            }
            
        }else {
            NSLog(@"no data");
        }
    }];
    
}
/*
 // Fix json data keys without quotes
- (NSString *)fixJSON:(NSString *)s {
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"[{,]\\s*(\\w+)\\s*:"
                                                                            options:0
                                                                              error:NULL];
    NSMutableString *b = [NSMutableString stringWithCapacity:([s length] * 1.1)];
    __block NSUInteger offset = 0;
    [regexp enumerateMatchesInString:s
                             options:0
                               range:NSMakeRange(0, [s length])
                          usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                              NSRange r = [result rangeAtIndex:1];
                              [b appendString:[s substringWithRange:NSMakeRange(offset, r.location - offset)]];
                              [b appendString:@"\""];
                              [b appendString:[s substringWithRange:r]];
                              [b appendString:@"\""];
                              offset = r.location + r.length;
                          }];
    [b appendString:[s substringWithRange:NSMakeRange(offset, [s length] - offset)]];
    return b;
}
*/
# pragma mark - set buttons

- (IBAction)ageSliderValueChanged:(id)sender {
    _ageTextField.text = [NSString stringWithFormat:@"%d", (int)_ageSlider.value];
}
- (IBAction)ageTextFieldValueChanged:(UITextField *)sender {
    [_ageSlider setValue: [sender.text floatValue] animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return rowsCount;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:self.tableView cellForRowAtIndexPath:indexPath];
    
    if ([_requirementsArray containsObject:cell])  {
        CGFloat height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
        //NSLog(@"contain the cell:%d, height:%d", (int)indexPath.row, (int)height);
        return height;
    }else {
        //NSLog(@"do not contain cell:%@", cell.reuseIdentifier);
        return 0;
    }
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [_requirementsArray objectAtIndex:indexPath.row];
    
    if ([cellIdentifier isEqualToString:@"gender"]) {
        GenderTableViewCell *genderCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        return genderCell;
    } else if ([cellIdentifier isEqualToString:@"age"]) {
        AgeTableViewCell *ageCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        return ageCell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        return cell;

    }
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
