//
//  PANRoutes.m
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "PANRoutes.h"
#import "PANLeg.h"

@implementation PANRoutes

@synthesize bounds, legs, summary;

- (id)init
{
    self = [super init];
    
    if (self) {
        legs = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)readFromJSONDictionary:(NSDictionary *)d
{
    [self setBounds:[d objectForKey:@"bounds"]];
    [self setSummary:[d objectForKey:@"summary"]];
    
    NSArray *jsonLegs = [d objectForKey:@"legs"];
    
    for (NSDictionary *legsDictionary in jsonLegs) {
        PANLeg *legObject = [[PANLeg alloc] init];
        
        [legObject readFromJSONDictionary:legsDictionary];
        
        [legs addObject:legObject];
    }
}

- (NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@, Bounds: (%@, %@), Legs: %@", summary, [self boundsGetNortheast], [self boundsGetSouthwest], legs];
    
    return descriptionString;
}

- (NSString *)boundsGetNortheast
{
    NSDictionary *boundsNortheast = [bounds objectForKey:@"northeast"];
    
    NSString *boundsLatitude = [boundsNortheast objectForKey:@"lat"];
    NSString *boundsLongitude = [boundsNortheast objectForKey:@"lng"];
    
    return [NSString stringWithFormat:@"%@,%@", boundsLatitude, boundsLongitude];
}

- (NSString *)boundsGetSouthwest
{
    NSDictionary *boundsSouthwest = [bounds objectForKey:@"southwest"];
    
    return [NSString stringWithFormat:@"%@,%@", [boundsSouthwest objectForKey:@"lat"], [boundsSouthwest objectForKey:@"lng"]];
}

@end
