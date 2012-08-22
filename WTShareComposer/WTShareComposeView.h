//
//  WTShareComposeView.h
//  WTShareComposer
//
//  Created by Joel Garrett on 8/2/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WTTextView;
@protocol WTShareTheme;

@interface WTShareComposeView : UIView

@property (nonatomic, readonly) UINavigationBar *navigationBar;
@property (nonatomic, readonly) WTTextView *textView;
@property (nonatomic, readonly) UILabel *locationLabel;
@property (nonatomic, readonly) UILabel *characterCountLabel;
@property (nonatomic, readonly) UIImageView *navigationBarShadowView;
@property (nonatomic, readonly) UIImageView *attachmentClipView;

@property (nonatomic, weak) id <WTShareTheme> theme;
@property (nonatomic, getter = isLocationSupportEnabled) BOOL locationSupportEnabled;
@property (nonatomic, getter = isCharacterCountSupportEnabled) BOOL characterCountSupportEnabled;

- (id)initWithNavigationItem:(UINavigationItem *)navigationItem theme:(id)theme;

- (void)showAnimated:(BOOL)animated;
- (void)showAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

- (void)hideAnimated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

@end
