//
//  PANLeg.m
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "PANLeg.h"
#import "PANStep.h"

@implementation PANLeg

@synthesize distance, duration, startAddress, endAddress, startLocation, endLocation, steps;

- (id)init
{
    self = [super init];
    
    if (self) {
        steps = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)readFromJSONDictionary:(NSDictionary *)d
{
    [self setDistance:[d objectForKey:@"distance"]];
    [self setDuration:[d objectForKey:@"duration"]];
    [self setStartAddress:[d objectForKey:@"start_address"]];
    [self setEndAddress:[d objectForKey:@"end_address"]];
    [self setStartLocation:[d objectForKey:@"start_location"]];
    [self setEndLocation:[d objectForKey:@"end_location"]];
    
    NSArray *jsonSteps = [d objectForKey:@"steps"];
    
    for (NSDictionary *stepDictionary in jsonSteps) {
        PANStep *stepObject = [[PANStep alloc] init];
        [stepObject readFromJSONDictionary:stepDictionary];
        
        [steps addObject:stepObject];
    }
}

- (NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@ to %@", startAddress, endAddress];
    
    return descriptionString;
}

//Implement this later

- (NSString *)distanceGetText
{
    return nil;
}

- (NSInteger *)distanceGetValue
{
    return nil;
}

- (NSString *)durationGetText
{
    return nil;
}

- (NSInteger *)durationGetValue
{
    return nil;
}

- (NSString *)startLocationGetLatitude
{
    return [[self startLocation] objectForKey:@"lat"];
}

- (NSString *)startLocationGetLongitude
{
    return [[self startLocation] objectForKey:@"lng"];
}

- (NSString *)endLocationGetLatitude
{
    return [[self endLocation] objectForKey:@"lat"];
}

- (NSString *)endLocationGetLongitude
{
    return [[self endLocation] objectForKey:@"lng"];
}

@end
