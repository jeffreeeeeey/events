//
//  Settings.h
//  Events
//
//  Created by mac on 5/19/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#ifndef Events_Settings_h
#define Events_Settings_h

// 0 for production, 1 for issll, 2 for development

#define ENV 2

#if ENV==2
#define BASE_URL @"http://192.168.1.80:9090/huodong"
#define imagesServer @"http://image.issll.com/iserver/upload/mobile?key=abcdefghijklmn123456"

#define createEvent [NSString stringWithFormat: @"%@/api/admin/activity", BASE_URL]
#define topicList @"http://mpc.issll.com/llzgmri/m/p/topic/getPlotTopicsByType?type=2&page=1&long=116.501426&lat=39.921523"
#define topicDetail @"http://mpc.issll.com/llzgmri/m/p/topic/queryTopic?topicid=%@&page=1&userid="

#define eventList [NSString stringWithFormat:@"%@/api/activity", BASE_URL]
#define eventDetail [NSString stringWithFormat:@"%@/api/activity/", BASE_URL]
#define apply @"http://192.168.1.80:9090/huodong/api/activity/apply"
#define applications @"http://192.168.1.80:9090/huodong/api/admin/activity/%@/applies"
#define getUser [NSString stringWithFormat:@"%@/api/admin/activity/userinfo", BASE_URL];
#define loginURL [NSString stringWithFormat:@"%@/api/user/login", BASE_URL];


#elif EVN==1

#define BASE_URL @"http://cbd.issll.com/event"

#define imagesServer @"http://image.issll.com/iserver/upload/mobile?key=abcdefghijklmn123456"

#define createEvent [NSString stringWithFormat: @"%@/api/admin/activity", BASE_URL]
#define eventList [NSString stringWithFormat: @"%@/api/activity", BASE_URL]
#define eventDetail  [NSString stringWithFormat: @"%@/api/activity/", BASE_URL]
#define apply  [NSString stringWithFormat: @"%@/api/activity/apply", BASE_URL]
#define applications [NSString stringWithFormat: @"%@/api/admin/activity/\%\@/applies", BASE_URL]

#define getUser [NSString stringWithFormat: @"%@/api/admin/activity/userinfo", BASE_URL]
#define loginURL [NSString stringWithFormat:@"%@/api/user/login", BASE_URL];

#elif EVN==0

#define BASE_URL @"http://cbd.issll.com/event"

#define createEvent [NSString stringWithFormat: @"%@/api/admin/activity", BASE_URL]
#define eventList [NSString stringWithFormat: @"%@/api/activity", BASE_URL]
#define eventDetail  [NSString stringWithFormat: @"%@/activity/", BASE_URL]
#define apply  [NSString stringWithFormat: @"%@/api/activity/apply", BASE_URL]
#define applications [NSString stringWithFormat: @"%@/api/admin/activity/\%\@/applies", BASE_URL]

#define getUser [NSString stringWithFormat: @"%@/api/admin/activity/userinfo", BASE_URL]
#define loginURL [NSString stringWithFormat:@"%@/api/user/login", BASE_URL];
//图片服务器
#define imagesServer @"http://image.llzg.cn/iserver/upload/mobile?key=abcdefghijklmn123456"


#endif

/*
 报名可以提交以下字段，值都为纯文本
 activityid
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

 /api/admin/activity GET 活动列表
 /api/admin/activity/:id GET 单条活动
 /api/admin/activity/:id/applies GET 报名者列表
 
 /api/admin/activity POST 新增/编辑 活动（id为空时为新增）
 
 /api/admin/activity/:id/delete POST 删除活动
 

 
 */
//图片服务器
//<form name="muform1" enctype="multipart/form-data" action="http://image.issll.com/iserver/upload/mobile" method="POST"> <input type="file" name="Filedata" /> <input type="hidden" name="key" value="abcdefghijklmn123456"/ > <input type="submit" value="提交"/>
// 注意在提交时，file 名称要用 Filedata

#define eventClassifications @[@"线上", @"亲子", @"公益", @"运动", @"旅行", @"美食", @"优惠", @"比赛", @"跳蚤市场", @"聚会", @"科技", @"创业"]

#define applicationFactors @[@"姓名", @"年龄", @"性别", @"身份证", @"小区", @"QQ号", @"电话", @"行业", @"工作单位", @"职位", @"图片"]
#define applicationFactorsName @[@"username", @"age", @"gender", @"idcard", @"address", @"qq", @"phone", @"industry", @"company", @"position", @"img"]

#endif
