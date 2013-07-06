//
//  PANConnection.m
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "PANConnection.h"

static NSMutableArray *sharedConnectionList = nil;

@implementation PANConnection

@synthesize request, completionBlock, jsonRootObject;

- (id)initWithRequest:(NSURLRequest *)req
{
    self = [super init];
    
    if (self) {
        [self setRequest:req];
    }
    
    return self;
}

- (void)start
{
    container = [[NSMutableData alloc] init];
    
    internalConnection = [[NSURLConnection alloc] initWithRequest:[self request] delegate:self startImmediately:YES];
    
    if (!sharedConnectionList) {
        sharedConnectionList = [[NSMutableArray alloc] init];
        [sharedConnectionList addObject:self];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [container appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if ([self jsonRootObject]) {
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:container options:0 error:nil];
        
        [[self jsonRootObject] readFromJSONDictionary:jsonDictionary];
    }
    
    if ([self completionBlock]) {
        [self completionBlock](jsonRootObject, nil);
    }
    
    [sharedConnectionList removeObject:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([self completionBlock]) {
        [self completionBlock](nil, error);
    }
    
    [sharedConnectionList removeObject:self];
}

@end
