//
//  HUDManager.m
//  CollectionIphone
//
//  Created by liuyongchao on 16/11/30.
//  Copyright © 2016年 liuyongchao. All rights reserved.
//

#import "HUDManager.h"

static MBProgressHUD * HUD;

@implementation HUDManager

+(void)loadShowing{
    
    HUD=[MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
}

+ (void)loadShowing:(NSString*)str{
    
    [self loadShowing];
    HUD.labelText=str;
}

+(void)loadHideing{
    [HUD hide:YES];
}

+(void)loadCustomShowing{
    
    NSArray * images=@[@"load_1",@"load_2",@"load_3",@"load_4",@"load_5",@"load_6",@"load_7",@"load_8",@"load_9",@"load_10",@"load_11",@"load_12"];
    
    NSMutableArray<UIImage *> * array=[NSMutableArray array];
    for (NSString * name in images) {
        
        [array addObject:[UIImage imageNamed:name]];
    }
    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [array firstObject].size.width, [array firstObject].size.height)];
    imageView.animationImages=array;
    imageView.animationDuration=0.8;
    [imageView startAnimating];
    
    HUD=[MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    HUD.customView=imageView;
    HUD.mode=MBProgressHUDModeCustomView;
    HUD.color=[UIColor clearColor];
}

+ (void)loaderrorMessage:(NSString *)str
{
    UIImage * image=[UIImage imageNamed:@"jg_hud_error"];
    UIImageView * imageView=[[UIImageView alloc]initWithImage:image];
    
    HUD=[MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    HUD.customView=imageView;
    HUD.mode=MBProgressHUDModeCustomView;
    HUD.detailsLabelText=str;
    [HUD hide:YES afterDelay:2.0f];
}
+ (void)loadsuccessMessage:(NSString *)str
{
    UIImage * image=[UIImage imageNamed:@"jg_hud_success"];
    UIImageView * imageView=[[UIImageView alloc]initWithImage:image];
    
    HUD=[MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    HUD.customView=imageView;
    HUD.mode=MBProgressHUDModeCustomView;
    HUD.detailsLabelText = str;
    [HUD hide:YES afterDelay:2.0f];
}

+(void)loadTextMessage:(NSString *)str{
    HUD=[MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    HUD.mode=MBProgressHUDModeText;
    HUD.labelText=str;
    [HUD hide:YES afterDelay:1.5];
}


@end
