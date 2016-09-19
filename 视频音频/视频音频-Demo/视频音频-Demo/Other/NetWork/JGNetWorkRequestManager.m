//
//  JGNetWorkRequestManager.m
//  视频音频-Demo
//
//  Created by stkcctv on 16/8/25.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGNetWorkRequestManager.h"

@implementation JGNetWorkRequestManager

+ (void)requestWIthType:(RequestType)type urlString:(NSString *)urlString parDic:(NSDictionary *)parDic success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    JGNetWorkRequestManager *manager = [[JGNetWorkRequestManager alloc] init];
    [manager requestWithType:type urlString:urlString parDic:parDic success:success failure:failure];
    
}

- (void)requestWithType:(RequestType)type urlString:(NSString *)urlString parDic:(NSDictionary *)parDic success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    //保留Block
    self.success = success;
    self.failure = failure;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    if (type == POST) {
        [request setHTTPMethod:@"POST"];
        if (parDic.count > 0) {
            NSData *data = [self parDIcToDataWIthDic:parDic];
            [request setHTTPBody:data];
        }
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            self.success(data);
        }else {
            self.failure(error);
        }
    }];
    [task resume];
    
}


- (NSData *)parDIcToDataWIthDic:(NSDictionary *)dict {
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in dict) {
        NSString *str = [NSString stringWithFormat:@"%@=%@",key,dict[key]];
        [array addObject:str];
    }
    NSString *parString = [array componentsJoinedByString:@"&"];
    return [parString dataUsingEncoding:NSUTF8StringEncoding];
}



@end
