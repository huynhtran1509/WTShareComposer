//
//  WTShareComposeView.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/2/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTShareComposeView.h"
#import "WTTextView.h"
#import "WTShareTheme.h"
#import <QuartzCore/QuartzCore.h>

@interface WTShareComposeView ()

@end

@implementation WTShareComposeView

- (id)initWithNavigationItem:(UINavigationItem *)navigationItem theme:(id)theme
{
    NSParameterAssert(theme != nil);
    
    self = [self initWithFrame:CGRectZero];
    
    if (self)
    {
        self.theme = theme;
        [self.theme themeNavigationBarShadowView:self.navigationBarShadowView];
        
        if ([self.theme shouldDisplayNavigationBarDropShadow] != WTShareThemeDisplayNavigationBarDropShadowAlways)
            [self.navigationBarShadowView setAlpha:0.0];
        
        if (navigationItem)
            [self.navigationBar setItems:@[ navigationItem ]];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    frame.size = CGSizeMake(304.0, 189.0);
    frame.origin = CGPointMake(8.0, 25.0);
    
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Initialization code
        self.layer.cornerRadius = 10.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor yellowColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(frame), 44.0)];
        [self.navigationBar.layer setMasksToBounds:YES];
        [self.navigationBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [self addSubview:self.navigationBar];
        
        _navigationBarShadowView = [[UIImageView alloc] initWithFrame:self.navigationBar.frame];
        [self insertSubview:self.navigationBarShadowView belowSubview:self.navigationBar];
        
        _textView = [[WTTextView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(_navigationBar.frame), CGRectGetWidth(frame), CGRectGetHeight(frame) - CGRectGetHeight(_navigationBar.frame))];
        [self.textView setContentInset:UIEdgeInsetsMake(0.0, 0.0, 10.0, 0.0)];
        [self.textView setScrollIndicatorInsets:UIEdgeInsetsMake(0.0, 0.0, 10.0, 0.0)];
        [self.textView setKeyboardType:UIKeyboardTypeTwitter];
        [self.textView setBackgroundColor:[UIColor clearColor]];
        [self.textView setShowsHorizontalScrollIndicator:NO];
        [self.textView setAlwaysBounceHorizontal:NO];
        [self.textView setFont:[UIFont systemFontOfSize:17.0]];
        [self insertSubview:self.textView belowSubview:self.navigationBarShadowView];
        
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 100.0, CGRectGetWidth(frame) * 0.5f, 30.0)];
        [_locationLabel setBackgroundColor:[UIColor redColor]];
        
        CGRect charcter_frame = CGRectZero;
        charcter_frame.size.height = 30.0f;
        charcter_frame.size.width = CGRectGetWidth(frame) * 0.4f;
        charcter_frame.origin.x = CGRectGetWidth(frame) - (CGRectGetWidth(charcter_frame) + 10.0);
        charcter_frame.origin.y = CGRectGetHeight(frame) - CGRectGetHeight(charcter_frame);
        
        _characterCountLabel = [[UILabel alloc] initWithFrame:charcter_frame];
        [_characterCountLabel setBackgroundColor:[UIColor clearColor]];
        [_characterCountLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
        [_characterCountLabel setTextAlignment:UITextAlignmentRight];
        [_characterCountLabel setTextColor:[UIColor grayColor]];
        [_characterCountLabel setShadowColor:[UIColor colorWithWhite:0.8 alpha:0.7]];
        [_characterCountLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
        
        [self hideAnimated:NO];
    }
    
    return self;
}


- (void)showAnimated:(BOOL)animated
{
    [self showAnimated:animated completion:NULL];
}


- (void)showAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    CGFloat duration = animated ? 0.3 : 0.0;
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:completion];
    
    [self.textView becomeFirstResponder];
}


- (void)hideAnimated:(BOOL)animated
{
    [self hideAnimated:animated completion:NULL];
}


- (void)hideAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    CGFloat duration = animated ? 0.3 : 0.0;
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGFloat offset = -CGRectGetMaxY(self.frame);
        self.transform = CGAffineTransformMakeTranslation(0.0, offset);
    } completion:completion];
    
    [self.textView resignFirstResponder];
}


- (void)setLocationSupportEnabled:(BOOL)locationSupportEnabled
{
    _locationSupportEnabled = locationSupportEnabled;
    
    if (_locationSupportEnabled)
    {
        [self addSubview:self.locationLabel];
    }
    
    else
    {   
        [self.locationLabel removeFromSuperview];
    }
    
    [self adjustTextViewFrame];
}


- (void)setCharacterCountSupportEnabled:(BOOL)characterCountSupportEnabled
{
    _characterCountSupportEnabled = characterCountSupportEnabled;
    
    if (_characterCountSupportEnabled)
    {
        [self addSubview:self.characterCountLabel];
    }
    
    else
    {
        [self.characterCountLabel removeFromSuperview];
    }
    
    [self adjustTextViewFrame];
}


- (void)adjustTextViewFrame
{
    CGRect text_frame = CGRectZero;
    
    if (![self isCharacterCountSupportEnabled] && ![self isLocationSupportEnabled])
    {
        text_frame = CGRectMake(0.0,
                                CGRectGetMaxY(_navigationBar.frame),
                                CGRectGetWidth(self.frame),
                                CGRectGetHeight(self.frame) - CGRectGetHeight(_navigationBar.frame));
        
    }
    
    else
    {
        text_frame = CGRectMake(0.0,
                                CGRectGetMaxY(_navigationBar.frame),
                                CGRectGetWidth(self.frame),
                                CGRectGetHeight(self.frame) - CGRectGetHeight(_navigationBar.frame) - 30.0f);
        
    }
    
    [_textView setFrame:text_frame];
}

@end
