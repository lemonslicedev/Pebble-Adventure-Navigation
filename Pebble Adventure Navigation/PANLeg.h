//
//  PANLeg.h
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PANJSONSerializable.h"

@interface PANLeg : NSObject <PANJSONSerializable>

@property (nonatomic, strong) NSDictionary *distance;
@property (nonatomic, strong) NSDictionary *duration;

@property (nonatomic, strong) NSString *startAddress;
@property (nonatomic, strong) NSString *endAddress;

@property (nonatomic, strong) NSDictionary *startLocation;
@property (nonatomic, strong) NSDictionary *endLocation;

@property (nonatomic, strong) NSMutableArray *steps; //Container array of steps objects.

- (NSString *)distanceGetText;
- (NSInteger *)distanceGetValue;

- (NSString *)durationGetText;
- (NSInteger *)durationGetValue;

- (NSString *)startLocationGetLatitude;
- (NSString *)startLocationGetLongitude;

- (NSString *)endLocationGetLatitude;
- (NSString *)endLocationGetLongitude;

@end
