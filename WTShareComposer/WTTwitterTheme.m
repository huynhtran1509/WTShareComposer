//
//  WTTwitterTheme.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/21/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTTwitterTheme.h"

@implementation WTTwitterTheme

- (void)themeNavigationBarShadowView:(UIImageView *)shadowView
{
    [shadowView setContentMode:UIViewContentModeBottom];
    [shadowView setImage:[UIImage imageNamed:@"DETweetCardHeaderLine.png"]];
    [shadowView setFrame:CGRectInset(shadowView.frame, 0.0, -2.0)];
}


- (WTShareThemeDisplayNavigationBarDropShadow)shouldDisplayNavigationBarDropShadow
{
    return WTShareThemeDisplayNavigationBarDropShadowAlways;
}

@end
