//
//  GetTitlesByHieroId.h
//  校外导师
//
//  Created by 柏涵 on 16/5/24.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetTitlesByHieroId : NSObject
//获取所有题目包括缓存题目
-(void)getTitlesByHieroId:(NSString *)name;
@end
