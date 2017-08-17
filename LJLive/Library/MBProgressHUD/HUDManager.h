//
//  HUDManager.h
//  CollectionIphone
//
//  Created by liuyongchao on 16/11/30.
//  Copyright © 2016年 liuyongchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface HUDManager : NSObject

/**
 加载视图
 */
+ (void)loadShowing;

/**
 隐藏加载视图
 */
+ (void)loadHideing;

/**
 自定义加载视图
 */
+ (void)loadCustomShowing;

/**
 错误提示

 @param str 提示内容
 */
+ (void)loaderrorMessage:(NSString *)str;

/**
 成功提示

 @param str 提示内容
 */
+ (void)loadsuccessMessage:(NSString *)str;

/**
 加载中提示

 @param str 提示内容
 */
+ (void)loadShowing:(NSString*)str;

/**
 仅提示

 @param str 提示内容
 */
+ (void)loadTextMessage:(NSString*)str;

@end
