//
//  RegistController.h
//  校外导师
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegistController : NSObject

-(void)registWithName:(NSMutableString *)name password:(NSMutableString *)password;

/*create table if not exists hierophant(name text primary key, password text, sex text, birthday text, PFT text, skills text, timeOfPFT text, workUnit text, positions text, phone int, email text, experience text*/

-(void)registWithHieroName:(NSMutableString *)name password:(NSMutableString *)password sex:(NSMutableString *)sex birthday:(NSMutableString *)birthday PFT:(NSMutableString *)PFT skills:(NSMutableString *)skills timeOfPFT:(NSMutableString *)timeOfPFT workUnit:(NSMutableString *)workUnit positions:(NSMutableString *)positions phone:(NSMutableString *)phone email:(NSMutableString *)email experience:(NSMutableString *)experience;

@end
