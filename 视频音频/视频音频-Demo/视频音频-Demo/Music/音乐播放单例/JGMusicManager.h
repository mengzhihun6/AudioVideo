//
//  JGMusicManager.h
//  视频音频-Demo
//
//  Created by stkcctv on 16/8/25.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface JGMusicManager : NSObject

/** 音乐数组  */
@property (nonatomic, strong)NSMutableArray *musicArray;
/** 索引 */
@property (nonatomic, assign) NSInteger index;
/** 是否播放 */
@property (nonatomic, assign) BOOL isPlay;
/** player  */
@property (nonatomic, strong)AVPlayer *player;

+ (instancetype)shareMusicManager;

- (void)playAndPause;
- (void)playPrevious;
- (void)playNext;
- (void)replaceItemWIthUrlString:(NSString *)urlString;
- (void)playerVolumeWithVolumeFloat:(CGFloat)volumeFloat;
- (void)playerProgressWithProgressFloat:(CGFloat)progressFloat;


@end
