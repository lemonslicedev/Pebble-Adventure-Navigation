//
//  PANRoutes.h
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PANJSONSerializable.h"

@class PANLeg;

@interface PANRoutes : NSObject <PANJSONSerializable>

@property (nonatomic, strong) NSDictionary *bounds;
@property (nonatomic, strong) NSMutableArray *legs; //Container array for leg object.
@property (nonatomic, strong) NSString *summary;

- (NSString *)boundsGetNortheast; //Returns a string with latitude and longitude.
- (NSString *)boundsGetSouthwest; //Returns a string with latitude and longitude.

@end
