//
//  IndustryTableViewCell.m
//  
//
//  Created by mac on 6/11/15.
//
//

#import "IndustryTableViewCell.h"

@implementation IndustryTableViewCell

- (void)awakeFromNib {
    // Initialization code
    keyString = @"industry";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSString *)getKeyString {
    
    return keyString;
}

- (NSString *)getValueString {
    return _industryLabel.text;
}

@end
