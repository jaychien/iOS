//
//  Weather.h
//  MyWeather
//
//  Created by jay on 2014/4/12.
//  Copyright (c) 2014年 jay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property(strong, nonatomic)NSString *Name;

@property(strong, nonatomic)NSDate *ForecastStartTime; // 預報開始時間: ex: 2014-04-06T18:00:00+08:00
@property(strong, nonatomic)NSDate *ForecastEndTime;   // 預報結束時間: ex: 2014-04-06T18:00:00+08:00
@property(strong, nonatomic)NSString *Status;          // 天氣描述: ex: 多雲時陰短暫陣雨
@property(strong, nonatomic)NSNumber *maxT;            // 最高溫
@property(strong, nonatomic)NSNumber *minT;            // 最低溫

@end
