//
//  TitleManager.h
//  校外导师
//
//  Created by 柏涵 on 16/5/27.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleManager : NSObject

+(void)getAllTitle;

+(void)confirmTitleWithName:(NSString *)name;

+(void)getAllTitleAndHiero;

+(void)selectTitleWithName:(NSString *)name andTitle:(NSString *)title;

+(void)getAllChosenTitleByStu:(NSString *)name;

+(void)deleteChosenTitleWithTitle:(NSString *)title andName:(NSString *)name;

@end
