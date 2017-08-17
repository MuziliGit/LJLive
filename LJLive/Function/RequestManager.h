//
//  RequestManager.h
//  CollectionIphone
//  数据请求类
//  Created by 李军 on 16/11/28.
//  Copyright © 2016年 李军. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^success)(id data);
typedef void(^failure)(NSError * error);


@interface RequestManager : NSObject

@property (nonatomic,strong) id responseObject;

+(void)requestWithURL:(NSString *)url Parameters:(id)parameters Target:(id)target IsFirstRequest:(BOOL)isOrNo Isjson:(BOOL)isjson success:(success)success failure:(failure)failure;

@end
