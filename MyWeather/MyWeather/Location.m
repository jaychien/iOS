//
//  Location.m
//  MyWeather
//
//  Created by jay on 2014/4/6.
//  Copyright (c) 2014年 jay. All rights reserved.
//

#import "Location.h"

@implementation Location


-(NSMutableArray*) arrWeather
{
    if (_arrWeather == nil)
        _arrWeather = [NSMutableArray array];
    
    return _arrWeather;
    
}

-(Weather*) FindWeatherWithForecastStartTime: (NSDate*)startTime
                                  andEndTime: (NSDate*)endTime
                                 isCreateNew:(BOOL)bNewOne
{
    for (Weather *weather in self.arrWeather) {
        if ([weather.ForecastStartTime isEqual:startTime] &&
            [weather.ForecastEndTime isEqual:endTime]) {
            
            return weather;
        }
    }
    
    if (!bNewOne)
        return nil;
    
    Weather *weather = [[Weather alloc] init];
    weather.ForecastStartTime = [startTime copy];
    weather.ForecastEndTime = [endTime copy];
    
    [self.arrWeather addObject:weather];
        
    return weather;
}


@end
