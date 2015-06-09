//
//  EventContentTableViewCell.h
//  Events
//
//  Created by mac on 6/9/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDetailsViewController.h"

@interface EventContentTableViewCell : UITableViewCell <UIWebViewDelegate>
@property (nonatomic, assign) float height;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

+ (CGFloat)heightForCellWithContent:(NSString *)content;

@end
