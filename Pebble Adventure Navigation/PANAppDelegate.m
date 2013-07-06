//
//  PANAppDelegate.m
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "PANAppDelegate.h"
#import "PANRootViewController.h"
#import <PebbleKit/PebbleKit.h>

@implementation PANAppDelegate
{
    PBWatch *targetWatch;
}

- (void)setTargetWatch:(PBWatch *)watch
{
    targetWatch = watch;
    
    [watch appMessagesGetIsSupported:^(PBWatch *watch, BOOL isAppMessagesSupported) {
        if (isAppMessagesSupported) {
            uint8_t bytes[] = { 0x51, 0x54, 0xcd, 0x9d, 0x40, 0x9c, 0x47, 0xc9, 0xb1, 0x15, 0x84, 0x90, 0xe4, 0x44, 0x72, 0x7e };
            
            NSData *uuid = [NSData dataWithBytes:bytes length:sizeof(bytes)];
            
            [watch appMessagesSetUUID:uuid];
            [watch appMessagesLaunch:^(PBWatch *watch, NSError *error) {
                NSLog(@"Launch");
            }];
            
            
            NSMutableArray *gibs = [[NSMutableArray alloc] init];
            NSMutableArray *gibKeys = [[NSMutableArray alloc] init];
            
            [gibs addObject:@"Gibberish"];
            NSNumber *iconKey = @(0);
            [gibKeys addObject:iconKey];
            
            NSDictionary *gibberishDict = [[NSDictionary alloc] initWithObjects:gibs forKeys:gibKeys];
            
//            NSDictionary *update = @{ iconKey:@"Whatever",
//                                      temperatureKey:@"Duh" };
            [targetWatch appMessagesPushUpdate:gibberishDict onSent:^(PBWatch *watch, NSDictionary *update, NSError *error) {
                NSString *message = error ? [error localizedDescription] : @"Update sent!";
                [[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }];
            
            NSString *message = [NSString stringWithFormat:@"Yay! %@ supports AppMessages :D", [watch name]];
            [[[UIAlertView alloc] initWithTitle:@"Connected!" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        } else {
            NSString *message = [NSString stringWithFormat:@"Blegh... %@ does NOT support AppMessages :'(", [watch name]];
            [[[UIAlertView alloc] initWithTitle:@"Connected..." message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    PANRootViewController *rv = [[PANRootViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rv];
    
    [[self window] setRootViewController:nav];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[PBPebbleCentral defaultCentral] setDelegate:self];
    [self setTargetWatch:[[PBPebbleCentral defaultCentral] lastConnectedWatch]];
    return YES;
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

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
