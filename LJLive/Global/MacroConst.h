//
//  MacroConst.h
//  LJLive
//宏定义

//  Created by 李军 on 2017/8/10.
//  Copyright © 2017年 李军. All rights reserved.
//

#ifndef MacroConst_h
#define MacroConst_h

#pragma mark --控件高宽宏

#define ScreenWidth [UIScreen mainScreen].bounds.size.width //!< 屏幕宽
#define ScreenHeight [UIScreen mainScreen].bounds.size.height //!< 屏幕高

#define VIEWOF(view) view.frame.origin.y+view.frame.size.height
#define VIEWOFX(view) view.frame.origin.x+view.frame.size.width
#define VIEWWIDTH self.view.frame.size.width
#define VIEWHEIGHT self.view.frame.size.height
#define VIEWWIDTH_WITHOUTVIEW self.frame.size.width
#define VIEWHEIGHT_WITHOUTVIEW self.frame.size.height

#pragma mark --颜色宏

#define RedColor [CommUtls colorWithHexString:@"#e5004a"]  //!< 主题红
#define GrayColor RGBA(76, 76, 76, 1) //!< 主题灰
#define fontColor [CommUtls colorWithHexString:@"#666666"]
#define REDTEXTCOLOR  [CommUtls colorWithHexString:@"#D03333"]  //!< 红色的字体
#define YELLOWTEXTCOLOR  [CommUtls colorWithHexString:@"#EC8E00"]  //!< 黄色的字体
#define BLUETEXTCOLOR  [CommUtls colorWithHexString:@"#009AD7"]  //!< 蓝色的字体
#define GRAYTEXTCOLOR [CommUtls colorWithHexString:@"#999999"]  //!< 灰色字体
#define GREETEXTCOLOR [CommUtls colorWithHexString:@"#1AAD19"]  //!< 绿色字体
#define ORANGETEXTCOLOR [CommUtls colorWithHexString:@"#F19C4B"]  //!< 橙色字体
#define DEEPBLUETEXTCOLOR [CommUtls colorWithHexString:@"#586BBA"] //!< 深蓝色
#define SMALLGRAYTEXTCOLOR [CommUtls colorWithHexString:@"#6E6F70"]  //!< 小灰色字体
#define BLACKTEXTCOLOR [CommUtls colorWithHexString:@"#555555"] //!< 黑色字体
#define MOREBLACKTEXTCOLOR [CommUtls colorWithHexString:@"#333333"] //!< 粗黑色字体
#define BackgroundColor [CommUtls colorWithHexString:@"#EFEFF4"] //!< 背景颜色

#pragma mark --字体大小

#define TEXTFONTBIG [UIFont systemFontOfSize:16]
#define TEXTFONTMEDIUM [UIFont systemFontOfSize:14]
#define TEXTFONTSMALL [UIFont systemFontOfSize:12]


#pragma mark --Log打印

#ifdef DEBUG
#define DLog(...) NSLog(__VA_ARGS__)
#else
#define DLog(...) /* */
#endif
#define ALog(...) NSLog(__VA_ARGS__)

#define PAYSUCCESS @"paySuccess"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#endif /* MacroConst_h */
