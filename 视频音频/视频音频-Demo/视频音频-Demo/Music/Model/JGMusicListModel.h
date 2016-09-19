//
//  JGMusicListModel.h
//  视频音频-Demo
//
//  Created by stkcctv on 16/8/25.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGMusicListModel : NSObject

// 图片
@property (nonatomic, copy) NSString *coverLarge;
// 音乐地址
@property (nonatomic, copy) NSString *playUrl32;
// 标题
@property (nonatomic, strong) NSString *title;

@end
