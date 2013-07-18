//
//  PANPebbleInterface.h
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-08.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PebbleKit/PebbleKit.h>

@interface PANPebbleInterface : NSObject <PBPebbleCentralDelegate>

+ (PANPebbleInterface *)sharedStore;

@property (nonatomic, strong) PBWatch *targetWatch;

- (void)startWatchConnection;

- (void)sendWatchMessage:(NSString *)message;

@end
