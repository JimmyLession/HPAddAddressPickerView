//
//  HPAddAddressPickerView.m
//  testaaaaaaaaaa
//
//  Created by 雷建民 on 16/11/23.
//  Copyright © 2016年 leijianmin. All rights reserved.
//
#import "HPAddAddressPickerView.h"
#import "HPAddAddressPickerModel.h"
#import "MJExtension.h"

@interface HPAddAddressPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic ,strong) UIPickerView *pickerView;

@property (nonatomic ,strong) NSMutableArray *provinceArray;
@property (nonatomic ,strong) NSMutableArray *cityArray;
@property (nonatomic ,strong) NSMutableArray *regionArray;

@end

@implementation HPAddAddressPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
      
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLRequest *request  = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.test.hooclub.com/v1/region"]];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            id objc = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            [self.provinceArray addObjectsFromArray:[HPAddAddressPickerModel mj_objectArrayWithKeyValuesArray:objc[@"data"][@"province"]]];
        }];
        [task resume];
        if (self.provinceArray.count > 0) {
            [_provinceArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
              /*  if (obj[@"provinceID"] == ) {
                    <#statements#>
                }*/
            
            }];
        }
    }
    return self;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
   }

#pragma mark - UIPickerViewDelegate
//返回高度和宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
        return self.frame.size.width/3;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
       return 30;
}

//返回
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return  ((HPAddAddressPickerModel *)dictArray[row]).name;
            break;
            case 1:
            return
        default:
            break;
    }
}

//当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"%@", _city2[row]);
    
}

- (NSMutableArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}

- (NSMutableArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}

- (NSMutableArray *)regionArray
{
    if (!_regionArray) {
        _regionArray = [NSMutableArray array];
    }
    return _regionArray;
}


@end
