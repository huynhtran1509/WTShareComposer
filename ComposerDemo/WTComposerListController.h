//
//  WTComposerListController.h
//  WTShareComposer
//
//  Created by Joel Garrett on 8/5/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum WTComposerDemo : NSUInteger
{
    WTComposerDemoTwitter,
    WTComposerDemoFacebook,
    WTComposerDemoFoursquare,
    WTComposerDemoCount,
} WTComposerDemo;

@interface WTComposerListController : UITableViewController

@end
