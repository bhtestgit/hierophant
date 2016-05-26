//
//  HierophentManager.m
//  校外导师
//
//  Created by 柏涵 on 16/5/26.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "HierophentManager.h"
#import <AFNetworking.h>
#import "ConnectURL.h"

@implementation HierophentManager

+(void)getAllInterHiero {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"GetAllInterHiero"];
    NSString *url = [ConnectURL shareURL];
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotHieros" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

+(void)getInterHieroByName:(NSString *)name withUrl:(NSString *)url{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name, @"name", nil];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotOneHiero" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

+(void)agreeHieroApplyWithName:(NSString *)name {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"ConfirmHierophant"];
    NSString *url = [ConnectURL shareURL];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name, @"name", nil];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"agreeResult" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

+(void)refuseHieroApplyWithName:(NSString *)name {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"DeleteInterHieroServlet"];
    NSString *url = [ConnectURL shareURL];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name, @"name", nil];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refuseResult" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

@end
