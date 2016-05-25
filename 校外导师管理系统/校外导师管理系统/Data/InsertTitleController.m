//
//  InsertTitleController.m
//  校外导师
//
//  Created by 柏涵 on 16/5/24.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "InsertTitleController.h"
#import <AFNetworking.h>
#import "ConnectURL.h"
#import <SVProgressHUD.h>


@implementation InsertTitleController

-(void)insertTitleIntServersWithTitle:(InterlayerTitle *)title {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [SVProgressHUD show];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"InsertInterlayerServlet"];
    NSString *url = [ConnectURL shareURL];
    //数据
    NSDictionary *data = [title toDictionary];
    //连接服务器
    [manager POST:url parameters:data progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"insertResult" object:responseObject];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接服务器失败");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
    }];
}

-(void)updateTitleInServletWithOldTitle:(NSString *)oldTitle andNewTitle:(NSString *)newTitle andNewDetail:(NSString *)newDetail {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [SVProgressHUD show];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"UpdateInterlayerServlet"];
    NSString *url = [ConnectURL shareURL];
    //数据
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:oldTitle forKey:@"oldTitle"];
    [data setObject:newTitle forKey:@"newName"];
    [data setObject:newDetail forKey:@"newDetail"];
    NSLog(@"%@", data);
    //连接服务器
    [manager POST:url parameters:data progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateResult" object:responseObject];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接服务器失败");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
    }];
}

@end
