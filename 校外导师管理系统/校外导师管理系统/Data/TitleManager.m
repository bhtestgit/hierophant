//
//  TitleManager.m
//  校外导师
//
//  Created by 柏涵 on 16/5/27.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "TitleManager.h"
#import <AFNetworking.h>
#import "ConnectURL.h"

@implementation TitleManager

+(void)getAllTitle {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"GetAllTitlesServlet"];
    NSString *url = [ConnectURL shareURL];
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotTitles" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

+(void)getAllTitleAndHiero {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"GetAllTitleAndHieroServlet"];
    NSString *url = [ConnectURL shareURL];
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotTitlesAndHieros" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

+(void)confirmTitleWithName:(NSString *)name{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"ConfirmTitleServlet"];
    //设置数据
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name, @"name", nil];
    NSString *url = [ConnectURL shareURL];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"confirmTitle" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

+(void)selectTitleWithName:(NSString *)name andTitle:(NSString *)title {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"ChooseTitleServlet"];
    //设置数据
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name, @"name", title, @"title" ,nil];
    NSString *url = [ConnectURL shareURL];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseTitle" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

+(void)getAllChosenTitleByStu:(NSString *)name {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"GetChosenByStuServlet"];
    //设置数据
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name, @"name", nil];
    NSString *url = [ConnectURL shareURL];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotAllChoisen" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

+(void)deleteChosenTitleWithTitle:(NSString *)title andName:(NSString *)name {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"DeleteNameFromChosen"];
    //设置数据
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name, @"name", title, @"title", nil];
    NSString *url = [ConnectURL shareURL];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteChosen" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

+(void)confirmScoreWithTitle:(NSString *)title andScore:(NSString *)score {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"ConfirmScoreServlet"];
    //设置数据
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:score, @"score", title, @"title", nil];
    NSString *url = [ConnectURL shareURL];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"scoreResult" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

+(void)getTitleByStu:(NSString *)name {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"GetTitleByStu"];
    //设置数据
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name, @"name", nil];
    NSString *url = [ConnectURL shareURL];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotFinalTitle" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

@end
