//
//  BaseViewController.m
//  LJLive
//基础VC
//  Created by 李军 on 2017/8/10.
//  Copyright © 2017年 李军. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (UITableView *)baseTableView {
    
    if (_baseTableView == nil) {
        
        _baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _baseTableView.delegate = self;
        _baseTableView.dataSource = self;
    }
    return _baseTableView;
}

- (UIScrollView *)baseScrollView {
    
    if (_baseScrollView == nil) {
        
        _baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    
    return _baseScrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
