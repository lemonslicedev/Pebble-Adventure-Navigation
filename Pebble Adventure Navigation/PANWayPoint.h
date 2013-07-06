//
//  PANWayPoint.h
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-06.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface PANWayPoint : NSObject

@property (nonatomic, strong) CLLocation *wayPointLocation;
@property (nonatomic, strong) NSString *wayPointDirection;

- (id)initWithLocation:(CLLocation *)location direction:(NSString *)direction;

- (CLLocationCoordinate2D)coordinate;

@end
