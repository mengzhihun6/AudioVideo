//
//  JGMusicDetailController.m
//  视频音频-Demo
//
//  Created by stkcctv on 16/8/25.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGMusicDetailController.h"
#import "JGMusicListModel.h"

@interface JGMusicDetailController ()

@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;

@property (weak, nonatomic) IBOutlet UIButton *playAndPause;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation JGMusicDetailController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
    self.imgView.layer.cornerRadius = self.imgView.frame.size.width * 0.5;
    self.imgView.clipsToBounds = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [JGMusicManager shareMusicManager].player.volume = self.volumeSlider.value;
    self.progressSlider.value = 0;
    [self reloadDataWithIndex:[JGMusicManager shareMusicManager].index];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAct) userInfo:nil repeats:YES];
    

    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)timerAct {
    
    if ([JGMusicManager shareMusicManager].player.currentTime.timescale == 0 || [JGMusicManager shareMusicManager].player.currentItem.duration.timescale == 0) {
        return;
    }
    
    //获取音乐总时长
    long long int totalTime = [JGMusicManager shareMusicManager].player.currentItem.duration.value / [JGMusicManager shareMusicManager].player.currentItem.duration.timescale;
    //获取当前时间
    long long int currentTime = [JGMusicManager shareMusicManager].player.currentTime.value / [JGMusicManager shareMusicManager].player.currentTime.timescale;
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%02lld:%02lld",currentTime / 60, currentTime % 60];
    self.totalLabel.text = [NSString stringWithFormat:@"%02lld:%02lld",totalTime / 60, totalTime % 60];
    self.progressSlider.maximumValue = totalTime;
    self.progressSlider.minimumValue = 0;
    self.progressSlider.value = currentTime;
    
    if (self.progressSlider.value == totalTime) {
        [[JGMusicManager shareMusicManager] playNext];
        [self reloadDataWithIndex:[JGMusicManager shareMusicManager].index];
    }
    
    if ([JGMusicManager shareMusicManager].isPlay) {
        [UIView beginAnimations:@"rzoration" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.imgView.transform = CGAffineTransformRotate(self.imgView.transform, 0.02);
        [UIView commitAnimations];
    }
}

- (void)reloadDataWithIndex:(NSInteger)index {
   
    //寻找model
    JGMusicListModel *model = [JGMusicManager shareMusicManager].musicArray[index];
    //改变图片 标题 音频
    self.navigationItem.title = model.title;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.coverLarge] placeholderImage:[UIImage imageNamed:kPlaceHolder]];
    //修改播放歌曲
    [[JGMusicManager shareMusicManager] replaceItemWIthUrlString:model.playUrl32];
    
}



- (IBAction)volumeAct:(UISlider *)sender {
    
    [[JGMusicManager shareMusicManager] playerVolumeWithVolumeFloat:sender.value];
    
}

- (IBAction)progressAct:(UISlider *)sender {
    
    [[JGMusicManager shareMusicManager] playerProgressWithProgressFloat:sender.value];
    
}

- (IBAction)previousBtn:(UIButton *)sender {
    
    [self.playAndPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [[JGMusicManager shareMusicManager] playPrevious];
    [self reloadDataWithIndex:[JGMusicManager shareMusicManager].index];
}

- (IBAction)nextBtn:(UIButton *)sender {
    
    [self.playAndPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [[JGMusicManager shareMusicManager] playNext];
    [self reloadDataWithIndex:[JGMusicManager shareMusicManager].index];
    
}
- (IBAction)playOrPauseBtn:(UIButton *)sender {
    
//    JGLog(@"=====  %d",[JGMusicManager shareMusicManager].isPlay);
    
    if ([JGMusicManager shareMusicManager].isPlay) {
        [sender setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }else {
        [sender setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
    [[JGMusicManager shareMusicManager] playAndPause];
}


#pragma mark - 截取锁屏界面的点击事件
- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        switch (receivedEvent.subtype) {
            case UIEventSubtypeRemoteControlPlay:
            {
                [self playOrPauseBtn:self.playAndPause];
//                [self playerOrPause:YES];
            }
                break;
            case UIEventSubtypeRemoteControlPause:
            {
                [self playOrPauseBtn:self.playAndPause];
//                [self playerOrPause:NO];
            }
                break;
            case UIEventSubtypeRemoteControlNextTrack:
            {
                [[JGMusicManager shareMusicManager] playNext];
                [self reloadDataWithIndex:[JGMusicManager shareMusicManager].index];
//                [self touchNextTrack];
            }
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
            {
                [[JGMusicManager shareMusicManager] playPrevious];
                [self reloadDataWithIndex:[JGMusicManager shareMusicManager].index];
//                [self touchPreviousTrack];
            }
                break;
            default:
                NSLog(@"没有处理过这个事件------receivedEvent.subtype==%ld",(long)receivedEvent.subtype);
                break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
