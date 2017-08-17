//
//  HomeViewController.m
//  LJLive
//
//  Created by 李军 on 2017/8/10.
//  Copyright © 2017年 李军. All rights reserved.
//

#import "HomeViewController.h"
#import "LiveListViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigation = [[CTNavigatonBarView alloc] init];
    self.navigation.title = @"首页";
    [self.view addSubview:self.navigation];
    
    [self lauoutView];
}

- (void)lauoutView {
    
    UIButton *liveList = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    liveList.center = CGPointMake(ScreenWidth/2, 200);
    [liveList setTitle:@"直播列表" forState:UIControlStateNormal];
    [liveList addTarget:self action:@selector(liveListClick:) forControlEvents:UIControlEventTouchUpInside];
    [liveList setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:liveList];
}

#pragma mark --点击跳转直播列表
- (void)liveListClick:(UIButton *)button {
    
    LiveListViewController *vc = [[LiveListViewController alloc] init];
    [CommUtls pushWithFrom:self To:vc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
