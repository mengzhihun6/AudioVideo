//
//  JGVedioModel.h
//  视频音频-Demo
//
//  Created by stkcctv on 16/8/26.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGVedioModel : NSObject

/** 视频连接  */
@property(nonatomic, copy) NSString *videouri;
/** 提供者图像  */
@property(nonatomic, copy) NSString *profile_image;
/** 视频说明  */
@property(nonatomic, copy) NSString *text;
/** 提供者名称  */
@property(nonatomic, copy) NSString *name;
/** 播放时长  */
@property(nonatomic, copy) NSString *videotime;
/** 图片  */
@property(nonatomic, copy) NSString *cdn_img;
/** 播放次数  */
@property(nonatomic, assign) int playcount;
/** 时间  */
@property(nonatomic, copy) NSString *create_time;

@end
