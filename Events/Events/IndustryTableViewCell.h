//
//  IndustryTableViewCell.h
//  
//
//  Created by mac on 6/11/15.
//
//

#import <UIKit/UIKit.h>
#import "ApplyTableViewCell.h"

@interface IndustryTableViewCell : ApplyTableViewCell
@property (strong, nonatomic) NSString *keyString;

@property (weak, nonatomic) IBOutlet UILabel *industryLabel;

@end
