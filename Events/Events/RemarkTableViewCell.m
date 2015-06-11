//
//  RemarkTableViewCell.m
//  
//
//  Created by mac on 6/11/15.
//
//

#import "RemarkTableViewCell.h"

@implementation RemarkTableViewCell

- (void)awakeFromNib {
    // Initialization code
    keyString = @"remark";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)getKeyString {
    
    return keyString;
}

- (NSString *)getValueString {
    return _remarkTextField.text;
}

@end
