//
//  WTShareComposeView.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/2/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTShareComposeView.h"
#import "WTTextView.h"
#import "WTThumbnailView.h"
#import "WTShareTheme.h"
#import <QuartzCore/QuartzCore.h>

#define degreesToRadians(x) (M_PI * x / 180.0f)

@interface WTShareComposeView ()

@property UIImageView *backgroundImageView;
@property NSArray *attachmentViews;
@property UIView *textMaskingView;

@end

@implementation WTShareComposeView

- (id)initWithNavigationItem:(UINavigationItem *)navigationItem theme:(id)theme
{
    NSParameterAssert(theme != nil);
    
    self = [self initWithFrame:CGRectZero];
    
    if (self)
    {
        self.theme = theme;
        
        [self addBackgroundImageView];
        [self addNavigationBar];
        [self addNavigationBarShadowView];
        [self addTextView];
        [self addLocationLabel];
        [self addCharacterCountLabel];
        [self addAttachmentClipView];
        
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
        self.attachmentViews = @[];
        
        [self.layer setShadowPath:[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:10.0].CGPath];
        [self.layer setShadowRadius:5.0];
        [self.layer setShadowOffset:CGSizeZero];
        [self.layer setShadowOpacity:0.8];
        [self.layer setShadowColor:[UIColor colorWithWhite:0.0 alpha:1.0].CGColor];
        
        [self hideAnimated:NO];
    }
    
    return self;
}


- (void)addBackgroundImageView
{
    CGRect background_frame = self.frame;
    background_frame.origin = CGPointZero;
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:background_frame];
    [self.backgroundImageView setImage:[self.theme shareCardBackgroundImage]];
    [self.backgroundImageView setBackgroundColor:[UIColor colorWithRed:0.956862745 green:0.956862745 blue:0.956862745 alpha:1.0]];
    [self.backgroundImageView setUserInteractionEnabled:YES];
    [self.backgroundImageView.layer setCornerRadius:10.0];
    [self.backgroundImageView.layer setMasksToBounds:YES];
    [self addSubview:self.backgroundImageView];
}


- (void)addNavigationBar
{
    _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.frame), 44.0)];
    [self.navigationBar.layer setMasksToBounds:YES];
    [self.navigationBar setOpaque:YES];
    [self.navigationBar setBackgroundColor:[UIColor whiteColor]];
    [self.navigationBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.backgroundImageView addSubview:self.navigationBar];
    [self.theme themeNavigationBar:self.navigationBar];
}


- (void)addNavigationBarShadowView
{
    _navigationBarShadowView = [[UIImageView alloc] initWithFrame:self.navigationBar.frame];
    [self.backgroundImageView insertSubview:self.navigationBarShadowView belowSubview:self.navigationBar];
    [self.theme themeNavigationBarShadowView:self.navigationBarShadowView];
}


- (void)addTextView
{
    CGRect text_frame = CGRectMake(0.0,
                                   CGRectGetMaxY(_navigationBar.frame) - 5.0,
                                   CGRectGetWidth(self.frame) - CGRectGetWidth(self.attachmentClipView.frame),
                                   CGRectGetHeight(self.frame) - CGRectGetHeight(_navigationBar.frame) + 5.0);
    
    _textMaskingView = [[UIView alloc] initWithFrame:text_frame];
    [_textMaskingView setClipsToBounds:YES];
    
    _textView = [[WTTextView alloc] initWithFrame:_textMaskingView.bounds];
    [self.textView setContentInset:UIEdgeInsetsMake(0.0, 0.0, 10.0, 0.0)];
    [self.textView setScrollIndicatorInsets:UIEdgeInsetsMake(0.0, 0.0, 10.0, 0.0)];
    [self.textView setKeyboardType:UIKeyboardTypeTwitter];
    [self.textView setBackgroundColor:[UIColor clearColor]];
    [self.textView setShowsHorizontalScrollIndicator:NO];
    [self.textView setAlwaysBounceHorizontal:NO];
    [self.textView setFont:[UIFont systemFontOfSize:17.0]];
    [_textMaskingView addSubview:self.textView];
    [self.backgroundImageView insertSubview:_textMaskingView belowSubview:self.navigationBarShadowView];
}


