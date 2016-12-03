//
//  HPAddAddressPickerView.h
//  testaaaaaaaaaa
//
//  Created by 雷建民 on 16/11/23.
//  Copyright © 2016年 leijianmin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPAddAddressPickerView : UIView


/**
 回调 省市县名字和省市县分别对应的id
 */
@property (nonatomic,copy) void (^completion)(NSDictionary *params);


/**
 显示在界面上的方法

 @param provinceName 省
 @param cityName 城市
 @param regionName 县
 */
- (void)showPickerWithProvinceName:(NSString *)provinceName cityName:(NSString *)cityName countyName:(NSString *)regionName;//显示 省 市 县名



@end
