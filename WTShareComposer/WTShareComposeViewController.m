//
//  WTShareComposeViewController.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/2/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTShareComposeViewController.h"
#import "WTShareComposeView.h"
#import "WTDefaultTheme.h"

#import <QuartzCore/QuartzCore.h>

@implementation UIViewController (WTShareComposeViewControllerPresentation)

- (void)presentModalShareComposeViewControllerAnimated:(WTShareComposeViewController *)viewController
{
    [self presentModalViewController:viewController animated:NO];
}

@end

@interface WTShareComposeViewController ()

@end

@implementation WTShareComposeViewController
{
    UIImageView *_backgroundImageView;
    UIStatusBarStyle _initialStatusBarStyle;
    
    WTShareComposeView *_composeView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
    }
    
    return self;
}


- (id)initWithService:(id<WTShareService>)service theme:(id<WTShareTheme>)theme
{
    NSParameterAssert(service != nil);
    
    self = [self initWithNibName:nil bundle:nil];
    
    if (self)
    {
        // Custom initialization
        _service = service;
        _theme = theme;
        
        if (!_theme)
            _theme = [[WTDefaultTheme alloc] init];
        
        self.title = [self.service title];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 60.0, 30.0)];
        [cancelButton setTitle:NSLocalizedString(@"Cancel", @"Cancel button title") forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonPressed:event:) forControlEvents:UIControlEventTouchUpInside];
        [self.theme themeButton:cancelButton ofType:WTShareThemeButtonTypeCancel];
        
        UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 60.0, 30.0)];
        [sendButton setTitle:NSLocalizedString(@"Send", @"Send button title") forState:UIControlStateNormal];
        [sendButton addTarget:self action:@selector(sendButtonPressed:event:) forControlEvents:UIControlEventTouchUpInside];
        [self.theme themeButton:sendButton ofType:WTShareThemeButtonTypeSend];
        
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    _composeView = [[WTShareComposeView alloc] initWithNavigationItem:self.navigationItem];
    [_composeView setBackgroundColor:[UIColor colorWithPatternImage:[self.theme shareCardBackgroundImage]]];
    [self.theme themeNavigationBar:_composeView.navigationBar];
    [self.view addSubview:_composeView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Take a snapshot of the current view, and make that our background after our view animates into place.
    // This only works if our orientation is the same as the presenting view.
    // If they don't match, just display the gray background.
    _initialStatusBarStyle = [[UIApplication sharedApplication] statusBarStyle];
    
    if (self.interfaceOrientation == self.presentingViewController.interfaceOrientation)
    {
        UIImage *backgroundImage = [self captureScreen];
        _backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    }
    else
    {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.presentingViewController.view.bounds];
    }
    
    _backgroundImageView.autoresizingMask = self.view.autoresizingMask;
    _backgroundImageView.alpha = 0.0f;
    _backgroundImageView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view insertSubview:_backgroundImageView atIndex:0];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.view.backgroundColor = [UIColor blackColor];
    _backgroundImageView.alpha = 1.0f;
    
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundImageView.alpha = 0.1;
    }];
    
    [_composeView showAnimated:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque
                                                animated:YES];
}


- (UIImage *)captureScreen
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    CGRect rect = [keyWindow bounds];
    
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (![[UIApplication sharedApplication] isStatusBarHidden])
    {
        CGFloat statusBarOffset = -20.0f;
        
        if (UIInterfaceOrientationIsLandscape(orientation))
            CGContextTranslateCTM(context,statusBarOffset, 0.0f);
        else
            CGContextTranslateCTM(context, 0.0f, statusBarOffset);
    }
    
    [keyWindow.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageOrientation imageOrientation;
    
    switch (orientation)
    {
        case UIInterfaceOrientationLandscapeLeft:
            imageOrientation = UIImageOrientationRight;
            break;
        case UIInterfaceOrientationLandscapeRight:
            imageOrientation = UIImageOrientationLeft;
            break;
        case UIInterfaceOrientationPortrait:
            imageOrientation = UIImageOrientationUp;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            imageOrientation = UIImageOrientationDown;
            break;
        default:
            break;
    }
    
    return [[UIImage alloc] initWithCGImage:image.CGImage
                                      scale:scale
                                orientation:imageOrientation];
}


- (void)cancelButtonPressed:(id)sender event:(UIEvent *)event
{
    [self dismissModalShareComposeViewControllerAnimated:YES];
}


- (void)sendButtonPressed:(id)sender event:(UIEvent *)event
{
    [self dismissModalShareComposeViewControllerAnimated:YES];
}


- (void)dismissModalShareComposeViewControllerAnimated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:_initialStatusBarStyle
                                                animated:animated];
    
    CGFloat duration = animated ? 0.3 : 0.0;
    
    [UIView animateWithDuration:duration animations:^{
        _backgroundImageView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [self dismissModalViewControllerAnimated:NO];
    }];
    
    [_composeView hideAnimated:animated];
}


// Returns if Twitter is accessible and at least one account has been setup.
+ (BOOL)canSendShare
{
    return NO;
}

// Sets the initial text to be shared. Returns NO if the specified text will
// not fit within the character space currently available, or if the sheet
// has already been presented to the user.
- (BOOL)setInitialText:(NSString *)text
{
    return NO;
}

// Adds an image to the share. Returns NO if the additional image will not fit
// within the character space currently available, or if the sheet has already
// been presented to the user.
- (BOOL)addImage:(UIImage *)image
{
    return NO;
}

// Removes all images from the share. Returns NO and does not perform an operation
// if the sheet has already been presented to the user.
- (BOOL)removeAllImages
{
    return NO;
}

// Adds a URL to the tweet. Returns NO if the additional URL will not fit
// within the character space currently available, or if the sheet has already
// been presented to the user.
- (BOOL)addURL:(NSURL *)url
{
    return NO;
}

// Removes all URLs from the tweet. Returns NO and does not perform an operation
// if the sheet has already been presented to the user.
- (BOOL)removeAllURLs
{
    return NO;
}

- (void)postSucceeded:(id<WTShareService>)service
{
    
}


- (void)postFailed:(id<WTShareService>)service
{
    
}


- (void)postFailedAuthentication:(id<WTShareService>)service
{
    
}

@end