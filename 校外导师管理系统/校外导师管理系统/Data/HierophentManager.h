//
//  HierophentManager.h
//  校外导师
//
//  Created by 柏涵 on 16/5/26.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HierophentManager : NSObject

//得到所有申请者
+(void)getAllInterHiero;

+(void)getInterHieroByName:(NSString *)name withUrl:(NSString *)url;

+(void)agreeHieroApplyWithName:(NSString *)name;

+(void)refuseHieroApplyWithName:(NSString *)name;

@end
