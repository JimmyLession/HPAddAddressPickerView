//
//  HPAddAddressPickerModel.m
//  testaaaaaaaaaa
//
//  Created by 雷建民 on 16/11/23.
//  Copyright © 2016年 leijianmin. All rights reserved.
//

#import "HPAddAddressPickerModel.h"
#import "MJExtension.h"
@implementation HPAddAddressPickerModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
   return  @{@"provinceID":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"child":[HPAddAddressCityModel class]};
}
@end
@implementation HPAddAddressCityModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return  @{@"city_id":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"child":[HPAddAddressRegionModel class]};
}

@end
@implementation HPAddAddressRegionModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return  @{@"region_id":@"id"};
}


@end
