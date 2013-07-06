//
//  PANRootViewController.m
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "PANRootViewController.h"
#import "PANPredictionsViewController.h"

@implementation PANRootViewController

@synthesize currentLocation;

- (id)init
{
    self = [super init];
    
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager setDelegate:self];
        [locationManager startUpdatingLocation];
    }
    
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    PANPredictionsViewController *pvc = [[PANPredictionsViewController alloc] initWithStyle:UITableViewStyleGrouped destination:[destination text] location:currentLocation];
    
    [[self navigationController] pushViewController:pvc animated:YES];
    
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *curLocation = [locations objectAtIndex:0];
    CLLocationCoordinate2D loc = [curLocation coordinate];
    
    [self setCurrentLocation:[NSString stringWithFormat:@"%f,%f", loc.latitude, loc.longitude]];
}

@end
