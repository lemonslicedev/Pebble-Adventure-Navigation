//
//  PANPrediction.h
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PANJSONSerializable.h"

@interface PANPrediction : NSObject <PANJSONSerializable>

@property (nonatomic, strong) NSString *predictionText;

@end
