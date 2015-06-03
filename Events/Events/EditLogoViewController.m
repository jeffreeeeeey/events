//
//  EditLogoViewController.m
//  Events
//
//  Created by mac on 5/19/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "EditLogoViewController.h"
#import "setApplicationsTableViewController.h"
#import "Settings.h"
#import "NetworkServices.h"

@interface EditLogoViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, NSURLSessionDataDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@end

@implementation EditLogoViewController

// Get photo
- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)uploadLogo:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }];
        [alert addAction:cameraAction];
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"选择图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
        }];
        [alert addAction:libraryAction];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    _logoImageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    [NetworkServices postInfo:imagesServer sendImage:image sendParams:nil getblock:^(NSString *imageURLString, NSData *data) {
        NSLog(@"returned:%@", imageURLString);
        _event.logoImageURLString = imageURLString;
    }];
}


//- (void)uploadImage:(UIImage *)image getblock:(void(^)(NSString *uString))handler {
//    __block NSString *urlString = [[NSString alloc]init];
//    // create request
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
//    [request setHTTPShouldHandleCookies:NO];
//    [request setTimeoutInterval:30];
//    [request setHTTPMethod:@"POST"];
//    
//    // set Content-Type in HTTP header
//    
//    NSString *boundary = @"-----------qwertyuiop";
//    NSString *fileParamConstant = @"Filedata";
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
//    
//    // post body
//    NSMutableData *body = [NSMutableData data];
//    
//    /*
//    // add params (all params are strings)
//    for (NSString *param in _params) {
//        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//    */
//    // add image data
//    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
//    if (imageData) {
//        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", fileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:imageData];
//        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//    
//    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    // setting the body of the post to the reqeust
//    [request setHTTPBody:body];
//    
//    // set URL
//    [request setURL:[NSURL URLWithString:imagesServer]];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
//    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:body completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSLog(@"dic: %@", dic);
//        BOOL n = [dic valueForKey:@"success"];
//        
//        if (n) {
//            NSString *server = [dic valueForKey:@"server"];
//            NSString *file = [dic valueForKey:@"file"];
//            urlString = [urlString stringByAppendingString:server];
//            urlString = [urlString stringByAppendingString:file];
//            
//            // call the block to set url
//            handler(urlString);
//            //NSLog(@"image url:%@", _event.logoImageURLString);
//        }
//        
//        //NSLog(@"String:%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
//        //NSLog(@"response:%@", response);
//        //NSLog(@"error:%@", error);
//    }];
//    [uploadTask resume];
//
//}

#pragma -mark navigation

/*
// use it when deploy
 
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    BOOL should = YES;
    
    if ([identifier isEqualToString:@"applySettings"]) {
        if (!_event.logoImageURLString) {
            should = NO;
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请上传图片" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
    return should;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    setApplicationsTableViewController *vc = [segue destinationViewController];
    vc.event = _event;
    
}

@end
