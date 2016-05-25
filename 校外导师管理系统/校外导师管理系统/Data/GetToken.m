//
//  GetToken.m
//  校外导师
//
//  Created by 柏涵 on 16/5/24.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "GetToken.h"
#import<CommonCrypto/CommonDigest.h>
#import <RongIMKit/RongIMKit.h>
#import <AFNetworking.h>

@implementation GetToken
static GetToken *getToken;

+(GetToken *)getToken {
    if (!getToken) {
        getToken = [[GetToken alloc] init];
    }
    return getToken;
}

-(void)getTokenWithUid:(NSString *)uid {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlstr =@"https://api.cn.rong.io/user/getToken.json";
    NSDictionary *dic =@{@"userId":uid,
                         @"name":uid,
                         @"portraitUri":@""
                         };
    
    NSString * timestamp = [[NSString alloc] initWithFormat:@"%ld",(NSInteger)[NSDate timeIntervalSinceReferenceDate]];
    NSString * nonce = [NSString stringWithFormat:@"%d",arc4random()];
    NSString * appkey = @"lmxuhwagxqiqd";
    NSString * Signature = [self sha1:[NSString stringWithFormat:@"%@%@%@",appkey,nonce,timestamp]];//用sha1对签名进行加密,随你用什么方法,MD5...
    //以下拼接请求内容
    [manager.requestSerializer setValue:appkey forHTTPHeaderField:@"App-Key"];
    [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
    [manager.requestSerializer setValue:Signature forHTTPHeaderField:@"Signature"];
    [manager.requestSerializer setValue:@"zkjADtqNAGO9Je" forHTTPHeaderField:@"appSecret"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //开始请求
    [manager POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = responseObject;
        NSString *token = [result objectForKey:@"token"];
        //设置自己token
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"没有获取到token");
    }];
}

-(void)connectViewRongyun {
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}

- (NSString *) sha1:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}
@end
