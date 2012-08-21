//
//  WTFacebookTheme.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/10/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTFacebookTheme.h"

@implementation WTFacebookTheme

- (void)themeNavigationBar:(UINavigationBar *)navigationBar
{
    [navigationBar setTintColor:[UIColor colorWithRed:(63.0 / 255.f) green:(77.0 / 255.f) blue:(117.0 / 255.f) alpha:1.0]];
}


- (void)themeBarButtonItem:(UIBarButtonItem *)buttonItem ofType:(WTShareThemeBarButtonItemType)type
{
    
}


- (WTShareThemeDisplayNavigationBarDropShadow)shouldDisplayNavigationBarDropShadow
{
    return WTShareThemeDisplayNavigationBarDropShadowAlways;
}

@end
