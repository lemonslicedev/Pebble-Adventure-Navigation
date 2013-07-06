//
//  PANRootViewController.h
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class PANPredictionsViewController;

@interface PANRootViewController : UIViewController <UITextFieldDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    IBOutlet UITextField *destination;
}

@property (nonatomic, strong) NSString *currentLocation;

@end
