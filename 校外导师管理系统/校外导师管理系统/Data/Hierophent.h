//
//  Hierophent.h
//  校外导师
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
@interface Hierophent : JSONModel
@property (nonatomic)NSString* name;
@property (nonatomic)NSString* password;
@property (nonatomic)NSString* sex;
@property (nonatomic)NSString* birthday;
@property (nonatomic)NSString* pft;
@property (nonatomic)NSString* skills;
@property (nonatomic)NSString* timeOfPft;
@property (nonatomic)NSString* workUnit;
@property (nonatomic)NSString* positions;
@property (nonatomic)NSString* phone;
@property (nonatomic)NSString* email;
@property (nonatomic)NSString* experience;
@end
