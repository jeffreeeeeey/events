//
//  CompanyTableViewCell.m
//  
//
//  Created by mac on 6/11/15.
//
//

#import "CompanyTableViewCell.h"

@implementation CompanyTableViewCell

- (void)awakeFromNib {
    // Initialization code
    keyString = @"company";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)getKeyString {
    
    return keyString;
}

- (NSString *)getValueString {
    return _companyTextField.text;
}

@end
