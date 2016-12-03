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

#define kStringIntegerFormat(integer) [NSString stringWithFormat:@"%ld",integer]
#define HPColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]


@interface HPAddAddressPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic ,strong) UIPickerView *pickerView;

@property (nonatomic,strong) UIView *headView;

@property (nonatomic ,strong) NSMutableArray *provinceArray;
@property (nonatomic ,strong) NSArray *cityArray;
@property (nonatomic ,strong) NSArray *regionArray;

@property (nonatomic,assign) NSInteger firstCurrentIndex;//第一行当前位置
@property (nonatomic,assign) NSInteger secondCurrentIndex;//第二行当前位置
@property (nonatomic,assign) NSInteger thirdCurrentIndex;//第三行当前位置

@end

@implementation HPAddAddressPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       //请求数据
        [self requestData];
        //设置UI
        [self setUpUI];

    }
    return self;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.provinceArray.count > 0) {
        return 3;
    }
    
    if (self.cityArray.count > 0) {
        _thirdCurrentIndex = 0;
        return 2;
    }
    _secondCurrentIndex = 0;
    return 1;
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.provinceArray.count + 1;
    } else if (component == 1) {
        return self.cityArray.count + 1;
    } else {
        return self.regionArray.count + 1;
    }
    
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
        {
            if (row > 0) {
                if (row - 1 < _provinceArray.count) {
                    HPAddAddressPickerModel *pickerModel = _provinceArray[row - 1];
                    return pickerModel.name;
                }
            }
        }
            break;
        case 1:
        {
            if (row > 0) {
                if (row - 1  < _cityArray.count) {
                    HPAddAddressCityModel *cityModel = _cityArray[row - 1];
                    return cityModel.name;
                }
            }
        }
            break;
        default:
        {
            if (row  >  0) {
                if (row - 1 < _regionArray.count) {
                    HPAddAddressRegionModel *regionModel = _regionArray[row - 1];
                    return regionModel.name;
                }
            }
        }
            break;
    }
    return @"请选择";
}

//当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:
        {
            _firstCurrentIndex = row;
            if (row > 0) {
                HPAddAddressPickerModel *pickerModel = _provinceArray[row - 1];
                _cityArray = pickerModel.child;
                _secondCurrentIndex = 0;
                
                _regionArray = nil;
                _thirdCurrentIndex = 0;
            }else {
                _cityArray = nil;
                _secondCurrentIndex = 0;
            }
        }
            [_pickerView reloadAllComponents];
            if (_cityArray.count > 0) {
                [_pickerView selectRow:_secondCurrentIndex inComponent:1 animated:NO];
            }
            break;
        case 1:
        {
            _secondCurrentIndex = row;
            if (row > 0) {
                HPAddAddressCityModel *cityModel = _cityArray[row - 1];
                _regionArray = cityModel.child;
                _thirdCurrentIndex = 0;
            }else {
                _regionArray = nil;
                _thirdCurrentIndex = 0;
            }
            [_pickerView reloadAllComponents];
            if (_regionArray.count > 0) {
                [_pickerView selectRow:_thirdCurrentIndex inComponent:2 animated:NO];
            }
        }
            break;
        default:
            _thirdCurrentIndex = row;
            break;
    }
    
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:16]];
    }
    // Fill the label text here
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


#pragma mark - 点击确定按钮事件
/**
 点击确定按钮事件
 
 @param sender sender
 */
