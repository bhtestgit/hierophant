//
//  Student.h
//  校外导师
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

@interface Student : JSONModel
@property (nonatomic)NSString* name;
@property (nonatomic)NSString* password;
@end
