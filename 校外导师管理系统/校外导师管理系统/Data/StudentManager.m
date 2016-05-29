//
//  StudentManager.m
//  校外导师
//
//  Created by 柏涵 on 16/5/28.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "StudentManager.h"
#import <AFNetworking.h>
#import "ConnectURL.h"

@implementation StudentManager

+(void)getStuAndTitleByHiero:(NSString *)name {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //获取url
        [ConnectURL appendUrl:@"GetAllStuByHiero"];
        //设置数据
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name, @"name", nil];
        NSString *url = [ConnectURL shareURL];
        [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"gotStuAndTitle" object:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSLog(@"连接服务器失败");
        }];
}

+(void)getStuByName:(NSString *)name {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"GetStuByNameServlet"];
    NSString *url = [ConnectURL shareURL];
    //设置数据
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name, @"name", nil];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotMessage" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

+(void)getAllInterlayerStuWithHieroId:(NSString *)name {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"ChooseStudentServlet"];
    NSString *url = [ConnectURL shareURL];
    //设置数据
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name, @"name", nil];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotStudents" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

@end
