//
//  WTTwitterTheme.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/2/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTDefaultTheme.h"

@implementation WTDefaultTheme

- (UIImage *)shareCardBackgroundImage
{
    return [UIImage imageNamed:@"DETweetCardBackground.png"];
}

- (UIImage *)portraitImageForButtonOfType:(WTShareThemeButtonType)type
{
    switch (type)
    {
        case WTShareThemeButtonTypeCancel:
            return [[UIImage imageNamed:@"DETweetCancelButtonPortrait.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:14];
            break;
        
        case WTShareThemeButtonTypeSend:
            return [[UIImage imageNamed:@"DETweetSendButtonPortrait.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:14];
            break;
            
        default:
            return nil;
            break;
    }
}

- (UIImage *)landscapeImageForButtonOfType:(WTShareThemeButtonType)type
{
    switch (type)
    {
        case WTShareThemeButtonTypeCancel:
            return [[UIImage imageNamed:@"DETweetCancelButtonLandscape.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:15];
            break;
            
        case WTShareThemeButtonTypeSend:
            return [[UIImage imageNamed:@"DETweetSendButtonLandscape.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:15];
            break;
            
        default:
            return nil;
            break;
    }
}


- (void)themeButton:(UIButton *)button ofType:(WTShareThemeButtonType)type
{
    [button setBackgroundImage:[self portraitImageForButtonOfType:type]
                      forState:UIControlStateNormal];
    
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
    
    switch (type)
    {
        case WTShareThemeButtonTypeCancel:
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateHighlighted];
            [button.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
            break;
            
        case WTShareThemeButtonTypeSend:
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateHighlighted];
            [button.titleLabel setShadowOffset:CGSizeMake(0.0, -1.0)];
            break;
            
        default:
            break;
    }
}


- (void)themeLabel:(UILabel *)label ofType:(WTShareThemeLabelType)type
{
    
}


- (void)themeNavigationBar:(UINavigationBar *)navigationBar
{
    [navigationBar setTranslucent:YES];
    [navigationBar setBackgroundImage:[self shareCardBackgroundImage]
                        forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *attributes = @{
    UITextAttributeTextColor : [UIColor grayColor],
    UITextAttributeTextShadowColor : [UIColor whiteColor],
    UITextAttributeTextShadowOffset : [NSValue valueWithCGSize:CGSizeMake(1.0, -1.0)]
    };
    
    [navigationBar setTitleTextAttributes:attributes];
}

@end
