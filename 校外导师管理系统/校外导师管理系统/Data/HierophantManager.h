//
//  HierophantManager.h
//  校外导师
//
//  Created by 柏涵 on 16/6/4.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HierophantManager : NSObject

+(void)updateHierophantWithData:(NSDictionary *)data;

+(void)getHieroByStu:(NSString *)stu;

@end