- (void)completionButtonAction:(UIButton *)sender
{
    
    NSString *provinceName = @"";
    NSString *cityName = @"";
    NSString *regtionName = @"";
    
    NSInteger _provinceID = 0;
    NSInteger _cityID = 0;
    NSInteger _regtionID = 0;
    
    HPAddAddressPickerModel *pickerModel;
    HPAddAddressCityModel *cityModel;
    HPAddAddressRegionModel *regtionModel;
    
    if (_provinceArray.count > 0) {
        if (_firstCurrentIndex > 0) {
            if (_firstCurrentIndex - 1 < _provinceArray.count) {
                pickerModel = _provinceArray[_firstCurrentIndex - 1];
                //获取省
                provinceName =  pickerModel.name;
                _provinceID = pickerModel.provinceID;
            }
        }
    }
    
    if (_cityArray.count > 0) {
        if (_secondCurrentIndex > 0) {
            if (_secondCurrentIndex - 1 < _cityArray.count) {
                cityModel = _cityArray[_secondCurrentIndex - 1];
                //获取市
                cityName = cityModel.name;
                if (cityModel.parent_id == pickerModel.provinceID) {
                    _cityID = cityModel.city_id;
                }
            }
        }
    }
    
    if (_regionArray.count > 0) {
        if (_thirdCurrentIndex > 0) {
            if (_thirdCurrentIndex - 1 < _regionArray.count) {
                //获取区
                regtionModel = _regionArray[_thirdCurrentIndex - 1];
                regtionName = regtionModel.name;
                if (regtionModel.parent_id == cityModel.city_id) {
                    _regtionID = regtionModel.region_id;
                }
                
            }
        }
    }
    NSLog(@"省%ld 市%ld  区%ld",_provinceID,_cityID,_regtionID);
    if (_provinceID == 0) {
      //  [STTextHudTool showText:@"请选择正确的省份" withSecond:1];
        return;
    }else if (_cityID == 0) {
       // [STTextHudTool showText:@"请选择正确的城市" withSecond:1];
        return;
    }else if (_regtionID == 0){
      //  [STTextHudTool showText:@"请选择正确的区(县)" withSecond:1];
        return;
    }
    NSDictionary *params = @{
                             @"province":  @{
                                     @"provinceName":provinceName,
                                     @"provinceID":kStringIntegerFormat(_provinceID)
                                     },
                             @"city": @{
                                     @"cityName":cityName,
                                     @"cityID":kStringIntegerFormat(_cityID)
                                     },
                             @"regition":@{
                                     @"regtionName":regtionName,
                                     @"regitionID":kStringIntegerFormat(_regtionID)
                                     },
                             };
    if (_completion) {
        _completion(params);
    }
}

#pragma mark - 点击取消按钮事件
- (void)cancleButtonAction:(UIButton *)sender
{
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 显示省市区名字
/**
 显示pickerView
 
 @param provinceName 省份名字
 @param cityName     城市名字
 @param regionName   区域名字
 */
- (void)showPickerWithProvinceName:(NSString *)provinceName cityName:(NSString *)cityName countyName:(NSString *)regionName
{
    if (provinceName.length > 0) {
        [_provinceArray enumerateObjectsUsingBlock:^(HPAddAddressPickerModel *pickerModel, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([pickerModel.name isEqualToString:provinceName]) {
                _firstCurrentIndex = idx+1;
                self.cityArray = pickerModel.child;
            }
        }];
    }else {
        _firstCurrentIndex = 0;
        _secondCurrentIndex = 0;
    }
    
    
    [self.cityArray enumerateObjectsUsingBlock:^(HPAddAddressCityModel   *cityModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([cityModel.name isEqualToString:cityName]) {
            _secondCurrentIndex = idx+1;
            self.regionArray = cityModel.child;
        }
    }];
    
    [self.regionArray enumerateObjectsUsingBlock:^(HPAddAddressRegionModel  *regionModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([regionModel.name isEqualToString:regionName]) {
            _thirdCurrentIndex = idx+1;
        }
    }];
    
    
    [self.pickerView reloadAllComponents];
    [_pickerView selectRow:_firstCurrentIndex inComponent:0 animated:NO];
    if (_cityArray.count > 0) {
        [_pickerView selectRow:_secondCurrentIndex inComponent:1 animated:NO];
    }
    if (_regionArray.count > 0) {
        [_pickerView selectRow:_thirdCurrentIndex inComponent:2 animated:NO];
    }
    
}


#pragma mark - 设置UI界面
-(void)setUpUI
{
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width, 45)];
    _headView.backgroundColor =  HPColor(227, 227, 227);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, 60, 45);
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor: HPColor(232, 40, 85) forState:UIControlStateNormal];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.frame.size.width - 60, 0, 60, 45);
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:HPColor(232, 40, 85) forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(completionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:button];
    
    [self addSubview:_headView];
    [self addSubview:self.pickerView];
}

#pragma mark - 请求数据
/**
 网络请求数据   项目中是放在appdelegate里面请求的公共数据，然后存数据库。用的时候取出，这里只为了方便演示
 */
- (void)requestData
{
    __weak typeof (&*self)weakSelf  = self;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request  = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.test.hooclub.com/v1/region"]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        id objc = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        [weakSelf.provinceArray removeAllObjects];
        [weakSelf.provinceArray addObjectsFromArray:[HPAddAddressPickerModel mj_objectArrayWithKeyValuesArray:objc[@"data"][@"province"]]];
    }];
    [task resume];

}

#pragma mark - 懒加载
- (NSMutableArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}

- (NSArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSArray array];
    }
    return _cityArray;
}

- (NSArray *)regionArray
{
    if (!_regionArray) {
        _regionArray = [NSArray array];
    }
    return _regionArray;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 45, self.frame.size.width, self.frame.size.height-45)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [_pickerView selectRow:0 inComponent:0 animated:NO];

    }
    return _pickerView;
}

@end
