//
//  WTFourSquareTheme.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/10/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTFourSquareTheme.h"

@implementation WTFourSquareTheme

- (UIImage *)shareCardBackgroundImage
{
    return nil;
}


- (void)themeNavigationBar:(UINavigationBar *)navigationBar
{
    UIImage *backgroundImage = [[UIImage imageNamed:@"nav_bg_foursquare.png"] stretchableImageWithLeftCapWidth:6 topCapHeight:0];
    [navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [navigationBar setTintColor:[UIColor colorWithRed:(111.0 / 255.f) green:(168.0 / 255.f) blue:(212.0 / 255.f) alpha:1.0]];
}


- (void)themeBarButtonItem:(UIBarButtonItem *)buttonItem ofType:(WTShareThemeBarButtonItemType)type
{
    
}


- (WTShareThemeDisplayNavigationBarDropShadow)shouldDisplayNavigationBarDropShadow
{
    return WTShareThemeDisplayNavigationBarDropShadowAlways;
}

@end
