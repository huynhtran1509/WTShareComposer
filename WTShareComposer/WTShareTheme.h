//
//  WTShareTheme.h
//  WTShareComposer
//
//  Created by Joel Garrett on 8/2/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum WTShareThemeBarButtonItemType : NSUInteger
{
    WTShareThemeBarButtonItemTypeSend,
    WTShareThemeBarButtonItemTypeCancel,
    WTShareThemeBarButtonItemTypeLocation,
} WTShareThemeBarButtonItemType;

typedef enum WTShareThemeLabelType : NSUInteger
{
    WTShareThemeLabelTypeTitle,
} WTShareThemeLabelType;

typedef enum WTShareThemeDisplayNavigationBarDropShadow : NSUInteger
{
    WTShareThemeDisplayNavigationBarDropShadowNever,
    WTShareThemeDisplayNavigationBarDropShadowAlways,
    WTShareThemeDisplayNavigationBarDropShadowAuto,
} WTShareThemeDisplayNavigationBarDropShadow;

@protocol WTShareTheme <NSObject>

- (UIImage *)shareCardBackgroundImage;

- (void)themeBarButtonItem:(UIBarButtonItem *)buttonItem ofType:(WTShareThemeBarButtonItemType)type;
- (void)themeLabel:(UILabel *)label ofType:(WTShareThemeLabelType)type;

- (void)themeNavigationBar:(UINavigationBar *)navigationBar;
- (void)themeNavigationBarShadowView:(UIImageView *)shadowView;
- (WTShareThemeDisplayNavigationBarDropShadow)shouldDisplayNavigationBarDropShadow;

- (void)themeAttachmentClipView:(UIImageView *)attachmentClipView;

@end
