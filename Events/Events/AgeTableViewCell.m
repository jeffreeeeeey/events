//
//  AgeTableViewCell.m
//  Events
//
//  Created by mac on 5/28/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "AgeTableViewCell.h"

@interface AgeTableViewCell ()




@end

@implementation AgeTableViewCell


- (void)awakeFromNib {
    // Initialization code
    _ageTextField.text = [NSString stringWithFormat:@"%d", (int)_ageSlider.value];
    keyString = @"age";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)editAge:(id)sender {
    NSInteger n =  [_ageTextField.text intValue];
    [_ageSlider setValue:n animated:YES];
}

- (IBAction)ageSliderValueChanged:(UISlider *)sender {
    NSNumber *value = [NSNumber numberWithFloat:sender.value];
    _ageTextField.text = [NSString stringWithFormat:@"%d",[value intValue]];
    
}

- (NSString *)getKeyString {
    
    return keyString;
}

- (NSString *)getValueString {
    return _ageTextField.text;
}


@end
