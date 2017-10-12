//
//  ZJMenuViewController.m
//  购物菜单-Demo
//
//  Created by 张建 on 2017/5/4.
//  Copyright © 2017年 JuZiShu. All rights reserved.
//

#import "ZJMenuViewController.h"
#import "MenuView.h"

#define kScreenW  ([[UIScreen mainScreen] bounds].size.width)
#define kScreenH  ([[UIScreen mainScreen] bounds].size.height)
#define kNavBarH  64
#define kTabBarH  49

@interface ZJMenuViewController ()

@end

@implementation ZJMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    //initUI
    [self initUI];
}

//initUI
- (void)initUI{
    
    NSMutableArray * titlesArr = [NSMutableArray array];//titles
    NSMutableArray * viewsArr = [NSMutableArray array];//views
    for (int i = 0; i < 20; i ++) {
        
        [titlesArr addObject:[NSString stringWithFormat:@"title%d",i]];
        
        UIView * view = [[UIView alloc] init];
        CGFloat R = arc4random()%256;
        CGFloat G = arc4random()%256;
        CGFloat B = arc4random()%256;
        view.backgroundColor = [UIColor colorWithRed:R / 255.0f green:G / 255.0f blue:B / 255.0f alpha:1];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
        label.text = [NSString stringWithFormat:@"view%d",i];
        [view addSubview:label];
        
        [viewsArr addObject:view];
    }
    
    //menuView
    MenuView * menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, kNavBarH, kScreenW, kScreenH - kNavBarH - kTabBarH)];
    [menuView refreshTitlesArr:titlesArr ViewsArr:viewsArr];
    [self.view addSubview:menuView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
