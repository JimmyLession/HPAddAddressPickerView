//
//  HPAddAddressPickerModel.h
//  testaaaaaaaaaa
//
//  Created by 雷建民 on 16/11/23.
//  Copyright © 2016年 leijianmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPAddAddressPickerModel : NSObject

@property (nonatomic ,copy) NSString *name;

@property (nonatomic ,assign) NSInteger provinceID;

@property (nonatomic ,strong) NSArray *child;

@end
@interface HPAddAddressCityModel : NSObject

@property (nonatomic ,copy) NSString *name;

@property (nonatomic ,assign) NSInteger parent_id;

@property (nonatomic ,assign) NSInteger city_id;

@property (nonatomic ,strong) NSArray *child;

@end
@interface HPAddAddressRegionModel : NSObject

@property (nonatomic ,copy) NSString *name;

@property (nonatomic ,assign) NSInteger parent_id;

@property (nonatomic ,assign) NSInteger region_id;
@end
