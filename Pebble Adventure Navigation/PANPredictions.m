//
//  PANPredictions.m
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "PANPredictions.h"
#import "PANPrediction.h"

@implementation PANPredictions

@synthesize status, predictions;

- (id)init
{
    self = [super init];
    
    if (self) {
        predictions = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)readFromJSONDictionary:(NSDictionary *)d
{
    NSArray *predictionsJsonArray = [d objectForKey:@"predictions"];
    
    for (NSDictionary *predictionDictionary in predictionsJsonArray) {
        PANPrediction *predictionObject = [[PANPrediction alloc] init];
        
        [predictionObject readFromJSONDictionary:predictionDictionary];
        
        [predictions addObject:predictionObject];
    }
}

@end
