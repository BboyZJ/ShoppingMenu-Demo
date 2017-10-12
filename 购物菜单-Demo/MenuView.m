//
//  MenuView.m
//  购物菜单-Demo
//
//  Created by 张建 on 2017/5/4.
//  Copyright © 2017年 JuZiShu. All rights reserved.
//

#import "MenuView.h"

#define kScreenW  ([[UIScreen mainScreen] bounds].size.width)
#define kScreenH  ([[UIScreen mainScreen] bounds].size.height)
#define Menu_W 100 //左侧菜单栏宽度
#define Slider_H 25 //滑块的高度
#define Slider_W (Menu_W - 10) //滑块的宽度
#define Btn_H 40 //按钮的高度
#define Line_W 1.0 //分割线的宽度
#define Menu_Time 0.2 //菜单栏滚动时间

@interface MenuView ()

//menuView
@property (nonatomic,strong)UIScrollView * menuView;
//sliderView
@property (nonatomic,strong)UIView * sliderView;
//lineView
@property (nonatomic,strong)UIView * lineView;
//rightView
@property (nonatomic,strong)UIView * rightView;
//titlesArr
@property (nonatomic,strong)NSMutableArray * titlesArr;
//viewsArr
@property (nonatomic,strong)NSMutableArray * viewsArr;
//上一个选中的tag
@property (nonatomic,assign)NSInteger lastChoseTag;
//新选中的tag
@property (nonatomic,assign)NSInteger newChoseTag;

@end

@implementation MenuView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self ) {
        
        self.backgroundColor = [UIColor brownColor];
        [self initUI];
    }
    return self;
}
- (NSMutableArray *)titlesArr{
    
    if (!_titlesArr) {
        
        _titlesArr = [NSMutableArray array];
    }
    return _titlesArr;
}
- (NSMutableArray *)viewsArr{
    
    if (!_viewsArr) {
        
        _viewsArr = [NSMutableArray array];
    }
    return _viewsArr;
}
//initUI
- (void)initUI{
        
    //Default Menu Style
    _textColor = [UIColor blackColor];
    _selectTextColor = [UIColor orangeColor];
    _textSize = 14;
    _sliderColor = [UIColor magentaColor];
    
}

//刷新数据
- (void)refreshTitlesArr:(NSMutableArray *)titlesArr ViewsArr:(NSMutableArray *)viewsArr{
    
    self.titlesArr = titlesArr;
    self.viewsArr = viewsArr;
    
    //menuView
    [self addSubview:self.menuView];
    //sliderView
    [_menuView addSubview:self.sliderView];
    
    //添加菜单Button
    [self addMenuButton];
    
    //添加lineView
    [self addSubview:self.lineView];
    
    //添加rightView
    [self addSubview:self.rightView];
    
    //添加views
    [self addViews];
    
}
//添加菜单Button
- (void)addMenuButton{
    
    for (int i = 0; i < _titlesArr.count; i ++) {
        
        UIButton * menuBtn = [[UIButton alloc] init];
        [menuBtn setTitle:_titlesArr[i] forState:UIControlStateNormal];
        menuBtn.backgroundColor = [UIColor clearColor];
        menuBtn.titleLabel.font = [UIFont systemFontOfSize:_textSize];
        menuBtn.tag = 100 + i;
        
        menuBtn.frame = CGRectMake(0, Btn_H * i,Menu_W, Btn_H);
        
        //上一个选中的tag
        _lastChoseTag = 100;
        if (i == 100) {
            
            [menuBtn setTitleColor:_selectTextColor forState:UIControlStateNormal];
        }else {
            
            [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [menuBtn addTarget:self action:@selector(choseBtn:) forControlEvents:UIControlEventTouchUpInside];

        [_menuView addSubview:menuBtn];
    
    }
    
}
//点击title的事件
- (void)choseBtn:(UIButton *)sender{
    
    _newChoseTag = sender.tag;
    NSLog(@"lastTag:%ld newTag:%ld",_lastChoseTag,_newChoseTag);

    if (_newChoseTag != _lastChoseTag) {
        
        //last
        UIButton * lastBtn = (UIButton *)[self viewWithTag:_lastChoseTag];
        [lastBtn setTitleColor:_textColor forState:UIControlStateNormal];
        
        //new
        UIButton * newBtn = (UIButton *)[self viewWithTag:_newChoseTag];
        [newBtn setTitleColor:_selectTextColor forState:UIControlStateNormal];
        
        //slider
        [UIView animateWithDuration:0.3 animations:^{
            
            _sliderView.frame = CGRectMake((Menu_W - Slider_W) / 2.0, newBtn.frame.origin.y + (Btn_H - Slider_H) / 2.0, Slider_W, Slider_H);
            
        } completion:^(BOOL finished) {
            
            _lastChoseTag = _newChoseTag;
        }];
        
        //view
        //先移除所有的rightview，再添加新的
        for (UIView * view in _rightView.subviews) {
            
            [view removeFromSuperview];
        }
        UIView * rightView = _viewsArr[_newChoseTag - 100];
        [_rightView addSubview:rightView];
    }
}

#pragma mark ---添加子视图views---
- (void)addViews{
    
    for (int i = 0; i < _viewsArr.count; i ++) {
        
        UIView * view = _viewsArr[i];
        
        view.frame = _rightView.bounds;
    }
    //默认是第一个选中
    [self.rightView addSubview:_viewsArr[0]];
    
}

#pragma mark ---privite----
//scrollView
- (UIScrollView *)menuView{
    
    if (!_menuView) {
        
        _menuView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Menu_W, self.frame.size.height)];
        _menuView.backgroundColor = [UIColor greenColor];
        _menuView.showsVerticalScrollIndicator = NO;
        _menuView.scrollsToTop = YES;
        _menuView.contentSize = CGSizeMake(0, _titlesArr.count * Btn_H);
        
    }
    return _menuView;
}
//sliderView
- (UIView *)sliderView{
    
    if (!_sliderView) {
        
        _sliderView = [[UIView alloc] initWithFrame:CGRectMake((Menu_W - Slider_W) / 2.0,(Btn_H - Slider_H) / 2.0, Slider_W, Slider_H)];
        _sliderView.backgroundColor = _sliderColor;
        _sliderView.layer.cornerRadius = Slider_H / 2.0;
        _sliderView.layer.masksToBounds = YES;

    }
    return _sliderView;
}
//lineView
- (UIView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(Menu_W, 0, Line_W, self.bounds.size.height)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _lineView;
}
//rightView
- (UIView *)rightView{
    
    if (!_rightView) {
        
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(Menu_W + Line_W, 0, kScreenW - Menu_W - Line_W, self.bounds.size.height)];
        _rightView.backgroundColor = [UIColor redColor];
    }
    return _rightView;
}

@end
