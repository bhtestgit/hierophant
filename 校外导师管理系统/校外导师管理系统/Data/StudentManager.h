//
//  StudentManager.h
//  校外导师
//
//  Created by 柏涵 on 16/5/28.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentManager : NSObject

+(void)getStuAndTitleByHiero:(NSString *)name;

+(void)getStuByName:(NSString *)name;

+(void)getAllInterlayerStuWithHieroId:(NSString *)name;

+(void)confirmStudentWithTitle:(NSString *)title andName:(NSString *)name;

+(void)updateStuWithName:(NSString *)name andPassword:(NSString *)password;


+(void)getAllStudentInTitle;
@end
