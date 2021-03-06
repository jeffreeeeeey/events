//
//  GenderTableViewCell.m
//  
//
//  Created by mac on 6/11/15.
//
//

#import "GenderTableViewCell.h"

@implementation GenderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    keyString = @"gender";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)getKeyString {
    
    return keyString;
}

- (NSString *)getValueString {
    NSString *genderString = @"";
    if (_genderSegment.selectedSegmentIndex == 0) {
        genderString = @"male";
    }else{
        genderString = @"female";
    }
    return genderString;
}

@end
