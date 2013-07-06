//
//  PANStep.m
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "PANStep.h"

@implementation PANStep

@synthesize duration, distance, startLocation, endLocation, instructions, travelMode;

- (void)readFromJSONDictionary:(NSDictionary *)d
{
    [self setDuration:[d objectForKey:@"duration"]];
    [self setDistance:[d objectForKey:@"distance"]];
    [self setStartLocation:[d objectForKey:@"start_location"]];
    [self setEndLocation:[d objectForKey:@"end_location"]];
    [self setInstructions:[d objectForKey:@"html_instructions"]];
    [self setTravelMode:[d objectForKey:@"travel_mode"]];
}

- (NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@", instructions];
    
    return descriptionString;
}

- (NSString *)startLocationGetLatitude
{
    return [[self startLocation] objectForKey:@"lat"];
}

- (NSString *)startLocationGetLongitude
{
    return [[self startLocation] objectForKey:@"lng"];
}

//Question: When it comes to class variables, when should I use messages and simply variables? Does it matter?

- (NSString *)endLocationGetLatitude
{
    return [[self endLocation] objectForKey:@"lat"];
}

- (NSString *)endLocationGetLongitude
{
    return [[self endLocation] objectForKey:@"lng"];
}

@end
