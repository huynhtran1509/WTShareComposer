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

- (NSUInteger)characterLimit
{
    return 0;
}

- (void)postText:(NSString *)text withImages:(NSArray *)images
{
    
}


@end
