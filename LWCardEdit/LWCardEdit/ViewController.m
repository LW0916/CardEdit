//
//  ViewController.m
//  LWCardEdit
//
//  Created by lwmini on 2018/4/4.
//  Copyright © 2018年 lw. All rights reserved.
//

#import "ViewController.h"
#import <LWCardEditSDK/LWCardEditViewController.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 200, 200);
    [btn setTitle:@"跳转到编辑界面" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)btnClick:(UIButton *)sender{
    [self.navigationController pushViewController:[[LWCardEditViewController alloc]init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
