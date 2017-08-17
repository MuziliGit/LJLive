//
//  LJLiveListModel.h
//  LJLive
//
//  Created by 李军 on 2017/8/15.
//  Copyright © 2017年 李军. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LJCreatorItem;

@interface LJLiveListModel : NSObject

/** 直播流地址 */
@property (nonatomic, copy) NSString *stream_addr;
/** 关注人 */
@property (nonatomic, assign) NSUInteger online_users;
/** 城市 */
@property (nonatomic, copy) NSString *city;
/** 主播 */
@property (nonatomic, strong)LJCreatorItem *creator;

@end
