//
//  IDCardTableViewCell.m
//  
//
//  Created by mac on 6/11/15.
//
//

#import "IDCardTableViewCell.h"

@implementation IDCardTableViewCell

- (void)awakeFromNib {
    // Initialization code
    keyString = @"idcard";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)getKeyString {
    
    return keyString;
}

- (NSString *)getValueString {
    return _IDCardTextField.text;
}


@end
