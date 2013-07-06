//
//  PANRouteViewController.m
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "PANRouteViewController.h"
#import "PANDirections.h"
#import "PANGoogleInterface.h"
#import "PANMapPoint.h"
#import "PANWayPoint.h"

@implementation PANRouteViewController

@synthesize rtvcDestination, rtvcLocation, wayPoints, wayPointIndex, nextMonitoredRegion;

- (id)initWithDestination:(NSString *)destination location:(NSString *)location
{
    self = [super init];
    
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager setDelegate:self];
        [locationManager startUpdatingLocation];
        [self setRtvcDestination:destination];
        [self setRtvcLocation:location];
        [self fetchDirections];
        
    };
    
    return self;
}

- (void)fetchDirections
{
    void(^completionBlock)(PANDirections *obj, NSError *err) = ^(PANDirections *obj, NSError *err) {
        if (!err) {
            rtvcDirections = obj;
            [self setEndPoint];
            [self setWayPoints];
            [self placeWayPointsOnMap];
            [self placeRouteOnMap];
            [self startTrip];
            
//            [self setWayPointIndex:1];
//            
//            wayPoints = [[NSMutableArray alloc] init];
//            
//            for (int i = 0; i < [rtvcDirections countSteps]; i ++) {
//                CLLocation *loc = [[rtvcDirections retrieveWayPointMarkerData] objectAtIndex:i];
//                CLLocationCoordinate2D coord = [loc coordinate];
//                
//                NSString *instruction = [[rtvcDirections retrieveWayPointMarkerText] objectAtIndex:i];
//                
//                CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:coord radius:5 identifier:instruction];
//                
//                [wayPoints addObject:region];
//                
//                PANMapPoint *mapPoint = [[PANMapPoint alloc] initWithCoordinate:coord title:instruction];
//                
//                [worldView addAnnotation:mapPoint];
//                
//            }
//            //int index = wayPointIndex + 1;
//            
//            
//            NSLog(@"%@", [wayPoints objectAtIndex:wayPointIndex]);
//            
//            
//            
//            [locationManager startMonitoringForRegion:[wayPoints objectAtIndex:wayPointIndex]];
//            
//            NSLog(@"Monitored Regions: %@", [locationManager monitoredRegions]);
//            
//            NSInteger coordsCount = [[rtvcDirections retrieveRouteCoordinates] count];
//            
//            CLLocationCoordinate2D coords[coordsCount];
//            
//            for (int i = 0; i < coordsCount; i++) {
//                CLLocation *loc = [[rtvcDirections retrieveRouteCoordinates] objectAtIndex:i];
//                coords[i] = [loc coordinate];
//            }
//            
//            MKPolyline *routePolyline = [MKPolyline polylineWithCoordinates:coords count:coordsCount];
//            [worldView addOverlay:routePolyline];
            
        } else {
            NSString *errorString = [[NSString alloc] initWithFormat:@"Failed To Get Directions: %@", [err localizedDescription]];
            
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [av show];
        }
    };
    
    [[PANGoogleInterface sharedStore] fetchDirectionsWithCompletion:completionBlock origin:[self rtvcLocation] destination:[self rtvcDestination]];
}

- (void)setEndPoint
{
    PANMapPoint *mp = [[PANMapPoint alloc] initWithCoordinate:[rtvcDirections retrieveEndPoint] title:[rtvcDirections retrieveEndAddress]];
    
    [worldView addAnnotation:mp];
}

- (void)setWayPoints
{
    wayPoints = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [rtvcDirections countSteps]; i++) {
        CLLocation *directionsLocation = [[rtvcDirections retrieveWayPointMarkerData] objectAtIndex:i];
        NSString *directionsText = [[rtvcDirections retrieveWayPointMarkerText] objectAtIndex:i];
        
        PANWayPoint *wayPoint = [[PANWayPoint alloc] initWithLocation:directionsLocation direction:directionsText];
        
        [wayPoints addObject:wayPoint];
    }
    
    NSLog(@"WayPoints Array: %@", [self wayPoints]);
}

- (void)placeWayPointsOnMap
{
    for (int i = 0; i < [[self wayPoints] count]; i++) {
        PANWayPoint *wp = [[self wayPoints] objectAtIndex:i];
        CLLocationCoordinate2D coord = [wp coordinate];
        NSString *mapPointText = [wp wayPointDirection];
        
        PANMapPoint *mp = [[PANMapPoint alloc] initWithCoordinate:coord title:mapPointText];
        [worldView addAnnotation:mp];
    }
}

