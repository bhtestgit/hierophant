//
//  InterlayerTitle.h
//  校外导师
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
@interface InterlayerTitle : JSONModel
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *detail;
@property (nonatomic) NSString *hieroId;
@property (nonatomic) NSString *student1Id;
@property (nonatomic) NSString *student2Id;
@property (nonatomic) NSString *student3Id;
@end
