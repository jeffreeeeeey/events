//
//  residencesTableViewCell.m
//  
//
//  Created by mac on 6/11/15.
//
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
    keyString = @"address";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)getKeyString {
    
    return keyString;
}

- (NSString *)getValueString {
    return _addressTextField.text;
}


@end
