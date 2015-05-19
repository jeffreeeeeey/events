//
//  capacityCell.m
//  Events
//
//  Created by mac on 5/18/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "CapacityCell.h"

@implementation CapacityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor grayColor];
        [self addSubview:_capacitySegment];
    }
    return self;
}

- (void)viewDidLoad {


}



@end
