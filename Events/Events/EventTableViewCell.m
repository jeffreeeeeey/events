//
//  EventListTableViewCell.m
//  Events
//
//  Created by mac on 5/26/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "EventTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface EventTableViewCell ()


@end

@implementation EventTableViewCell

@synthesize titleLabel, subtitleLabel;

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

- (void)setEvent:(Event *)event {
    _event = event;
    
    self.titleLabel.text = _event.title;
    self.subtitleLabel.text = _event.subtitle;
    self.addressLabel.text = _event.address;
    [self.eventImageView setImageWithURL:_event.logoImageURL placeholderImage:[UIImage imageNamed:@"logo.png"]];
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
