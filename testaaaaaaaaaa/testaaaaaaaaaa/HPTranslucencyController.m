//
//  HPTranslucencyController.m
//  HouPu
//
//  Created by 雷建民 on 16/10/20.
//  Copyright © 2016年 杭州后铺信息科技有限公司. All rights reserved.
//

#import "HPTranslucencyController.h"

@interface HPTranslucencyController ()


@property (nonatomic ,strong) UIButton *backgroundBtn;


@end

@implementation HPTranslucencyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.view addSubview:self.backgroundBtn];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _backgroundBtn.hidden = NO;

}


- (void)dismissCustomView
{
    self.backgroundBtn.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIButton *)backgroundBtn
{
    if (!_backgroundBtn) {
        _backgroundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backgroundBtn.frame = CGRectMake(0, 0,self.view.frame.size.width, 600);
         _backgroundBtn.hidden = YES;
        _backgroundBtn.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
        [_backgroundBtn addTarget:self action:@selector(dismissCustomView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgroundBtn;
}
@end
