//
//  LJLiveViewController.m
//  LJLive
//直播界面
//  Created by 李军 on 2017/8/16.
//  Copyright © 2017年 李军. All rights reserved.
//

#import "LJLiveViewController.h"

#import "LJLiveListModel.h"
#import "LJCreatorItem.h"

@interface LJLiveViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) IJKFFMoviePlayerController *player;

@end

@implementation LJLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutView];
}

#pragma mark --搭建UI
- (void)layoutView {
    
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_imageView];
    
    // 设置直播占位图，建议取封面图片并进行磨化处理
    NSURL *imageUrl = [NSURL URLWithString:_live.creator.portrait];
    
    [_imageView sd_setImageWithURL:imageUrl];
    
    // 获取拉流地址
    NSURL *url = [NSURL URLWithString:_live.stream_addr];
    
    // 创建IJKFFMoviePlayerController 传入拉流地址 即可简单播放
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
    self.player.view.frame = self.view.frame;
    
    [self.player prepareToPlay];
    
    [self.view insertSubview:self.player.view atIndex:1];
    
    self.baseScrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.baseScrollView.contentSize = CGSizeMake(ScreenWidth*2, ScreenHeight);
    self.baseScrollView.pagingEnabled = YES;
    [self.view addSubview:self.baseScrollView];
    
    // 可放多种控件包括 关注 之类的
    UIView *black = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight)];
    black.backgroundColor = [UIColor blackColor];
    black.alpha = 0.3;
    [self.baseScrollView addSubview:black];
    
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 50, 20)];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [back setBackgroundColor:GRAYTEXTCOLOR];
    back.titleLabel.font = TEXTFONTMEDIUM;
    [self.view addSubview:back];
}

- (void)backClick:(UIButton *)button {
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark --界面消失做的处理
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    // 停止播放
    [self.player pause];
    [self.player stop];
    [self.player shutdown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
