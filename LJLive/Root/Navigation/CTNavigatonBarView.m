//
//  CTNavigatonBarView.m
//  CollectionIphone
//
//  Created by 李军 on 16/12/13.
//  Copyright © 2016年 李军. All rights reserved.
//

#import "CTNavigatonBarView.h"

static NSString *overViewKey;
static NSString *rightClick;
@implementation CTNavigatonBarView

#pragma mark --初始化方法

-(instancetype)initWithBack:(back)block{
    
    if(self=[super init]){
        
        self.backgroundColor=[UIColor whiteColor];
        self.frame=CGRectMake(0,0,ScreenWidth, 64);
        objc_setAssociatedObject(self, &overViewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        //定义左侧返回按钮
        self.leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton.frame=CGRectMake(5,20,40,44);
        [self.leftButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [self.leftButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
        [self.leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.leftButton];
        
        self.titleView=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftButton.frame), 20, ScreenWidth-10-80, 44)];
        self.titleView.tag=1000;
        [self addSubview:self.titleView];
        
        [self settlementShadow];
    }
    return self;
}

-(instancetype)init{
    
    if (self=[super init]) {
        
        self.backgroundColor=[UIColor whiteColor];
        self.frame=CGRectMake(0,0,ScreenWidth, 64);
        
        self.titleView=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftButton.frame)+5, 20, ScreenWidth-2*(CGRectGetMaxX(self.leftButton.frame)+5), 44)];
        [self addSubview:self.titleView];
        
        [self settlementShadow];
    }
    
    return self;
}


#pragma mark --自定义方法实现

/**
设置nav的底部阴影
 */
-(void)settlementShadow{
    
    self.layer.shadowColor=[UIColor grayColor].CGColor;
    self.layer.shadowOffset=CGSizeMake(0, 1);
    self.layer.shadowRadius=1;
    self.layer.shadowOpacity=0.3;
}

/**
 返回按钮点击事件
 */
-(void)back
{
    back block = objc_getAssociatedObject(self, &overViewKey);
    if ( block!= nil)
    {
        block();
    }
}


-(void)initRightButtonWithImage:(NSString *)image HighlightedImage:(NSString *)highlightedimage Text:(NSString *)text TextColor:(UIColor *)textColor Response:(rightBtnClick)response{
    
    UIButton * right=[UIButton buttonWithType:UIButtonTypeCustom];
    right.frame=CGRectMake(ScreenWidth-5-40, 20, 40, 44);
    right.adjustsImageWhenHighlighted=NO;
    objc_setAssociatedObject(self, &rightClick, response, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    if (image) {
        [right setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    
    if (highlightedimage) {
        [right setImage:[UIImage imageNamed:highlightedimage] forState:UIControlStateHighlighted];
    }
    if (text) {
        CGSize size = [CommUtls calculateHeightWithText:text MaxSize:CGSizeMake(0, 44) Font:TEXTFONTBIG];
        right.frame=CGRectMake(ScreenWidth-5-(size.width>40?size.width:40), 20, size.width>40?size.width:40, 44);
        [right setTitle:text forState:UIControlStateNormal];
        right.titleLabel.font=[UIFont systemFontOfSize:16];
    }
    if(textColor){
        [right setTitleColor:textColor forState:UIControlStateNormal];
        [right setTitleColor:RedColor forState:UIControlStateHighlighted];
    }
    self.rightView=right;
}


/**
 右侧按钮点击事件
 */
-(void)rightClick{
    
    rightBtnClick block=objc_getAssociatedObject(self, &rightClick);
    if ( block!= nil)
    {
        block();
    }
}

-(void)setTitle:(NSString *)title{
    _title=title;
    
    UILabel * titleLabel=[[UILabel alloc]initWithFrame:self.titleView.bounds];
    titleLabel.text=title;
    titleLabel.textColor=BLACKTEXTCOLOR;
    titleLabel.font=[UIFont systemFontOfSize:18];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.titleView addSubview:titleLabel];
}

- (void)setWhiteTitle:(NSString *)whiteTitle {
    
    _whiteTitle = whiteTitle;
    
    UILabel * titleLabel=[[UILabel alloc]initWithFrame:self.titleView.bounds];
    titleLabel.text=whiteTitle;
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font=[UIFont systemFontOfSize:18];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.titleView addSubview:titleLabel];
}

-(void)setRightView:(UIView *)rightView{
    _rightView=rightView;
    [self addSubview:rightView];
    self.titleView.frame=CGRectMake(rightView.frame.size.width+10, 20, ScreenWidth-2*(rightView.frame.size.width+10), 44);
    for (UIView * subView in [self.titleView subviews]) {
        subView.frame=self.titleView.bounds;
    }
}

@end
