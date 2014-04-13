//
//  LocationTVC.m
//  MyWeather
//
//  Created by jay on 2014/4/6.
//  Copyright (c) 2014年 jay. All rights reserved.
//

#import "LocationTVC.h"
#import "WeatherParseOperation.h"
#import "WeatherCommon.h"
#import "Location.h"
#import "LocationDetailVC.h"

@interface LocationTVC ()
@property (nonatomic) NSOperationQueue *parseQueue;

@property(nonatomic, strong)NSMutableArray *arrLocation;

@end

@implementation LocationTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"台灣天氣";
    
    [self fetchWeatherResult];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                             selector:@selector(onWeatherResult:)
                                                 name:weatherResultNotificationName
                                               object:nil];
}

-(NSOperationQueue*) parseQueue
{
    if (_parseQueue  == nil)
        _parseQueue = [[NSOperationQueue alloc]init];
    
    return _parseQueue;
}


-(IBAction)fetchWeatherResult
{
    dispatch_queue_t opQueue = dispatch_queue_create("Fetch weather", NULL);
    
    dispatch_async(opQueue, ^{
        
        static NSString* InfoURL = @"http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-001.xml";
        
        NSURL *url = [NSURL URLWithString:InfoURL];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.refreshControl endRefreshing];
            
            if (data != nil) {
                WeatherParseOperation *operation = [[WeatherParseOperation alloc]initWithData:data];
                [self.parseQueue addOperation:operation];
                
                
            } else {
                // Todo: handle error
                //
                
            }
        });
    });
    
}
     
- (void)onWeatherResult:(NSNotification *)notify
{
    assert([NSThread isMainThread]);
    
    self.arrLocation = [[notify userInfo]valueForKey:weatherResultKey];
    
    NSLog(@"location count = %lu", [self.arrLocation count]);

    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrLocation count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Location" forIndexPath:indexPath];
    
    Location *location = self.arrLocation[indexPath.row];
    
    cell.textLabel.text = location.Name;
    
    Weather *weather = [location.arrWeather firstObject];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", weather.Status];
    
    
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (最高溫=%@度, 最低溫=%@度)",
      //                           weather.Status, weather.maxT, weather.minT];
    
    
    
    return cell;
}

#pragma mark - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    if ([[segue destinationViewController] isKindOfClass:[LocationDetailVC class]])
    {
        Location *location = self.arrLocation[indexPath.row];
        
        LocationDetailVC *detailVC = [segue destinationViewController];
        
        detailVC.title = location.Name;
        detailVC.location = location;
        
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
