//
//  GetToken.h
//  校外导师
//
//  Created by 柏涵 on 16/5/24.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetToken : NSObject

+(GetToken *)getToken;

-(void)getTokenWithUid:(NSString *)uid;

-(void)connectViewRongyun;

@end
