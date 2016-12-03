//
//  ViewController.m
//  testaaaaaaaaaa
//
//  Created by 雷建民 on 16/11/23.
//  Copyright © 2016年 leijianmin. All rights reserved.
//

#import "ViewController.h"
#import "HPAddAddressPickerView.h"
#import "HPTranslucencyController.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface ViewController ()

@property (nonatomic ,strong) HPAddAddressPickerView *pickerView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    showBtn.backgroundColor = [UIColor magentaColor];
    [showBtn setTitle:@"点我显示" forState:UIControlStateNormal];
    showBtn.frame = CGRectMake(100, 200,self.view.frame.size.width-200,30);
    [showBtn addTarget:self action:@selector(showPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];
}


- (void)showPickerView:(UIButton *)showBtn
{
    NSString *addressStr = showBtn.titleLabel.text;
    NSArray *arrays = [addressStr componentsSeparatedByString:@" "];
    
    NSString *province = @"";//省
    NSString *city = @"";//市
    NSString *county = @"";//县
    if (arrays.count > 2) {
        province = arrays[0];
        city = arrays[1];
        county = arrays[2];
    } else if (arrays.count > 1) {
        province = arrays[0];
        city = arrays[1];
    } else if (arrays.count > 0) {
        province = arrays[0];
    }
    [self presentToHPTranslucencyController:self.pickerView];
    [self.pickerView showPickerWithProvinceName:province cityName:city countyName:county];
    self.pickerView.completion = ^(NSDictionary *params) {
        [showBtn setTitle: [NSString stringWithFormat:@"%@ %@ %@",params[@"province"][@"provinceName"],params[@"city"][@"cityName"],params[@"regition"][@"regtionName"]] forState:UIControlStateNormal];
        [showBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:NO completion:nil];
    };

}


/**
 模态出一个半透明控制器
 
 @param customView 自定义view
 */
- (void)presentToHPTranslucencyController:(UIView *)customView
{
    HPTranslucencyController *translucencyVC = [[HPTranslucencyController alloc]init];
    self.definesPresentationContext = YES;
    [translucencyVC.view addSubview:customView];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:translucencyVC animated:YES completion:nil];
}

- (HPAddAddressPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[HPAddAddressPickerView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-270,self.view.frame.size.width, 270)];
    }
    return _pickerView;
}

@end
