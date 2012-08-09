//
//  WTShareComposeView.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/2/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTShareComposeView.h"
#import <QuartzCore/QuartzCore.h>

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
        [self addSubview:self.navigationBar];
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(_navigationBar.frame), CGRectGetWidth(frame), CGRectGetHeight(frame) - CGRectGetHeight(_navigationBar.frame))];
        [self.textView setContentInset:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)];
        [self.textView setKeyboardType:UIKeyboardTypeTwitter];
        [self.textView setBackgroundColor:[UIColor clearColor]];
        [self.textView setShowsHorizontalScrollIndicator:NO];
        [self addSubview:self.textView];
        
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
