//
//  iURSliderSegmentViewController.m
//  ONE-NOW
//
//  Created by iurw on 9/5/15.
//  Copyright (c) 2015 iurw. All rights reserved.
//

#import "iURSliderSegmentViewController.h"
#import <objc/runtime.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define PAGE_TITLE_COLOR [UIColor colorWithRed:255.0/255.0 green:68.0/255.0 blue:53.0/255.0 alpha:1]

@interface iURSliderSegmentViewController ()<UIScrollViewDelegate>
{
    /** 滚动视图 */
    UIScrollView *_mainScroll;
    /** 存放按钮视图 */
    UIView *_segmentView;
    
    /** 选择了那个按钮 */
    NSUInteger navMenuSelectIndex;
    
    /** 按钮个数 */
    NSUInteger numberOfButton;
    
    /** 修饰线条 */
    CALayer * _buttonBottomLine;
}
@end

@implementation iURSliderSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36)];
    _segmentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_segmentView];
    
    numberOfButton=(NSUInteger)self.pageTitle.count;
    //加载菜单按钮
    for (int i=0; i<numberOfButton; i++) {
        UIButton * menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/(numberOfButton+2), _segmentView.frame.size.height)];
        menuButton.center = CGPointMake(((i+1)*2+1)*(SCREEN_WIDTH/((numberOfButton+2)*2)), _segmentView.frame.size.height/2);
        menuButton.tag = 11+i;
        [menuButton addTarget:self action:@selector(menuSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuButton setTitle:[self.pageTitle objectAtIndex:i] forState:UIControlStateNormal];
        if (i==0) {
            [menuButton setTitleColor:PAGE_TITLE_COLOR forState:UIControlStateNormal];
        }else{
            [menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if (self.titleFont) {
            menuButton.titleLabel.font=self.titleFont;
        }else{
            menuButton.titleLabel.font=[UIFont systemFontOfSize:16];
        }
        
        [_segmentView addSubview:menuButton];
        
    }
    
    _buttonBottomLine = [CALayer layer];
    _buttonBottomLine.bounds = CGRectMake(0, 0, SCREEN_WIDTH/5, 4);
    _buttonBottomLine.backgroundColor=PAGE_TITLE_COLOR.CGColor;
    _buttonBottomLine.position = CGPointMake(SCREEN_WIDTH/((numberOfButton+2)*2)*3, CGRectGetHeight(_segmentView.frame)-2);
    [_segmentView.layer addSublayer:_buttonBottomLine];
    
    
    _mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 36, SCREEN_WIDTH, SCREEN_HEIGHT-36)];
    _mainScroll.delegate = self;
    _mainScroll.showsHorizontalScrollIndicator = NO;
    _mainScroll.showsVerticalScrollIndicator = NO;
    _mainScroll.clipsToBounds = NO;
    _mainScroll.scrollsToTop = NO;
    _mainScroll.pagingEnabled = YES;
    _mainScroll.bounces = NO;
    _mainScroll.contentSize = CGSizeMake(SCREEN_WIDTH*self.pages.count, CGRectGetHeight(_mainScroll.bounds));
    
    
    for (int i = 0; i<self.pages.count; i++) {
        
        UIView * subView = (UIView*)self.pages[i];
        subView.frame = CGRectMake(i*SCREEN_WIDTH, 0, CGRectGetWidth(_mainScroll.bounds), CGRectGetHeight(_mainScroll.bounds));
        [_mainScroll addSubview:subView];
        
    }
    [self.view addSubview:_mainScroll];
    
}

#pragma mark  导航栏选项卡菜单点击事件
-(void)menuSelectAction:(UIButton *)sender{
    
    navMenuSelectIndex = (int)(sender.tag-10);
    [_mainScroll setContentOffset:CGPointMake(SCREEN_WIDTH*(navMenuSelectIndex-1), 0) animated:YES];
    [self menuBottomAnimation];
    [self.delegate segmentMenuSelectAtIndex:navMenuSelectIndex-1];
}

#pragma mark  导航栏选项卡菜单底部线条动画
-(void)menuBottomAnimation{
    
    for (UIView *view in _segmentView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if (view.tag==navMenuSelectIndex+10) {
                [((UIButton*)view) setTitleColor:PAGE_TITLE_COLOR forState:UIControlStateNormal];
            }else{
                [((UIButton*)view) setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         _buttonBottomLine.position = CGPointMake((navMenuSelectIndex*2+1)*SCREEN_WIDTH/10, CGRectGetHeight(_segmentView.frame)-2);
                     }];
}

#pragma mark  滚动视图
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    navMenuSelectIndex = scrollView.contentOffset.x/SCREEN_WIDTH+1;
    [self menuBottomAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)setRootViewController:(UIViewController *)rootViewController{
    [rootViewController addChildViewController:self];
    [rootViewController.view addSubview:self.view];
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
