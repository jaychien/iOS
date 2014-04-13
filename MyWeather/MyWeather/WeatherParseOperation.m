//
//  WeatherParseOperation.m
//  MyWeather
//
//  Created by jay on 2014/4/12.
//  Copyright (c) 2014年 jay. All rights reserved.
//

#import "WeatherParseOperation.h"
#import "Location.h"
#import "WeatherCommon.h"

@interface WeatherParseOperation() <NSXMLParserDelegate>

@property(strong, nonatomic)NSData *parseData;

@property (nonatomic) NSMutableString *currentParsedCharacterData;
@property (nonatomic)BOOL accumulatingParsedCharacterData;

@property (strong, nonatomic)Location *currentLocation;
@property (strong, nonatomic)NSMutableArray *arrLocation;
@property (strong, nonatomic)Weather *currentWeather;

@property (nonatomic) NSDate *currentStartTime;
@property (nonatomic) NSDate *currentEndTime;



@property (nonatomic)BOOL isInWeatherElement;
@property (nonatomic)BOOL isInWXElement;
@property (nonatomic)BOOL isInMaxTElement;
@property (nonatomic)BOOL isInMinTElement;
@property (nonatomic)BOOL isInCIElement;


@property(strong, nonatomic)NSDateFormatter *dateTimeFormater;

@end


@implementation WeatherParseOperation


-(instancetype) initWithData:(NSData *)parseData
{
    self = [super init];
    
    if (self) {
        self.parseData = parseData;
    }
    return self;

}

-(NSMutableString*)currentParsedCharacterData
{
    if (_currentParsedCharacterData == nil)
        _currentParsedCharacterData = [[NSMutableString alloc]init];
    
    return _currentParsedCharacterData;
}

-(NSMutableArray*) arrLocation
{
    if (_arrLocation == nil)
        _arrLocation = [NSMutableArray array];
    
    return _arrLocation;
}

-(NSDateFormatter*)dateTimeFormater
{
    if (_dateTimeFormater == nil) {
        
        _dateTimeFormater = [[NSDateFormatter alloc]init];
        [_dateTimeFormater setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];

        // 2014-04-06T18:00:00+08:00
        // 
        [_dateTimeFormater setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"];
    }
    
    return _dateTimeFormater;
}


- (void)main {
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.parseData];
    [parser setDelegate:self];
    
    
    if ([parser parse] == YES) {
        
        [self performSelectorOnMainThread:@selector(parseDataComplete:)
                               withObject:self.arrLocation
                            waitUntilDone:YES];
        
    }
    

}


-(void)parseDataComplete:(NSArray*) arrLocation
{
    [[NSNotificationCenter defaultCenter] postNotificationName:weatherResultNotificationName
                                                        object:self
                                                      userInfo:@{weatherResultKey: arrLocation}];
}

#pragma mark - Parser constants: XML element

static NSString * const NameElementName = @"name";

static NSString * const WeatherElementName = @"weather-elements";
static NSString * const WxElementName = @"Wx";
static NSString * const TimeElementName = @"time";
static NSString * const TextElementName = @"text";
static NSString * const MaxTElementName = @"MaxT";
static NSString * const MinTElementName = @"MinT";
static NSString * const ValueElementName = @"value";



#pragma mark - NSXMLParser delegate methods

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:NameElementName]){
        
        self.accumulatingParsedCharacterData = YES;
        [self.currentParsedCharacterData setString:@""];
        
        self.currentLocation = [[Location alloc]init];
    } else if ([elementName isEqualToString:WeatherElementName]) {
        
        self.isInWeatherElement = YES;
        
    } else if ([elementName isEqualToString:WxElementName]) {
        
        self.isInWXElement = YES;
        
        
        
    } else if ([elementName isEqualToString:MaxTElementName]) {
        
        self.isInMaxTElement = YES;
        
    } else if ([elementName isEqualToString:MinTElementName]) {
        
        self.isInMinTElement = YES;
        
    } else if ([elementName isEqualToString:TimeElementName]) {
        
        self.currentStartTime = [self.dateTimeFormater dateFromString:[attributeDict valueForKey:@"start"]];
        self.currentEndTime = [self.dateTimeFormater dateFromString:[attributeDict valueForKey:@"end"]];
        
        NSLog(@"%@, %@", self.currentStartTime, self.currentEndTime);
        
        self.currentWeather = [self.currentLocation FindWeatherWithForecastStartTime:self.currentStartTime
                                                                          andEndTime:self.currentEndTime isCreateNew:YES];
        
    } else if ([elementName isEqualToString:TextElementName]) {
        
        self.accumulatingParsedCharacterData = YES;
        [self.currentParsedCharacterData setString:@""];

        
    } else if ([elementName isEqualToString:ValueElementName]) {
        
        self.accumulatingParsedCharacterData = YES;
        [self.currentParsedCharacterData setString:@""];
        
        
    }
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:NameElementName]){
        
        self.currentLocation.Name = [self.currentParsedCharacterData copy];
        
        [self.arrLocation addObject:self.currentLocation];
        
    } else if ([elementName isEqualToString:WeatherElementName]) {
        
        self.isInWeatherElement = NO;
        
    } else if ([elementName isEqualToString:WxElementName]) {
        
        self.isInWXElement = NO;
        
    } else if ([elementName isEqualToString:MaxTElementName]) {
        
        self.isInMaxTElement = NO;
        
    } else if ([elementName isEqualToString:MinTElementName]) {
        
        self.isInMinTElement = NO;
        
    } else if ([elementName isEqualToString:TextElementName]) {
        
        if (self.isInWXElement) {
            
            self.currentWeather = [self.currentLocation FindWeatherWithForecastStartTime:self.currentStartTime
                                                                              andEndTime:self.currentEndTime isCreateNew:YES];
            
            self.currentWeather.Status = [self.currentParsedCharacterData copy];

            
        }
        
        
    } else if ([elementName isEqualToString:ValueElementName]) {
        
        if (self.isInMaxTElement) {
            
            self.currentWeather = [self.currentLocation FindWeatherWithForecastStartTime:self.currentStartTime
                                                                              andEndTime:self.currentEndTime isCreateNew:YES];
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            self.currentWeather.maxT = [f numberFromString:self.currentParsedCharacterData];
            
        }
        
        if (self.isInMinTElement) {
            
            self.currentWeather = [self.currentLocation FindWeatherWithForecastStartTime:self.currentStartTime
                                                                              andEndTime:self.currentEndTime isCreateNew:YES];
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            self.currentWeather.minT = [f numberFromString:self.currentParsedCharacterData];
            
        }
        
    }

    
    
    self.accumulatingParsedCharacterData = NO;

}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
     if (self.accumulatingParsedCharacterData) {
         [self.currentParsedCharacterData appendString:string];
     }
    
}


-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    /*
     [self performSelectorOnMainThread:@selector(parseDataError:)
     withObject:parseError
     waitUntilDone:YES];
     */
    
}


@end
