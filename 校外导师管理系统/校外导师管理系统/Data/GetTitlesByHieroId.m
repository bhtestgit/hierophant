//
//  GetTitlesByHieroId.m
//  校外导师
//
//  Created by 柏涵 on 16/5/24.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "GetTitlesByHieroId.h"
#import <AFNetworking.h>
#import "ConnectURL.h"
#import "Hierophent.h"

@implementation GetTitlesByHieroId

-(void)getTitlesByHieroId:(NSString *)name {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"GetAllTitleByHieroServlet"];
    NSString *url = [ConnectURL shareURL];
    //设置对象
    Hierophent *hiero = [[Hierophent alloc] init];
    hiero.name = name;
    NSDictionary *dic = hiero.toDictionary;
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotTitles" object:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"连接服务器失败");
    }];
}

@end
