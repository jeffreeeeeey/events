//
//  AgeTableViewCell.m
//  Events
//
//  Created by mac on 5/28/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "AgeTableViewCell.h"

@interface AgeTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UISlider *ageSlider;


@end

@implementation AgeTableViewCell


- (void)awakeFromNib {
    // Initialization code
    _ageTextField.text = [NSString stringWithFormat:@"%d", (int)_ageSlider.value];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)ageSliderValueChanged:(UISlider *)sender {
    NSNumber *value = [NSNumber numberWithFloat:sender.value];
    _ageTextField.text = [NSString stringWithFormat:@"%d",[value intValue]];
    
}


@end
