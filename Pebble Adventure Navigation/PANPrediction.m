//
//  PANPrediction.m
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "PANPrediction.h"

@implementation PANPrediction

@synthesize predictionText;

- (void)readFromJSONDictionary:(NSDictionary *)d
{
    [self setPredictionText:[d objectForKey:@"description"]];
}

- (NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@", predictionText];
    
    return descriptionString;
}

@end
