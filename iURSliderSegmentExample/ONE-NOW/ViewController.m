//
//  ViewController.m
//  ONE-NOW
//
//  Created by iurw on 9/5/15.
//  Copyright (c) 2015 iurw. All rights reserved.
//

#import "ViewController.h"
#import "iURSliderSegmentViewController.h"

@interface ViewController ()<segmentMenuDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"SliderSegment";
    
    UIView *v1 = [[UIView alloc] initWithFrame:self.view.frame];
    v1.backgroundColor = [UIColor redColor];
    UIView *v2 = [[UIView alloc] initWithFrame:self.view.frame];
    v2.backgroundColor = [UIColor orangeColor];
    UIView *v3 = [[UIView alloc] initWithFrame:self.view.frame];
    v3.backgroundColor = [UIColor purpleColor];
    
    iURSliderSegmentViewController *segment = [[iURSliderSegmentViewController alloc] init];
    segment.pages=@[v1,v2,v3];
    segment.pageTitle=@[@"bud",@"am",@"i?"];
    segment.delegate=self;
    segment.rootViewController = self;

    
}

- (void)segmentMenuSelectAtIndex:(NSInteger)index{
    NSLog(@"%li",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
