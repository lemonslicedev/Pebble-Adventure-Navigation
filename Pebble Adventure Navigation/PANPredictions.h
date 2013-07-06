//
//  PANPredictions.h
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PANJSONSerializable.h"

@class PANPrediction;

@interface PANPredictions : NSObject <PANJSONSerializable>

@property (nonatomic, strong) NSString *status; //Status of feed, whether OK or failure (In case of API failure)
@property (nonatomic, strong) NSMutableArray *predictions; //Container array of PANPrediction Objects

@end
