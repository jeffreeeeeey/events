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
#import "NetworkServices.h"

@interface NetworkServices () <NSURLSessionDelegate, NSURLConnectionDelegate>

@end

@implementation NetworkServices

- (instancetype)init {
    self = [super init];
    return self;
}


+ (void)postInfo:(NSString *)urlString sendImage:(UIImage *)image sendParams:(NSDictionary *)params getblock:(void(^)(NSData *data, NSError *error))handler {
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
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; charset=utf-8; boundary=%@", boundary];
    
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
         
            //NSLog(@"image url:%@", _event.logoImageURLString);
        }
        */
        handler(data, error);
        NSLog(@"String:%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"response:%@", response);
        NSLog(@"error:%@", error);
    }];
    [uploadTask resume];
    
}

// use get
+ (void)fetchData:(NSString *)urlString getData:(void(^)(NSData *data, NSError *error))handler
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultConfigObject.timeoutIntervalForRequest = 10;
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:urlString];

    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data.length > 0 && error == nil) {
            // Send it back
            //NSLog(@"send data back:%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            handler(data, nil);
            //[self.delegate didFinishRequestWithData:data];
            
        } else if (data.length == 0 && error == nil){
            NSLog(@"no data around");
            
        } else if (error) {
            NSString *description = [error localizedDescription];
            
            handler(nil, error);
        }
    }];
    [dataTask resume];
}

+ (void)postData:(NSString *)urlString setParam:(NSDictionary *)params getData:(void(^)(NSData *data, NSError *error))handler{
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *paramString = @"";
    if (params) {
        NSArray *keys = [params allKeys];
        NSArray *values = [params allValues];
        int n = (int)keys.count;
        for (int i = 0; i < n; i++) {
            paramString = [paramString stringByAppendingFormat:@"%@=%@", keys[i], values[i]];
            if (i < n - 1) {
                paramString = [paramString stringByAppendingString:@"&"];
            }
        }
        
    }
    
    //NSString *paramString = [NSString stringWithFormat:@"username=admin&password=111111"];
    //NSString *params = @"activityId=10011&username=test";
    NSLog(@"post:url:%@ params:%@", url, paramString);
    
    NSString *postLength = [NSString stringWithFormat:@"%lud", (unsigned long)[paramString length]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[NSData dataWithBytes:[paramString UTF8String] length:strlen([paramString UTF8String])]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length > 0 && connectionError == nil) {
            handler(data, nil);
        } else {
            handler(nil, connectionError);
        }
        
        //NSLog(@"%@, %@", response, [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        
    }];
    
}

@end
