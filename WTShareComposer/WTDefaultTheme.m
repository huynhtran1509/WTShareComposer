//
//  WTTwitterTheme.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/2/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTDefaultTheme.h"
#import <QuartzCore/QuartzCore.h>


@implementation WTDefaultTheme

- (UIImage *)shareCardBackgroundImage
{
    return [UIImage imageNamed:@"DETweetCardBackground.png"];
}


- (UIImage *)attachmentPlaceholderImage
{
    return nil;
}


- (UIImage *)URLAttachmentImage
{
    return [UIImage imageNamed:@"DETweetURLAttachment.png"];
}


- (UIImage *)portraitImageForButtonOfType:(WTShareThemeBarButtonItemType)type
{
    switch (type)
    {
        case WTShareThemeBarButtonItemTypeCancel:
            return [[UIImage imageNamed:@"DETweetCancelButtonPortrait.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:14];
            break;
        
        case WTShareThemeBarButtonItemTypeSend:
            return [[UIImage imageNamed:@"DETweetSendButtonPortrait.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:14];
            break;
            
        default:
            return nil;
            break;
    }
}

- (UIImage *)landscapeImageForButtonOfType:(WTShareThemeBarButtonItemType)type
{
    switch (type)
    {
        case WTShareThemeBarButtonItemTypeCancel:
            return [[UIImage imageNamed:@"DETweetCancelButtonLandscape.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:15];
            break;
            
        case WTShareThemeBarButtonItemTypeSend:
            return [[UIImage imageNamed:@"DETweetSendButtonLandscape.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:15];
            break;
            
        default:
            return nil;
            break;
    }
}


- (void)themeBarButtonItem:(UIBarButtonItem *)buttonItem ofType:(WTShareThemeBarButtonItemType)type
{
    [buttonItem setBackgroundImage:[self portraitImageForButtonOfType:type]
                          forState:UIControlStateNormal
                        barMetrics:UIBarMetricsDefault];
    
    [buttonItem setBackgroundImage:[self landscapeImageForButtonOfType:type]
                          forState:UIControlStateNormal
                        barMetrics:UIBarMetricsLandscapePhone];
    
      
    switch (type)
    {
        case WTShareThemeBarButtonItemTypeCancel:
        {
            NSDictionary *attributes = @{
            UITextAttributeTextColor : [UIColor grayColor],
            UITextAttributeTextShadowColor : [UIColor whiteColor],
            UITextAttributeTextShadowOffset : [NSValue valueWithCGSize:CGSizeMake(0.0, 1.0)]
            };
            
            [buttonItem setTitleTextAttributes:attributes
                                      forState:UIControlStateNormal];
            
            attributes = @{
            UITextAttributeTextColor : [UIColor whiteColor],
            UITextAttributeTextShadowColor : [UIColor clearColor],
            };
            
            [buttonItem setTitleTextAttributes:attributes
                                      forState:UIControlStateHighlighted];
            break;
        }
            
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
    UITextAttributeTextShadowOffset : [NSValue valueWithCGSize:CGSizeMake(0.0, -1.0)]
    };
    
    [navigationBar setTitleTextAttributes:attributes];
}


- (void)themeNavigationBarShadowView:(UIImageView *)shadowView
{   
    [shadowView setBackgroundColor:[UIColor clearColor]];
    [shadowView setClipsToBounds:NO];
    [shadowView.layer setMasksToBounds:NO];
    [shadowView.layer setShadowPath:[UIBezierPath bezierPathWithRect:shadowView.bounds].CGPath];
    [shadowView.layer setShadowColor:[UIColor colorWithWhite:0.0 alpha:1.0].CGColor];
    [shadowView.layer setShadowOffset:CGSizeMake(0.0, 1.0)];
    [shadowView.layer setShadowRadius:5.0];
    [shadowView.layer setShadowOpacity:0.8];
    [shadowView.layer setShouldRasterize:YES];
    [shadowView.layer setRasterizationScale:[[UIScreen mainScreen] scale]];
}


- (WTShareThemeDisplayNavigationBarDropShadow)shouldDisplayNavigationBarDropShadow
{
    return WTShareThemeDisplayNavigationBarDropShadowAuto;
}


- (void)themeAttachmentClipView:(UIImageView *)attachmentClipView
{
    [attachmentClipView setImage:[UIImage imageNamed:@"DETweetPaperClip.png"]];
    
    CGRect attachment_frame = CGRectZero;
    attachment_frame.size = attachmentClipView.image.size;
    attachment_frame.origin = CGPointMake(231.0f, 45.0f);
    [attachmentClipView setFrame:attachment_frame];
}

@end
