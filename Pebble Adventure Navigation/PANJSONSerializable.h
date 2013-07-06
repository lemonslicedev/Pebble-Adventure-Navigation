//
//  PANJSONSerializable.h
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PANJSONSerializable <NSObject>

- (void)readFromJSONDictionary:(NSDictionary *)d;

@end
