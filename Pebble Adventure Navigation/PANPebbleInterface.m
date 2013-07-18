//
//  PANPebbleInterface.m
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-08.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "PANPebbleInterface.h"

@implementation PANPebbleInterface

@synthesize targetWatch;

+ (PANPebbleInterface *)sharedStore
{
    static PANPebbleInterface *watchInterface = nil;
    
    if (!watchInterface) {
        watchInterface = [[PANPebbleInterface alloc] init];
    }
    
    return watchInterface;
}

- (void)startWatchConnection
{
    [[PBPebbleCentral defaultCentral] setDelegate:self];
    [self setTargetWatch:[[PBPebbleCentral defaultCentral] lastConnectedWatch]];
}

- (void)setTargetWatch:(PBWatch *)watch
{
    targetWatch = watch;
    
    uint8_t bytes[] = { 0x51, 0x54, 0xcd, 0x9d, 0x40, 0x9c, 0x47, 0xc9, 0xb1, 0x15, 0x84, 0x90, 0xe4, 0x44, 0x72, 0x7e };
    
    NSData *uuid = [NSData dataWithBytes:bytes length:sizeof(bytes)];
    
    [watch appMessagesSetUUID:uuid];
    
    [watch appMessagesGetIsSupported:^(PBWatch *watch, BOOL isAppMessagesSupported) {
        if (isAppMessagesSupported) {
            [watch appMessagesLaunch:^(PBWatch *watch, NSError *error) {
                NSLog(@"Launch");
            }];
            
            
            
            NSString *message = [NSString stringWithFormat:@"Yay! %@ supports AppMessages :D", [watch name]];
            [[[UIAlertView alloc] initWithTitle:@"Connected!" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        } else {
            NSString *message = [NSString stringWithFormat:@"Blegh... %@ does NOT support AppMessages :'(", [watch name]];
            [[[UIAlertView alloc] initWithTitle:@"Connected..." message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }];
}

- (void)pebbleCentral:(PBPebbleCentral *)central watchDidConnect:(PBWatch *)watch isNew:(BOOL)isNew
{
    [self setTargetWatch:watch];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Connected" message:[watch name] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [av show];
}

- (void)pebbleCentral:(PBPebbleCentral *)central watchDidDisconnect:(PBWatch *)watch
{
    [[[UIAlertView alloc] initWithTitle:@"Disconnected!" message:[watch name] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
    [self setTargetWatch:nil];
}

- (void)sendWatchMessage:(NSString *)string
{
    NSLog(@"Method received the string: %@", string);
    
    NSMutableArray *gibs = [[NSMutableArray alloc] init];
    NSMutableArray *gibKeys = [[NSMutableArray alloc] init];
    
    NSNumber *iconKey = @(0);
    [gibKeys addObject:iconKey];
    [gibs addObject:string];
    
    NSDictionary *gibberishDict = [[NSDictionary alloc] initWithObjects:gibs forKeys:gibKeys];
    
    //            NSDictionary *update = @{ iconKey:@"Whatever",
    //                                      temperatureKey:@"Duh" };
    [targetWatch appMessagesPushUpdate:gibberishDict onSent:^(PBWatch *watch, NSDictionary *gibberishDict, NSError *error) {
        NSString *message = error ? [error localizedDescription] : @"Update sent!";
        [[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

@end
