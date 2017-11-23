//
//  ViewController.m
//  纵向轮播实现
//
//  Created by zhangting on 2017/11/23.
//  Copyright © 2017年 zhangting. All rights reserved.
//

#import "ViewController.h"
#import "scrollVerticalView.h"

@interface ViewController ()

@property(nonatomic, strong) ScrollVerticalView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.scrollView = [[ScrollVerticalView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width,33)];
    self.scrollView.backgroundColor = [UIColor greenColor];
    self.scrollView.infoArray = @[@"这是播报的第一条数据",@"这是播报的第二条数据",@"这是播报的第三条数据",@"这是播报的第四条数据",@"这是播报的第五条数据"];
    [self.view addSubview:self.scrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
