//
//  TopicDetailsViewController.h
//  Events
//
//  Created by mac on 5/7/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventDetailsViewController : UITableViewController <UIWebViewDelegate>

@property (nonatomic) NSDictionary *topicDic;

@end
