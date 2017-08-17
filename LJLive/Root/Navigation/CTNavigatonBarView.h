//
//  CTNavigatonBarView.h
//  CollectionIphone
//
//  Created by 李军 on 16/12/13.
//  Copyright © 2016年 李军. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^back)();

typedef void(^rightBtnClick)();

@interface CTNavigatonBarView : UIView

@property (nonatomic,strong)UIButton * leftButton; //左侧按钮

@property (nonatomic,strong)UIView * rightView; //右侧View

@property (nonatomic,strong)UIView * titleView; //中心view

@property (nonatomic,strong)NSString * title; // 标题

@property (nonatomic, strong)NSString   *whiteTitle;//!< 白色标题

-(instancetype)initWithBack:(back)block;

/**
 创建nav右侧点击按钮

 @param image 默认展示图片
 @param highlightedimage 高亮状态图片
 @param response 点击响应block
 */
-(void)initRightButtonWithImage:(NSString *)image HighlightedImage:(NSString *)highlightedimage Text:(NSString *)text TextColor:(UIColor *)textColor Response:(rightBtnClick)response;

@end
