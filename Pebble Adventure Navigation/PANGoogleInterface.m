//
//  PANGoogleInterface.m
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "PANGoogleInterface.h"
#import "PANPredictions.h"
#import "PANDirections.h"
#import "PANConnection.h"

@implementation PANGoogleInterface

@synthesize apiKey;

+ (PANGoogleInterface *)sharedStore
{
    static PANGoogleInterface *interface = nil;
    
    if (!interface) {
        interface = [[PANGoogleInterface alloc] init];
        [interface setApiKey:@"AIzaSyA0cpJ5DfLniRaQ0eKxw8jVZunPuVJf6cE"];
    }
    
    return interface;
}

- (void)fetchPredictionWithCompletion:(void (^)(PANPredictions *obj, NSError *err))block input:(NSString *)input location:(NSString *)location
{
    //TODO: Need to get base url string from plist and separate the uri variables.
    
    NSString *encodedInput = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)input, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&location=%@&radius=500&sensor=true&key=%@", encodedInput, location, apiKey];
    
    NSLog(@"[Predictions urlString]: %@", urlString);
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    PANPredictions *predictionsRootObject = [[PANPredictions alloc] init];
    
    PANConnection *predictionsConnection = [[PANConnection alloc] initWithRequest:request];
    
    [predictionsConnection setCompletionBlock:block];
    [predictionsConnection setJsonRootObject:predictionsRootObject];
    [predictionsConnection start];
}

- (void)fetchDirectionsWithCompletion:(void (^)(PANDirections *obj, NSError *err))block origin:(NSString *)origin destination:(NSString *)destination
{
    
    NSString *encodedDestination = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)destination, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&sensor=false", origin, encodedDestination];
    
    NSLog(@"[Directions urlString]: %@", urlString);
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    PANDirections *directionsRootObject = [[PANDirections alloc] init];
    
    PANConnection *directionsConnection = [[PANConnection alloc] initWithRequest:request];
    
    [directionsConnection setCompletionBlock:block];
    [directionsConnection setJsonRootObject:directionsRootObject];
    [directionsConnection start];
    
}

@end
