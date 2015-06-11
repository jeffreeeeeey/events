//
//  QQTableViewCell.m
//  
//
//  Created by mac on 6/11/15.
//
//

#import "QQTableViewCell.h"

@implementation QQTableViewCell

- (void)awakeFromNib {
    // Initialization code
    keyString = @"qq";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)getKeyString {
    
    return keyString;
}

- (NSString *)getValueString {
    return _qqTextField.text;
}

@end
