//
//  PANDirections.m
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "PANDirections.h"
#import "PANRoutes.h"
#import "PANLeg.h"
#import "PANStep.h"

@implementation PANDirections

@synthesize status, routes;

- (id)init
{
    self = [super init];
    
    if (self) {
        routes = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)readFromJSONDictionary:(NSDictionary *)d
{
    [self setStatus:[d objectForKey:@"status"]];
    
    NSArray *jsonRoutes = [d objectForKey:@"routes"];
    
    for (NSDictionary *routeDictionary in jsonRoutes) {
        PANRoutes *routeObject = [[PANRoutes alloc] init];
        [routeObject readFromJSONDictionary:routeDictionary];
        
        [routes addObject:routeObject];
    }
}

- (NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@, Routes: %@", status, routes];
    
    return descriptionString;
}

- (CLLocationCoordinate2D)retrieveEndPoint
{
    PANRoutes *firstRoute = [routes objectAtIndex:0];
    PANLeg *firstLeg = [[firstRoute legs] objectAtIndex:0];
    
    return CLLocationCoordinate2DMake([[firstLeg endLocationGetLatitude] doubleValue], [[firstLeg endLocationGetLongitude] doubleValue]);
}

- (NSString *)retrieveEndAddress
{
    PANLeg *firstLeg = [[[routes objectAtIndex:0] legs] objectAtIndex:0];
    
    return [firstLeg endAddress];
}

- (NSMutableArray *)retrieveRouteCoordinates
{
    NSMutableArray *arrayOfCoordinates = [[NSMutableArray alloc] init];
    
    PANLeg *firstLeg = [[[routes objectAtIndex:0] legs] objectAtIndex:0];
    
    for (int i = 0; i < [[firstLeg steps] count]; i++) {
        PANStep *step = [[firstLeg steps] objectAtIndex:i];
        
        CLLocation *startloc = [[CLLocation alloc] initWithLatitude:[[step startLocationGetLatitude] doubleValue] longitude:[[step startLocationGetLongitude] doubleValue]];
        
        CLLocation *endloc = [[CLLocation alloc] initWithLatitude:[[step endLocationGetLatitude] doubleValue] longitude:[[step endLocationGetLongitude] doubleValue]];
        
        [arrayOfCoordinates addObject:startloc];
        [arrayOfCoordinates addObject:endloc];
    }
    
    return arrayOfCoordinates;
}

- (NSMutableArray *)retrieveWayPointMarkerText
{
    NSMutableArray *arrayOfWayPointText = [[NSMutableArray alloc] init];
    
    PANLeg *firstLeg = [[[routes objectAtIndex:0] legs] objectAtIndex:0];
    
    for (int i = 0; i < [[firstLeg steps] count]; i++) {
        PANStep *step = [[firstLeg steps] objectAtIndex:i];
        
        [arrayOfWayPointText addObject:[step instructions]];
    }
    
    return arrayOfWayPointText;
}

- (NSMutableArray *)retrieveWayPointMarkerData
{
    NSMutableArray *arrayOfMarkerPoints = [[NSMutableArray alloc] init];
    
    PANLeg *firstLeg = [[[routes objectAtIndex:0] legs] objectAtIndex:0];
    
    for (int i = 0; i < [[firstLeg steps] count]; i++) {
        PANStep *step = [[firstLeg steps] objectAtIndex:i];
        
        CLLocation *endloc = [[CLLocation alloc] initWithLatitude:[[step startLocationGetLatitude] doubleValue] longitude:[[step startLocationGetLongitude] doubleValue]];
        
        [arrayOfMarkerPoints addObject:endloc];
    }
    
    return arrayOfMarkerPoints;
}

- (int)countSteps
{
    PANLeg *firstLeg = [[[routes objectAtIndex:0] legs] objectAtIndex:0];
    
    return [[firstLeg steps] count];
}

@end
