//
//  Settings.h
//  Events
//
//  Created by mac on 5/19/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#ifndef Events_Settings_h
#define Events_Settings_h

#define topicList @"http://mpc.issll.com/llzgmri/m/p/topic/getPlotTopicsByType?type=2&page=1&long=116.501426&lat=39.921523"
#define topicDetail @"http://mpc.issll.com/llzgmri/m/p/topic/queryTopic?topicid=%@&page=1&userid="
#define eventList @"http://192.168.1.80:9090/huodong/api/activity"
#define eventDetail @"http://192.168.1.80:9090/huodong/api/activity/%@"

#define applicationFactors @[@"姓名", @"年龄", @"性别", @"QQ号", @"电话", @"小区", @"身份证", @"图片"]

#endif
