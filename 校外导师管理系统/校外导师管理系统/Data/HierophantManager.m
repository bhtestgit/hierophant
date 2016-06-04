//
//  HierophantManager.m
//  校外导师
//
//  Created by 柏涵 on 16/6/4.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "HierophantManager.h"
#import <AFNetworking.h>
#import "ConnectURL.h"

@implementation HierophantManager

+(void)updateHierophantWithData:(NSDictionary *)data {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"UpdateHieroServlet"];
    //设置数据
    NSString *url = [ConnectURL shareURL];
    [manager POST:url parameters:data progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateResult" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

+(void)getHieroByStu:(NSString *)stu {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"GetHieroByStuServlet"];
    //设置数据
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:stu, @"name", nil];
    NSString *url = [ConnectURL shareURL];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotHiero" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

@end
