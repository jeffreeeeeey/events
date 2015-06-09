//
//  EventContentTableViewCell.m
//  Events
//
//  Created by mac on 6/9/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "EventContentTableViewCell.h"

@implementation EventContentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _contentWebView.delegate = self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)heightForCellWithContent:(NSString *)content{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 240.f, 100.f)];
    CGRect frame = webView.frame;
    frame.size.height = 1;
    
    webView.frame = frame;
    frame.size = [webView sizeThatFits:CGSizeZero];
    frame.size.height += 44.0f;
    webView.frame = frame;
    
    CGFloat height = frame.size.height;

    return height;
}

#pragma mark - webView

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (error) {
        NSLog(@"load webView error:%@", error);
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    CGRect frame = _contentWebView.frame;
    frame.size.height = 1;
    _contentWebView.frame = frame;
    frame.size = [_contentWebView sizeThatFits:CGSizeZero];
    frame.size.height += 44.0f;
    _contentWebView.frame = frame;

    float height = frame.size.height;
    NSLog(@"in cell, webView height:%f", height);

}


@end
