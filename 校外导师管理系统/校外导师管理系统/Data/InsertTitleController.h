//
//  InsertTitleController.h
//  校外导师
//
//  Created by 柏涵 on 16/5/24.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterlayerTitle.h"

@interface InsertTitleController : NSObject

-(void)insertTitleIntServersWithTitle:(InterlayerTitle *)title;

-(void)updateTitleInServletWithOldTitle:(NSString *)oldTitle andNewTitle:(NSString *)newTitle andNewDetail:(NSString *)newDetail;

-(void)deleteTitleInServletWithTitle:(NSString *)title;

@end
