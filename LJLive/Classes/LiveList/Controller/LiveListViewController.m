//
//  LiveListViewController.m
//  LJLive
//
//  Created by 李军 on 2017/8/15.
//  Copyright © 2017年 李军. All rights reserved.
//

#import "LiveListViewController.h"
#import "LJLiveViewController.h"

#import "LJLiveListModel.h"

#import "YZLiveCell.h"

static NSString * const CELL = @"cell";
@interface LiveListViewController ()

@property (nonatomic, strong)NSMutableArray *liveDataArray;
@end

@implementation LiveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigation = [[CTNavigatonBarView alloc] initWithBack:^{
       
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigation.title = @"直播列表";
    [self.view addSubview:self.navigation];
    
    [self layoutView];
    
    [self requestData];
}

#pragma mark --搭建UI
- (void)layoutView {
    
    self.baseTableView.frame = CGRectMake(0, 65, ScreenWidth, ScreenHeight);
    self.baseTableView.rowHeight = 430;
    self.baseTableView.backgroundColor = BackgroundColor;
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.baseTableView registerNib:[UINib nibWithNibName:@"YZLiveCell" bundle:nil] forCellReuseIdentifier:CELL];
    [self.view addSubview:self.baseTableView];
}

#pragma mark --请求数据
- (void)requestData {
    
    //拖得映客的数据 没拖到下来加载url
    NSString *url = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";
    
    [RequestManager requestWithURL:url Parameters:nil Target:self IsFirstRequest:NO Isjson:NO success:^(id data) {
        
        self.liveDataArray = [LJLiveListModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"lives"]];
        [self.baseTableView reloadData];
    } failure:^(NSError *error) {
       
        [HUDManager loaderrorMessage:@"请求失败"];
    }];
}

#pragma mark --UITableViewDelege UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.liveDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL];
    
    cell.live = self.liveDataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJLiveViewController *vc = [[LJLiveViewController alloc] init];
    vc.live = self.liveDataArray[indexPath.row];
    [self presentViewController:vc animated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
