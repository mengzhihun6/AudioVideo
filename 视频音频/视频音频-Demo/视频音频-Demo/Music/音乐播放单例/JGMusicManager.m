//
//  JGMusicManager.m
//  视频音频-Demo
//
//  Created by stkcctv on 16/8/25.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGMusicManager.h"

@implementation JGMusicManager

+ (instancetype)shareMusicManager {
    
    static JGMusicManager *musicManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        musicManager = [[JGMusicManager alloc] init];
    });
    return musicManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _player = [[AVPlayer alloc] init];
    }
    return self;
}

//播放或暂停
- (void)playAndPause {
    
//    JGLog(@"isPlay: %d",self.isPlay);
    
    if (self.isPlay) {
//        [self playerPlay];
        [self playerPause];
    }else {
//        [self playerPause];
        [self playerPlay];
    }
    
}

//播放
- (void)playerPlay {
    [_player play];
    _isPlay = YES;
}

//暂停
- (void)playerPause {
    [_player pause];
    _isPlay = NO;
}

//播放上一首
- (void)playPrevious {
    if (self.index == 0) {
        self.index = self.musicArray.count - 1;
    }else {
        self.index--;
    }
}

//播放下一首
- (void)playNext {
  
    if (self.index == self.musicArray.count - 1) {
        self.index = 0;
    }else {
        self.index++;
    }
}

- (void)playerVolumeWithVolumeFloat:(CGFloat)volumeFloat {
    self.player.volume = volumeFloat;
}


- (void)playerProgressWithProgressFloat:(CGFloat)progressFloat {
    
    [self.player seekToTime:CMTimeMakeWithSeconds(progressFloat, 1) completionHandler:^(BOOL finished) {
        [self playerPlay];
    }];
}

- (void)replaceItemWIthUrlString:(NSString *)urlString {
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlString]];
    [self.player replaceCurrentItemWithPlayerItem:item];
    [self playerPlay];
}

@end
