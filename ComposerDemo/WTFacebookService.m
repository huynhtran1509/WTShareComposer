//
//  WTFacebookService.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/5/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTFacebookService.h"

@implementation WTFacebookService

+ (BOOL)canShare
{
    return YES;
}

- (NSString *)title
{
    return @"Facebook";
}

- (void)postText:(NSString *)text withImages:(NSArray *)images URLs:(NSArray *)urls
{
    [self.delegate postFailed:self];
}

@end
