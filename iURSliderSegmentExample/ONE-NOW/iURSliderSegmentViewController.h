//
//  iURSliderSegmentViewController.h
//  ONE-NOW
//
//  Created by iurw on 9/5/15.
//  Copyright (c) 2015 iurw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol segmentMenuDelegate <NSObject>

/** 菜单按钮协议方法 */
- (void)segmentMenuSelectAtIndex:(NSInteger)index;

@end

@interface iURSliderSegmentViewController : UIViewController

/** 协议属性 */
@property(nonatomic,weak)id<segmentMenuDelegate>delegate;

/** 子视图数组 */
@property(nonatomic,copy)NSArray *pages;

/** 菜单按钮标题数组 */
@property(nonatomic,copy)NSArray *pageTitle;

/** 菜单按钮颜色 */
@property(nonatomic,strong)UIColor *titleColor;

/** 菜单按钮字体 */
@property(nonatomic,strong)UIFont *titleFont;

/** 主视图 */
@property(nonatomic,retain) UIViewController *rootViewController;

@end
