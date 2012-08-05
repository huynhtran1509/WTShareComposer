//
//  WTTwitterService.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/5/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTTwitterService.h"

@implementation WTTwitterService

+ (BOOL)canShare
{
    return YES;
}

- (NSString *)title
{
    return @"Twitter";
}

- (NSUInteger)characterLimit
{
    return 0;
}

- (void)postText:(NSString *)text withImages:(NSArray *)images
{
    
}

@end
