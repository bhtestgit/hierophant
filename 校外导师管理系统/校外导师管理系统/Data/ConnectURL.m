//
//  ConnectURL.m
//  校外导师
//
//  Created by 柏涵 on 16/5/19.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "ConnectURL.h"
@implementation ConnectURL
static NSMutableString *url = nil;

+(NSString *)shareURL {
    if (!url) {
        url = [NSMutableString stringWithFormat:@"http://192.168.1.104:8080/Myservlet/LonginServlet"];
    }
    
    return (NSString *)url;
}

+(void)setUrl:(NSMutableString *)newUrl {
    url = newUrl;
}

@end
