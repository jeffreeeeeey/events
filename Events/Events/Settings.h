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
#define apply @"http://192.168.1.80:9090/huodong/api/activity/apply"
/*
 报名可以提交以下字段，值都为纯文本
 
 'username': {name: '姓名'},
 'gender': {name: '性别'},
 'age': {name: '年龄'},
 'idcard': {name: '身份证'},
 'address': {name: '小区'},
 'phone': {name: '电话'},
 'qq': {name: 'QQ'},
 'industry': {name: '行业'},
 'company': {name: '工作单位'},
 'position': {name: '职位'}

 */

#define applicationFactors @[@"姓名", @"年龄", @"性别", @"身份证", @"小区", @"QQ号", @"电话", @"行业", @"工作单位", @"职位", @"图片"]

#endif
