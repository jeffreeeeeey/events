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
#import "AlertsViewController.h"
#import "AFNetworking.h"

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
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);

    AFLLZGEventsAPIClient *manager = [AFLLZGEventsAPIClient sharedClient];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", nil];
    NSURLSessionDataTask *task = [manager POST:imagesServer parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"Filedata" fileName:@"logo.jpg" mimeType:@"image/jpeg"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Success:%@", responseObject);

        NSDictionary *dic = responseObject;
                    NSString *server = [dic valueForKey:@"server"];
            NSString *file = [dic valueForKey:@"file"];
            NSString *urlString = [NSString stringWithFormat:@"%@,%@",server,file];
            //urlString = [urlString stringByAppendingString:server];
            //urlString = [urlString stringByAppendingString:file];
            NSLog(@"image url:%@", urlString);
            _event.logoImageURL = [NSURL URLWithString:urlString];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error:%@", error);
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[error localizedDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
    [task resume];
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
