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
    return 140;
}

- (NSUInteger)imageAttachmentsLimit
{
    return 1;
}


- (NSUInteger)URLAttachmentsLimit
{
    return 1;
}

- (NSUInteger)characterCountForURLs:(NSArray *)urls
{
    return ([urls count] * 20);
}


- (NSUInteger)characterCountForImages:(NSArray *)images
{
    return ([images count] * 20);
}

- (void)postText:(NSString *)text withImages:(NSArray *)images URLs:(NSArray *)urls
{
    [self.delegate postSucceeded:self];
}

@end
