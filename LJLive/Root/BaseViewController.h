//
//  BaseViewController.h
//  LJLive
//
//  Created by 李军 on 2017/8/10.
//  Copyright © 2017年 李军. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTNavigatonBarView.h"

@interface BaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)CTNavigatonBarView * navigation; //!<当前页面的navigation

@property (nonatomic, strong)UITableView    *baseTableView;//!<

@property (nonatomic, strong)UIScrollView   *baseScrollView;//!<

@end
