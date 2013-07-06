//
//  PANGoogleInterface.h
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PANPredictions;
@class PANDirections;

@interface PANGoogleInterface : NSObject

+ (PANGoogleInterface *)sharedStore;

- (void)fetchPredictionWithCompletion:(void (^)(PANPredictions *obj, NSError *err))block input:(NSString *)input location:(NSString *)location;

- (void)fetchDirectionsWithCompletion:(void (^)(PANDirections *obj, NSError *err))block origin:(NSString *)origin destination:(NSString *)destination;

@property (nonatomic, strong) NSString *apiKey;

@end
