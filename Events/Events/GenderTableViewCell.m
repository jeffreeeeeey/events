//
//  GenderTableViewCell.m
//  Events
//
//  Created by mac on 5/28/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "GenderTableViewCell.h"

@interface GenderTableViewCell ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegment;

@end

@implementation GenderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
