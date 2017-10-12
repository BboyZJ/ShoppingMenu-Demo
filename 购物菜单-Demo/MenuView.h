//
//  MenuView.h
//  购物菜单-Demo
//
//  Created by 张建 on 2017/5/4.
//  Copyright © 2017年 JuZiShu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView

//标题颜色
@property (nonatomic,strong)UIColor * textColor;
//选中标题颜色
@property (nonatomic,strong)UIColor * selectTextColor;
//标题文字大小
@property (nonatomic,assign)CGFloat textSize;
//滑块颜色
@property (nonatomic,strong)UIColor * sliderColor;

//刷新数据
- (void)refreshTitlesArr:(NSMutableArray *)titlesArr ViewsArr:(NSMutableArray *)viewsArr;

@end
