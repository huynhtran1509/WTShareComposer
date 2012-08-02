//
//  WTShareTheme.h
//  WTShareComposer
//
//  Created by Joel Garrett on 8/2/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum WTShareThemeButtonType : NSUInteger
{
    WTShareThemeButtonTypeSend,
    WTShareThemeButtonTypeCancel,
    WTShareThemeButtonTypeLocation,
} WTShareThemeButtonType;

typedef enum WTShareThemeLabelType : NSUInteger
{
    WTShareThemeLabelTypeTitle,
} WTShareThemeLabelType;

@protocol WTShareTheme <NSObject>

- (void)themeButton:(UIButton *)button ofType:(WTShareThemeButtonType)type;
- (void)themeLabel:(UILabel *)label ofType:(WTShareThemeLabelType)type;

@end
