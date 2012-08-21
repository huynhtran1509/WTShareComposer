//
//  WTFoursquareService.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/5/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTFoursquareService.h"

@implementation WTFoursquareService

+ (BOOL)canShare
{
    return YES;
}

- (NSString *)title
{
    return @"Foursquare";
}


- (void)postText:(NSString *)text withImages:(NSArray *)images
{
    
}


- (void)postText:(NSString *)text withImages:(NSArray *)images location:(CLLocation *)location
{
    
}

@end
