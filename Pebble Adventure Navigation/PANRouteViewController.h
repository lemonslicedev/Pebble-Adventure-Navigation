//
//  PANRouteViewController.h
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@class PANDirections;

@interface PANRouteViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    PANDirections *rtvcDirections;
    IBOutlet MKMapView *worldView;
    IBOutlet UILabel *lblCurrentLocation;
    IBOutlet UILabel *lblMonitoredRegion;
    IBOutlet UILabel *lblDistanceToWayPoint;
}

- (id)initWithDestination:(NSString *)destination location:(NSString *)location;

@property (nonatomic, strong) NSString *rtvcDestination;
@property (nonatomic, strong) NSString *rtvcLocation;

@property (nonatomic, strong) NSMutableArray *wayPoints;
@property (nonatomic) int wayPointIndex;
@property (nonatomic, strong) CLRegion *nextMonitoredRegion;

- (void)fetchDirections;
- (void)setEndPoint;
- (void)setWayPoints;
- (void)placeWayPointsOnMap;
- (void)placeRouteOnMap;
- (void)startTrip;
@end
