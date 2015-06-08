//
//  EventListTableViewCell.h
//  Events
//
//  Created by mac on 5/26/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventTableViewCell : UITableViewCell

@property (strong, nonatomic) Event *event;
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end
