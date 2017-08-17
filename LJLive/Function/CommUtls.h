//
//  CommUtls.h
//  Function
//  常用工具类
//  Created by 李军 on 16/11/8.
//  Copyright © 2016年 李军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import  <dlfcn.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#import  <CommonCrypto/CommonCryptor.h>
#import  <SystemConfiguration/SystemConfiguration.h>
#include <sys/xattr.h>
#import <QuartzCore/QuartzCore.h>
#import <sys/utsname.h>

@interface CommUtls : NSObject


#pragma mark --时间处理
/**
 时间戳转换 -默认格式 yyyy-MM-dd

 @param time 当前时间 -毫秒数

 @return 字符串类型时间
 */
+(NSString*)timeToTranslate:(NSNumber *)time;

/**
 时间戳转换  格式 yyyy-MM-dd HH:mm:ss

 @param time 当前时间  毫秒数
 @return 字符串类型时间
 */
+ (NSString*)timeToTranslate1:(NSNumber *)time;

/**
 根据时间格式转换

 @param time         当前时间 -毫秒数
 @param formatterStr 时间格式

 @return 字符串类型时间
 */
+(NSString*)timeToTranslate:(NSNumber *)time Formatter:(NSString*)formatterStr;


/**
 获取当前时区时间

 @param anyDate 当前时间

 @return 返回时间对象
 */
+(NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;

/**
 *	@brief	格式化时间为字符串
 *
 *	@param 	date 	NSDate系统时间类型
 *
 *	@return	返回默认格式yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)encodeTime:(NSDate *)date;

/**
 *	@brief	字符串格式化为时间格式
 *
 *	@param 	dateString 	默认格式yyyy-MM-dd HH:mm:ss
 *
 *	@return	返回时间格式
 */
+ (NSDate *)dencodeTime:(NSString *)dateString;

/**
 *	@brief	把秒转化为时间字符串显示，播放器常用
 *
 *	@param 	durartion 	传入参数
 *
 *	@return	播放器播放进度时间，比如
 */
+ (NSString *)changeSecondsToString:(CGFloat)durartion;


/**
 距离现在多久 --标识

 @param beTime 到现在的时间
 @return 字符串
 */
+ (NSString *)distanceTimeWithBeforeTime:(double)beTime;

#pragma mark --文件处理

/**
 *	@brief	判断文件路径是否存在
 *
 *	@param 	fullPathName 	文件完整路径
 *
 *	@return	返回是否存在
 */
+ (BOOL)fileExists:(NSString *)fullPathName;

/**
 *	@brief	删除文件
 *
 *	@param 	fullPathName 	文件完整路径
 *
 *	@return	是否删除成功
 */
+ (BOOL)remove:(NSString *)fullPathName;

/**
 *	@brief	创建文件夹
 *
 *	@param 	dir 	文件夹名字
 */
+ (void)makeDirs:(NSString *)dir;

/**
 *	@brief	判断Document文件路径是否存在
 *
 *	@param 	fileName 	文件名
 *
 *	@return	返回是否存在文件路径
 */
+ (BOOL)fileExistInDocumentPath:(NSString*)fileName;

/**
 *	@brief	通过文件名，获取Document完整路径，如果不存在返回为nil
 *
 *	@param 	fileName 	文件名
 *
 *	@return	返回完整路径
 */
+ (NSString*)documentPath:(NSString*)fileName;

/**
 *	@brief	删除Document文件
 *
 *	@param 	fileName 	文件名
 *
 *	@return	是否成功删除
 */
+ (BOOL)deleteDocumentFile:(NSString*)fileName;

/**
 *	@brief	判断Cache是否存在
 *
 *	@param 	fileName 	文件名
 *
 *	@return	是否存在文件
 */
+ (BOOL)fileExistInCachesPath:(NSString*)fileName;

/**
 *	@brief	通过文件名返回完整的Caches目录下的路径，如果不存在该路径返回nil
 *
 *	@param 	fileName 	文件名
 *
 *	@return	返回Caches完整路径
 */
+ (NSString*)cachesFilePath:(NSString*)fileName;

/**
 *	@brief	删除Caches文件
 *
 *	@param 	fileName 	文件名
 *
 *	@return	删除是否成功
 */
+ (BOOL)deleteCachesFile:(NSString*)fileName;

#pragma mark --其他处理
/**
 *	@brief	通过字节获取文件大小
 *
 *	@param 	number 	字节数
 *
 *	@return	返回大小
 */
+ (NSString*)getSize:(NSNumber*)number;

/**
 *	@brief	获取随即数
 *
 *	@param 	min 	最小数值
 *	@param 	max 	最大数值
 *
 *	@return	返回数值
 */
+ (NSInteger)getRandomNumber:(NSInteger)min maxNumber:(NSInteger)max;

/**
 *	@brief	获取颜色
 *
 *	@param 	stringToConvert 	取色数值
 *
 *	@return	返回颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;


/**
 *	@brief	mac地址
 *
 *	@return	返回地址
 */
+ (NSString *)getMacAddress;

/**
 *	@brief	检查是否可用网络
 *
 *	@return	返回是否可用
 */
+ (BOOL)checkConnectNet;


/**
 获取随机色

 @return 返回颜色对象
 */
+ (UIColor *)getRandomColor;

/**
 *  随机生成UUID
 *
 *  @return 生成的UUID
 */
+ (NSString *)getUUIDString;


/**
 根据颜色获取图片对象

 @param color 需要转换的颜色

 @return 返回图片对象
 */
+(UIImage*)getImageWithColor:(UIColor*) color;


/**
 返回当前iPhone类型

 @return 类型字符串
 */
+(NSString *)getDeviceBounds;


/**
 根据参数计算字符串长度

 @param text 字符串
 @param maxSize 最大大小
 @param font 字体
 @return 大小
 */
+(CGSize)calculateHeightWithText:(NSString *)text MaxSize:(CGSize)maxSize Font:(UIFont *)font;


/**
 根据字符串验证手机号

 @param text 手机号
 @return 验证结果
 */
+(BOOL)cheakMobileWithText:(NSString *)text;

/**
 将JSON串转化为NSDictionary或NSArray

 @param jeson jeson串
 @return 返回的字典或者数组
 */
+(id)returnDictionaryOrArray:(NSString *)jeson;

/**
 将图片打成base64返回一个标准上传参数

 @param photoArray 图片数组
 @return 返回一个可以上传的图片string
 */
+ (NSString *)base64PhotoString:(NSArray *)photoArray;

/**
 将字符串base64加密

 @param string 传入进去的字符串
 @return 加密完的字符串
 */
+ (NSString *)base64EncodeString:(NSString *)string;

#pragma mark --push pop
/**
 *  push界面
 *
 *  @param from         开始的Controller
 *  @param toController 需跳转的Controller
 */
+(void)pushWithFrom:(UIViewController*)from To:(UIViewController*)toController;

/**
 pop指定界面
 */
+(void)popWithFrom:(UIViewController*)from To:(Class)toControllerClass;

@end
