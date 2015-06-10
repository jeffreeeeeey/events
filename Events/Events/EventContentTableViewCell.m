//
//  EventContentTableViewCell.m
//  Events
//
//  Created by mac on 6/9/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "EventContentTableViewCell.h"

@implementation EventContentTableViewCell

- (void)awakeFromNib {
    // Initialization code

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
