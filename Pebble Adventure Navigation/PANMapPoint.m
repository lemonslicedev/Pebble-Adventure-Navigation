//
//  PANMapPoint.m
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "PANMapPoint.h"

@implementation PANMapPoint

@synthesize coordinate, title;

- (id)init
{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(43.07, -89.32) title:@"Hometown"];
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    self = [super init];
    
    if (self) {
        coordinate = c;
        [self setTitle:t];
    }
    
    return self;
}

@end