- (void)addLocationLabel
{
    CGRect location_frame = CGRectZero;
    location_frame.size = CGSizeMake(150.0, 34.0);
    location_frame.origin.x = 34.0;
    location_frame.origin.y = CGRectGetHeight(self.bounds) - CGRectGetHeight(location_frame);
    
    _locationLabel = [[UILabel alloc] initWithFrame:location_frame];
    [_locationLabel setBackgroundColor:[UIColor clearColor]];
    [_locationLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.0]];
    [_locationLabel setTextColor:[UIColor grayColor]];
    [_locationLabel setShadowColor:[UIColor colorWithWhite:0.8 alpha:0.7]];
    [_locationLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [_locationLabel setClipsToBounds:NO];
    
    UIImageView *locationArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_tweetsheet_location.png"]];
    
    CGRect arrow_frame = locationArrow.frame;
    arrow_frame.origin.x -= (CGRectGetWidth(arrow_frame) + 4);
    arrow_frame.origin.y = 8.0;
    
    [locationArrow setFrame:arrow_frame];
    [_locationLabel addSubview:locationArrow];
}


- (void)addCharacterCountLabel
{
    CGRect charcter_frame = CGRectZero;
    charcter_frame.size.height = 34.0f;
    charcter_frame.size.width = CGRectGetWidth(self.frame) * 0.4f;
    charcter_frame.origin.x = CGRectGetWidth(self.frame) - (CGRectGetWidth(charcter_frame) + 10.0);
    charcter_frame.origin.y = CGRectGetHeight(self.frame) - CGRectGetHeight(charcter_frame);
    
    _characterCountLabel = [[UILabel alloc] initWithFrame:charcter_frame];
    [_characterCountLabel setBackgroundColor:[UIColor clearColor]];
    [_characterCountLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
    [_characterCountLabel setTextAlignment:UITextAlignmentRight];
    [_characterCountLabel setTextColor:[UIColor grayColor]];
    [_characterCountLabel setShadowColor:[UIColor colorWithWhite:0.8 alpha:0.7]];
    [_characterCountLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
}


- (void)addAttachmentClipView
{   
    _attachmentClipView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.theme themeAttachmentClipView:self.attachmentClipView];
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


- (void)addAttachment:(UIImage *)image
{
    if (self.attachmentViews.count < 3)
    {
        if (![self.attachmentClipView superview])
        {
            [self addSubview:self.attachmentClipView];
            [self adjustTextViewFrame];
        }
        
        // Add thumbnail views
        CGRect thumb_frame = CGRectZero;
        thumb_frame.origin = self.attachmentClipView.frame.origin;
        thumb_frame.origin.x -= 15.0;
        thumb_frame.origin.y += 15.0;
        
        WTThumbnailView *thumbnailView = [[WTThumbnailView alloc] initWithFrame:thumb_frame];
        [thumbnailView setImage:image];
        [self insertSubview:thumbnailView aboveSubview:self.backgroundImageView];
        
        if (self.attachmentViews.count == 1)
            thumbnailView.transform = CGAffineTransformMakeRotation(degreesToRadians(-6.0f));
        else if (self.attachmentViews.count == 2)
            thumbnailView.transform = CGAffineTransformMakeRotation(degreesToRadians(9.0f));
        
        self.attachmentViews = [self.attachmentViews arrayByAddingObject:thumbnailView];
    }
}


- (void)addAttachments:(NSArray *)attachments
{
    for (UIImage *image in attachments)
        [self addAttachment:image];
}


- (void)removeAllAttachments
{
    [self.attachmentClipView removeFromSuperview];
    [self adjustTextViewFrame];
    
    [self.attachmentViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.attachmentViews = @[];
}


- (void)setLocationSupportEnabled:(BOOL)locationSupportEnabled
{
    _locationSupportEnabled = locationSupportEnabled;
    
    if (_locationSupportEnabled)
    {
        [self insertSubview:self.locationLabel aboveSubview:_textMaskingView];
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
    CGRect mask_frame = CGRectZero;
    
    if (![self isCharacterCountSupportEnabled] && ![self isLocationSupportEnabled])
    {
        mask_frame = CGRectMake(0.0,
                                CGRectGetMaxY(_navigationBar.frame) - 5.0,
                                CGRectGetWidth(self.frame),
                                CGRectGetHeight(self.frame) - CGRectGetHeight(_navigationBar.frame) + 5.0);
        
    }
    
    else
    {
        mask_frame = CGRectMake(0.0,
                                CGRectGetMaxY(_navigationBar.frame) - 5.0,
                                CGRectGetWidth(self.frame),
                                CGRectGetHeight(self.frame) - CGRectGetHeight(_navigationBar.frame) - 30.0f + 5.0);
        
    }
    
    [_textMaskingView setFrame:mask_frame];
    text_frame = _textMaskingView.bounds;
    
    if (self.attachmentClipView.superview)
        text_frame.size.width -=  CGRectGetWidth(self.attachmentClipView.frame);
    
    [_textView setFrame:text_frame];
}

@end
