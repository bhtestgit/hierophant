//
//  BaseViewController.h
//  校外导师
//
//  Created by 柏涵 on 16/3/2.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (instancetype)initWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSInteger)tag;

-(void)initializeAppearance;

@property (nonatomic,copy)NSString *currentTitle;
@property (nonatomic,copy)NSString *imageName;

@end
