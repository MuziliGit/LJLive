//
//  RootNavigationController.m
//  CollectionIphone
//
//  Created by 李军 on 16/11/28.
//  Copyright © 2016年 李军. All rights reserved.
//

#import "RootNavigationController.h"

@interface RootNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation RootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden=YES;
    self.interactivePopGestureRecognizer.delegate = self;
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 此时push进来的viewController是第二个子控制器
        // 自动隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    // 调用父类pushViewController，self.viewControllers数组添加对象viewController
    [super pushViewController:viewController animated:animated];
}

@end
