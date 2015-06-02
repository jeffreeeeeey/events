//
//  Services.m
//  Events
//
//  Created by mac on 6/2/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Settings.h"
#import "Services.h"

@interface Services () <NSURLSessionDelegate>

@end

@implementation Services

- (instancetype)init {
    self = [super init];
    return self;
}


+ (void)postInfo:(NSString *)urlString sendImage:(UIImage *)image sendParams:(NSDictionary *)params getblock:(void(^)(NSString *imageURLString, NSData *data))handler {
    ;
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    
    NSString *boundary = @"-----------qwertyuiop";
    NSString *fileParamConstant = @"Filedata";
    NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=utf-8", boundary];
    
    //NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    

     // add params (all params are strings)
    if (params) {
        for (NSString *param in params) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }

    // add image data
    if (image) {
        NSLog(@"post image");
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        if (imageData) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", fileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:imageData];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set URL
    [request setURL:[NSURL URLWithString:urlString]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:body completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        /*
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"dic: %@", dic);
        BOOL n = [dic valueForKey:@"success"];
        
        if (n) {
            NSString *server = [dic valueForKey:@"server"];
            NSString *file = [dic valueForKey:@"file"];
            urlString = [urlString stringByAppendingString:server];
            urlString = [urlString stringByAppendingString:file];
            
            // call the block to set url
            handler(urlString, data);
            //NSLog(@"image url:%@", _event.logoImageURLString);
        }
        */
        NSLog(@"String:%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"response:%@", response);
        NSLog(@"error:%@", error);
    }];
    [uploadTask resume];
    
}

// use get
- (void)fetchData:(NSString *)urlString getData:(void(^)(NSData *data, NSError *error))handler
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultConfigObject.timeoutIntervalForRequest = 10;
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:eventList];
    NSLog(@"get event list:%@", url);
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data.length > 0 && error == nil) {
            // Send it back
            handler(data, nil);
            
        } else if (data.length == 0 && error == nil){
            NSLog(@"no data around");
            
        } else if (error) {
            NSString *description = [error localizedDescription];
            
            handler(nil, error);
        }
    }];
    [dataTask resume];
}

@end
