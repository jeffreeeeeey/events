//
//  UserNameTableViewCell.m
//  
//
//  Created by mac on 6/11/15.
//
//

#import "UserNameTableViewCell.h"

@implementation UserNameTableViewCell

- (void)awakeFromNib {
    // Initialization code
    keyString = @"username";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSString *)getKeyString {

    return keyString;
}


- (NSString *)getValueString {
    return _userNameTextField.text;
}

@end
