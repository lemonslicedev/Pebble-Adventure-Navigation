//
//  PANWayPoint.m
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-06.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "PANWayPoint.h"
#import <CoreLocation/CoreLocation.h>

@implementation PANWayPoint

@synthesize wayPointLocation, wayPointDirection;

- (id)initWithLocation:(CLLocation *)location direction:(NSString *)direction
{
    self = [super init];
    
    if (self) {
        [self setWayPointLocation:location];
        [self setWayPointDirection:direction];
    }
    
    return self;
}

- (NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"Location: %@, %@", [self wayPointLocation], [self wayPointDirection]];
    
    return descriptionString;
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D loc = [[self wayPointLocation] coordinate];
    
    return loc;
}

@end
