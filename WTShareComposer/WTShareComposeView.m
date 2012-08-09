//
//  WTShareComposeView.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/2/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTShareComposeView.h"
#import <QuartzCore/QuartzCore.h>

@interface WTShareComposeView () <UITextViewDelegate>

@property UIView *navigationBarShadowView;

@end

@implementation WTShareComposeView

- (id)initWithNavigationItem:(UINavigationItem *)navigationItem
{
    self = [self initWithFrame:CGRectZero];
    
    if (self)
    {
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
        
        _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(frame), 44.0)];
        [self.navigationBar.layer setMasksToBounds:YES];
        [self addSubview:self.navigationBar];
        
        self.navigationBarShadowView = [[UIView alloc] initWithFrame:self.navigationBar.frame];
        [self.navigationBarShadowView setBackgroundColor:[UIColor clearColor]];
        [self.navigationBarShadowView setClipsToBounds:NO];
        [self.navigationBarShadowView.layer setMasksToBounds:NO];
        [self.navigationBarShadowView.layer setShadowPath:[UIBezierPath bezierPathWithRect:self.navigationBarShadowView.bounds].CGPath];
        [self.navigationBarShadowView.layer setShadowColor:[UIColor colorWithWhite:0.0 alpha:1.0].CGColor];
        [self.navigationBarShadowView.layer setShadowOffset:CGSizeMake(0.0, 1.0)];
        [self.navigationBarShadowView.layer setShadowRadius:5.0];
        [self.navigationBarShadowView.layer setShadowOpacity:0.8];
        [self.navigationBarShadowView.layer setShouldRasterize:YES];
        [self.navigationBarShadowView.layer setRasterizationScale:[[UIScreen mainScreen] scale]];
        [self.navigationBarShadowView setAlpha:0.0];
        [self insertSubview:self.navigationBarShadowView belowSubview:self.navigationBar];
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(_navigationBar.frame), CGRectGetWidth(frame), CGRectGetHeight(frame) - CGRectGetHeight(_navigationBar.frame))];
        [self.textView setContentInset:UIEdgeInsetsMake(0.0, 0.0, 10.0, 0.0)];
        [self.textView setScrollIndicatorInsets:UIEdgeInsetsMake(0.0, 0.0, 10.0, 0.0)];
        [self.textView setKeyboardType:UIKeyboardTypeTwitter];
        [self.textView setBackgroundColor:[UIColor clearColor]];
        [self.textView setShowsHorizontalScrollIndicator:NO];
        [self.textView setAlwaysBounceHorizontal:NO];
        [self.textView setFont:[UIFont systemFontOfSize:17.0]];
        [self.textView setDelegate:self];
        [self insertSubview:self.textView belowSubview:self.navigationBarShadowView];
        
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat alpha = (scrollView.contentOffset.y * 0.25);
    
    if (alpha < 0.0) alpha = 0.0;
    if (alpha > 1.0) alpha = 1.0;
    
    [self.navigationBarShadowView setAlpha:alpha];
}

@end
