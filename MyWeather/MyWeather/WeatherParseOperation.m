//
//  WeatherParseOperation.m
//  MyWeather
//
//  Created by jay on 2014/4/12.
//  Copyright (c) 2014年 jay. All rights reserved.
//

#import "WeatherParseOperation.h"
#import "Location.h"

@interface WeatherParseOperation() <NSXMLParserDelegate>

@property(strong, nonatomic)NSData *parseData;

@property (nonatomic) NSMutableString *currentParsedCharacterData;
@property (nonatomic)BOOL accumulatingParsedCharacterData;

@property (strong, nonatomic)Location *currentLocation;
@property (strong, nonatomic)NSMutableArray *arrLocation;


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


- (void)main {
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.parseData];
    [parser setDelegate:self];
    [parser parse];

}

#pragma mark - Parser constants: XML element

static NSString * const NameElementName = @"name";



#pragma mark - NSXMLParser delegate methods

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:NameElementName]){
        
        self.accumulatingParsedCharacterData = YES;
        [self.currentParsedCharacterData setString:@""];
        
        self.currentLocation = [[Location alloc]init];
    }
    
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:NameElementName]){
        
        self.currentLocation.Name = self.currentParsedCharacterData;
        
        [self.arrLocation addObject:self.currentLocation];
        
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
