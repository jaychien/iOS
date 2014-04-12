//
//  Location.h
//  MyWeather
//
//  Created by jay on 2014/4/6.
//  Copyright (c) 2014年 jay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property(strong, nonatomic)NSString *Name;               // 城市名稱
@property(strong, nonatomic)NSMutableArray *arrWeather;   // 天氣預報

@end
