//
//  JobTitleTableViewCell.m
//  
//
//  Created by mac on 6/11/15.
//
//

#import "JobTitleTableViewCell.h"

@implementation JobTitleTableViewCell

- (void)awakeFromNib {
    // Initialization code
    keyString = @"position";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)getKeyString {
    
    return keyString;
}

- (NSString *)getValueString {
    return _jobTitleTextField.text;
}

@end
