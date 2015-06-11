//
//  AgeTableViewCell.h
//  Events
//
//  Created by mac on 5/28/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyTableViewCell.h"

@interface AgeTableViewCell : ApplyTableViewCell

@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@property (weak, nonatomic) IBOutlet UISlider *ageSlider;



@end
