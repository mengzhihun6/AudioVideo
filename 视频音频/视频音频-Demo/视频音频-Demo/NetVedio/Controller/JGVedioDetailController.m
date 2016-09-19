//
//  JGVedioDetailController.m
//  视频音频-Demo
//
//  Created by stkcctv on 16/8/26.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGVedioDetailController.h"
#import "WMPlayer.h"

#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHight [UIScreen mainScreen].bounds.size.height

@interface JGVedioDetailController ()

@property (nonatomic, strong) WMPlayer *wmPlayer;


@end

@implementation JGVedioDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat y = kDeviceHight / 3.0 - 0.5 * (kDeviceHight / 3.0);
    
    WMPlayer *wmplayer = [[WMPlayer alloc] initWithFrame:CGRectMake(0, y, kDeviceWidth, kDeviceWidth)];
    wmplayer.URLString = self.urlStr;
    [self.view addSubview:wmplayer];
    
    wmplayer.closeBtn.hidden = YES;
    
    [wmplayer.player play];
    _wmPlayer = wmplayer;
}

- (IBAction)dissmissBtnClick:(UIButton *)sender {
    
    [_wmPlayer.player pause];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
