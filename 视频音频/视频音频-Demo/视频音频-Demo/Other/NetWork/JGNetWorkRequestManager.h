//
//  JGNetWorkRequestManager.h
//  视频音频-Demo
//
//  Created by stkcctv on 16/8/25.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestType) {
    GET,
    POST
};

typedef void (^SuccessBlock) (NSData *data);
typedef void (^FailureBlock) (NSError *error);


@interface JGNetWorkRequestManager : NSObject

@property (nonatomic, copy) SuccessBlock success;
@property (nonatomic, copy) FailureBlock failure;

+ (void)requestWIthType:(RequestType)type urlString:(NSString *)urlString parDic:(NSDictionary *)parDic success:(SuccessBlock)success failure:(FailureBlock)failure;

@end