- (void)placeRouteOnMap
{
    NSInteger coordsCount = [[self wayPoints] count];
    
    CLLocationCoordinate2D coords[coordsCount]; //Array of coordinates
    
    for (int i = 0; i < coordsCount; i++) {
        PANWayPoint *wp = [[self wayPoints] objectAtIndex:i];
        CLLocationCoordinate2D coord = [wp coordinate];
        
        coords[i] = coord;
    }
    
    MKPolyline *routePolyline = [MKPolyline polylineWithCoordinates:coords count:coordsCount];
    [worldView addOverlay:routePolyline];
}

- (void)startTrip
{
    //Some of this needs to be refactored.
    
    [self setWayPointIndex:0];
    
    NSLog(@"[wayPointIndex]: %d", [self wayPointIndex]);
    
    PANWayPoint *startingPoint = [[self wayPoints] objectAtIndex:[self wayPointIndex]];
    
    NSString *startingLocationText = [[NSString alloc] initWithFormat:@"%@", startingPoint];
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Start Adventure" message:startingLocationText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //Technically the app should rotate waypoints automatically but maybe for testing I should set self as the UIAlertView delegate so I can rotate things manually.
    
    [av show];
    
    int inc = [self wayPointIndex] + 1;
    
    [self setWayPointIndex:inc];
    
    NSLog(@"[wayPointIndex]; %d", [self wayPointIndex]);
    
    NSString *lblNextWayPoint = [[NSString alloc] initWithFormat:@"%@", [[self wayPoints] objectAtIndex:[self wayPointIndex]]];
    
    [lblMonitoredRegion setText:lblNextWayPoint];
}

- (void)viewDidLoad
{
    [worldView setShowsUserLocation:YES];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 1000, 1000);
    [worldView setRegion:region animated:YES];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithOverlay:overlay];
    [polylineView setStrokeColor:[UIColor blueColor]];
    [polylineView setLineWidth:5.0];
    
    return polylineView;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *curLoc = [locations objectAtIndex:0];
    
    NSString *currentLocation = [[NSString alloc ] initWithFormat:@"CL: %@", curLoc];
    [lblCurrentLocation setText:currentLocation];
    
    //Now I need to set the label that states the distance to the next waypoint
    
    PANWayPoint *wp = [[self wayPoints] objectAtIndex:[self wayPointIndex]];
    CLLocation *toLoc = [wp wayPointLocation];
    
    CLLocationDistance distToWayPoint = [curLoc distanceFromLocation:toLoc];
    
    NSString *labelText = [[NSString alloc] initWithFormat:@"%f", distToWayPoint];
    
    [lblDistanceToWayPoint setText:labelText];
    
    //TODO: Field test the accuracy of the distance to the waypoint, then display an alert of the instructions of waypoint at index, then change to next way point.
    
    if (distToWayPoint < 25) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Next" message:[wp wayPointDirection] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [av show];
        
        int inc = [self wayPointIndex] + 1;
        
        if (inc > ([[self wayPoints] count] - 1)) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"End" message:@"End Of Route" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [av show];
        } else {
            [self setWayPointIndex:inc];
            
            NSLog(@"[wayPointIndex]; %d", [self wayPointIndex]);
            
            NSString *lblNextWayPoint = [[NSString alloc] initWithFormat:@"%@", [[self wayPoints] objectAtIndex:[self wayPointIndex]]];
            
            [lblMonitoredRegion setText:lblNextWayPoint];
        }
    }
    
}

//- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
//{
//    NSString *monitoredRegion = [[NSString alloc] initWithFormat:@"MR: %@", region];
//    [lblMonitoredRegion setText:monitoredRegion];
//    
//    [self setNextMonitoredRegion:region];
//}
//
//
//
//- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
//{
//    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Entered Region" message:[NSString stringWithFormat:@"Region: %@", region] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [av show];
//    
//    NSLog(@"[Pebble Adventure Navigation]: [Location Manager]: Entered Region (%@)", region);
//    
//    [locationManager stopMonitoringForRegion:region];
//    
//    int index = wayPointIndex + 1;
//    
//    [self setWayPointIndex:index];
//    
//    if (wayPointIndex <= [wayPoints count]) {
//        [locationManager startMonitoringForRegion:[wayPoints objectAtIndex:wayPointIndex]];
//    } else {
//        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"End Route" message:@"No more regions" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        
//        [av show];
//    }
//    
//
//}

- (void)dealloc {
    [locationManager setDelegate:nil];
}

@end
