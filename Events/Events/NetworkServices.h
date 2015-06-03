//
//  Services.h
//  Events
//
//  Created by mac on 6/2/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//@protocol fetchDataResponseDelegate <NSObject>
//
//@required
//- (void)didFinishRequestWithData:(NSData *)responseData;
//
//@end


@interface NetworkServices : NSObject

//@property (nonatomic, strong)NSObject <fetchDataResponseDelegate> *delegate;

+ (void)postInfo:(NSString *)urlString sendImage:(UIImage *)image sendParams:(NSDictionary *)params getblock:(void(^)(NSData *data, NSError *error))handler;

+ (void)fetchData:(NSString *)urlString getData:(void(^)(NSData *data, NSError *error))handler;

+ (void)postData:(NSString *)urlString setParam:(NSDictionary *)params getData:(void(^)(NSData *data, NSError *error))handler;
@end
