//
//  LocationDetailVC.m
//  MyWeather
//
//  Created by jay on 2014/4/6.
//  Copyright (c) 2014年 jay. All rights reserved.
//

#import "LocationDetailVC.h"

@interface LocationDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *labelForcastStartTime;
@property (weak, nonatomic) IBOutlet UILabel *labelForcastEndTime;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property (weak, nonatomic) IBOutlet UILabel *labelMaxT;
@property (weak, nonatomic) IBOutlet UILabel *labelMinT;

@property(strong, nonatomic)NSDateFormatter *dateTimeFormater;


@end

@implementation LocationDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateUI];
}


-(void)setLocation:(Location *)location
{
    _location = location;
    
    [self updateUI];
}

-(NSDateFormatter*)dateTimeFormater
{
    if (_dateTimeFormater == nil) {
        
        _dateTimeFormater = [[NSDateFormatter alloc]init];
        [_dateTimeFormater setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
        
        // 2014-04-06T18:00:00+08:00
        //
        [_dateTimeFormater setDateFormat:@"yyyy'-'MM'-'dd HH':'mm':'ss"];
    }
    
    return _dateTimeFormater;
}


-(void)updateUI
{
    Weather *weather = [self.location.arrWeather firstObject];
    
    self.labelForcastStartTime.text = [self.dateTimeFormater stringFromDate: weather.ForecastStartTime];
    self.labelForcastEndTime.text = [self.dateTimeFormater stringFromDate: weather.ForecastEndTime];
    
    self.labelStatus.text = weather.Status;
    self.labelMaxT.text = [NSString stringWithFormat:@"%@度",weather.maxT];
    self.labelMinT.text = [NSString stringWithFormat:@"%@度",weather.minT];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
