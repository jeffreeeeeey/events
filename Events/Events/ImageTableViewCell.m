//
//  ImageTableViewCell.m
//  
//
//  Created by mac on 6/11/15.
//
//

#import "ImageTableViewCell.h"

@implementation ImageTableViewCell
@dynamic imageView;

- (void)awakeFromNib {
    // Initialization code
    keyString = @"img";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)getKeyString {
    
    return keyString;
}

- (NSString *)getValueString {
    return @"";
}

@end
