//
//  PANPredictionsViewController.m
//  Pebble Adventure Navigation
//
//  Created by Yan Shcherbakov on 2013-07-01.
//  Copyright (c) 2013 One Shot Apps. All rights reserved.
//

#import "PANPredictionsViewController.h"
#import "PANPredictions.h"
#import "PANPrediction.h"
#import "PANGoogleInterface.h"
#import "PANRouteViewController.h"

@implementation PANPredictionsViewController

@synthesize pvcDestination, pvcLocation;

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self initWithStyle:style destination:@"Toronto" location:@""];
}

- (id)initWithStyle:(UITableViewStyle)style destination:(NSString *)d location:(NSString *)l
{
    self = [super initWithStyle:style];
    
    if (self) {
        [self setPvcLocation:l];
        [self setPvcDestination:d];
        [self fetchPredictions];
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[pvcPredictions predictions] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    PANPrediction *prediction = [[pvcPredictions predictions] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@", prediction]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PANRouteViewController *rtvc = [[PANRouteViewController alloc] initWithDestination:[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text] location:[self pvcLocation]];
    
    [[self navigationController] pushViewController:rtvc animated:YES];
}

- (void)viewDidLoad
{
}

- (void)fetchPredictions
{
    void(^completionBlock)(PANPredictions *obj, NSError *err) = ^(PANPredictions *obj, NSError *err) {
        if (!err) {
            pvcPredictions = obj;
            
            NSLog(@"%@", obj);
            
            [[self tableView] reloadData];
        } else {
            NSString *errorString = [[NSString alloc] initWithFormat:@"Failed to get data: %@", [err localizedDescription]];
            
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [av show];
        }
    };
    
    //TODO: Create Location Manager and pass the location as a string.
    
    [[PANGoogleInterface sharedStore] fetchPredictionWithCompletion:completionBlock input:[self pvcDestination] location:[self pvcLocation]];
}

@end
