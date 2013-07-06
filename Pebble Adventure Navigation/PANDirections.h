//
//  PANDirections.h
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "PANJSONSerializable.h"

@class PANRoutes;
@class PANLeg;

@interface PANDirections : NSObject <PANJSONSerializable>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSMutableArray *routes; //Container array of routes.

- (CLLocationCoordinate2D)retrieveEndPoint;
- (NSString *)retrieveEndAddress;

- (NSMutableArray *)retrieveRouteCoordinates;

- (NSMutableArray *)retrieveWayPointMarkerText;
- (NSMutableArray *)retrieveWayPointMarkerData;

- (int)countSteps;
@end
