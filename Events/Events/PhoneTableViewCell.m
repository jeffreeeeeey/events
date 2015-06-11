//
//  PhoneTableViewCell.m
//  
//
//  Created by mac on 6/11/15.
//
//

#import "PhoneTableViewCell.h"

@implementation PhoneTableViewCell

- (void)awakeFromNib {
    // Initialization code
    keyString = @"phone";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)getKeyString {
    
    return keyString;
}

- (NSString *)getValueString {
    return _phoneTextField.text;
}


@end
