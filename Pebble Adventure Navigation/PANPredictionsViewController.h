//
//  PANPredictionsViewController.h
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PANPredictions;

@interface PANPredictionsViewController : UITableViewController
{
    PANPredictions *pvcPredictions;
}

@property (nonatomic, strong) NSString *pvcDestination;
@property (nonatomic, strong) NSString *pvcLocation; //Place holder before installing CLLocationManager.

- (id)initWithStyle:(UITableViewStyle)style destination:(NSString *)d location:(NSString *)l;

- (void)fetchPredictions;

@end
