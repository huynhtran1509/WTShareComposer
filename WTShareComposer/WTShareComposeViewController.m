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
#import "WTTextView.h"

#import <QuartzCore/QuartzCore.h>

typedef enum WTShareComposeViewAlertTag : NSUInteger
{
    WTShareComposeViewControllerNoAccountsAlert = 1,
    WTShareComposeViewControllerCannotSendAlert
} WTShareComposeViewAlertTag;

@implementation UIViewController (WTShareComposeViewControllerPresentation)

- (void)presentModalShareComposeViewControllerAnimated:(WTShareComposeViewController *)viewController
{
    [self presentModalViewController:viewController animated:NO];
}

@end

@interface WTShareComposeViewController () <UITextViewDelegate>

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
        _images = @[];
        _urls = @[];
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
        
        self.service.delegate = self;
        self.title = [self.service title];
        
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"Cancel button title")
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(cancelButtonPressed:event:)];
        [self.theme themeBarButtonItem:cancelItem
                                ofType:WTShareThemeBarButtonItemTypeCancel];
        
        self.navigationItem.leftBarButtonItem = cancelItem;
        
        UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Send", @"Send button title")
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(sendButtonPressed:event:)];
        
        [self.theme themeBarButtonItem:sendItem
                                ofType:WTShareThemeBarButtonItemTypeSend];
        
        self.navigationItem.rightBarButtonItem = sendItem;
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    _composeView = [[WTShareComposeView alloc] initWithNavigationItem:self.navigationItem theme:self.theme];
    [self.view addSubview:_composeView];
    
    if ([self attachmentsCount])
    {
        [_composeView addAttachments:self.images];
        
        for (NSURL *url in self.urls)
            [_composeView addAttachment:[self.theme URLAttachmentImage]];
    }
    
    _composeView.textView.delegate = self;
    _composeView.textView.text = self.text;
    
    if ([self isLocationSupportEnabled])
    {
        [_composeView setLocationSupportEnabled:YES];
        _composeView.locationLabel.text = [self.service locationName];
    }
    
    if ([self isCharacterCountSupportEnabled])
    {
        [_composeView setCharacterCountSupportEnabled:YES];
        [self updateCharacterCount];
    }
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    if (_completionHandler != NULL)
        self.completionHandler(WTShareComposeViewControllerResultCancelled);
    else
        [self dismissModalShareComposeViewControllerAnimated:YES completion:NULL];
}


- (void)sendButtonPressed:(id)sender event:(UIEvent *)event
{
    // Disable the send button
    [sender setEnabled:NO];
    [self.service postText:_composeView.textView.text
                withImages:self.images
                      URLs:self.urls];
}


- (void)dismissModalViewControllerAnimated:(BOOL)animated
{
    [self dismissModalShareComposeViewControllerAnimated:animated completion:NULL];
}


- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    [self dismissModalShareComposeViewControllerAnimated:flag completion:completion];
}


- (void)dismissModalShareComposeViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [[UIApplication sharedApplication] setStatusBarStyle:_initialStatusBarStyle
                                                animated:animated];
    
    CGFloat duration = animated ? 0.3 : 0.0;
    
    [UIView animateWithDuration:duration animations:^{
        _backgroundImageView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        [super dismissModalViewControllerAnimated:NO];
        
        if (completion != NULL)
            completion();
        
    }];
    
    [_composeView hideAnimated:animated];
}


- (BOOL)isLocationSupportEnabled
{
    if ([self.service respondsToSelector:@selector(locationName)] &&
        [self.service locationName] != nil &&
        [[self.service locationName] length] > 0)
        return YES;
    
    return NO;
}


- (BOOL)isCharacterCountSupportEnabled
{
    if ([self.service conformsToProtocol:@protocol(WTShareServiceCharacterLimit)])
        return YES;
    
    return NO;
}


- (NSInteger)charactersAvailable
{
    NSInteger available = [self characterLimit];
    available -= [(id)[self service] characterCountForImages:self.images];
    available -= [(id)[self service] characterCountForURLs:self.images];
    available -= [_composeView.textView.text length];
    
    if ( (available < [self characterLimit]) && ([_composeView.textView.text length] == 0) )
    {
        available += 1;  // The space we added for the first URL isn't needed.
    }
    
    return available;
}


- (void)updateCharacterCount
{
    NSInteger available = [self charactersAvailable];
    
    _composeView.characterCountLabel.text = [NSString stringWithFormat:@"%d", available];
    
    if (available >= 0) {
        _composeView.characterCountLabel.textColor = [UIColor grayColor];
        self.navigationItem.rightBarButtonItem.enabled = (available != [self characterLimit]);  // At least one character is required.
    }
    else {
        _composeView.characterCountLabel.textColor = [UIColor colorWithRed:0.64f green:0.32f blue:0.32f alpha:1.0f];
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}


- (NSInteger)attachmentsCount
{
    return [self.images count] + [self.urls count];
}


- (NSInteger)characterLimit
{
    if ([self.service respondsToSelector:@selector(characterLimit)])
        return [(id)self.service characterLimit];
    
    return 0;
}


- (NSInteger)imageAttachmentsLimit
{
    if ([self.service respondsToSelector:@selector(imageAttachmentsLimit)])
        return [self.service imageAttachmentsLimit];
    
    return 1;
}


- (NSInteger)URLAttachmentsLimit
{
    if ([self.service respondsToSelector:@selector(URLAttachmentsLimit)])
        return [self.service URLAttachmentsLimit];
    
    return 1;
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
    if ([self isViewLoaded]) {
        return NO;
    }
    
    if ([self isCharacterCountSupportEnabled])
        if (([self charactersAvailable] - (NSInteger)[text length]) < 0)
        {
            return NO;
        }
    
    _text = text;  // Keep a copy in case the view isn't loaded yet.
    
    return YES;
}

// Adds an image to the share. Returns NO if the additional image will not fit
// within the character space currently available, or if the sheet has already
// been presented to the user.
- (BOOL)addImage:(UIImage *)image
{
    if (image == nil) {
        return NO;
    }
    
    if ([self isViewLoaded]) {
        return NO;
    }
    
    if ([self.images count] >= self.imageAttachmentsLimit) {
        return NO;
    }
    
    if ([self attachmentsCount] >= 3) {
        return NO;  // Only three allowed.
    }
    
    if ([self isCharacterCountSupportEnabled])
    {
        NSInteger imageLength = [(id)self.service characterCountForImages:@[ image ]];
        if (([self charactersAvailable] - (imageLength + 1)) < 0) {  // Add one for the space character.
            return NO;
        }
    }
    
    _images = [self.images arrayByAddingObject:image];
    return YES;
}

// Removes all images from the share. Returns NO and does not perform an operation
// if the sheet has already been presented to the user.
- (BOOL)removeAllImages
{
    if ([self isViewLoaded]) {
        return NO;
    }
    
    _images = @[];
    return YES;
}

// Adds a URL to the tweet. Returns NO if the additional URL will not fit
// within the character space currently available, or if the sheet has already
// been presented to the user.
- (BOOL)addURL:(NSURL *)url
{
    if (url == nil) {
        return NO;
    }
    
    if ([self isViewLoaded]) {
        return NO;
    }
    
    if ([self attachmentsCount] >= 3) {
        return NO;  // Only three allowed.
    }
    
    if ([self isCharacterCountSupportEnabled])
    {
        NSInteger imageLength = [(id)self.service characterCountForURLs:@[ url ]];
        if (([self charactersAvailable] - (imageLength + 1)) < 0) {  // Add one for the space character.
            return NO;
        }
    }
    
    _urls = [self.urls arrayByAddingObject:url];
    return YES;
}

// Removes all URLs from the tweet. Returns NO and does not perform an operation
// if the sheet has already been presented to the user.
- (BOOL)removeAllURLs
{
    if ([self isViewLoaded]) {
        return NO;
    }
    
    _urls = @[];
    return YES;
}

- (void)postSucceeded:(id<WTShareService>)service
{
    if (_completionHandler != NULL)
        self.completionHandler(WTShareComposeViewControllerResultDone);
    else
        [self dismissModalShareComposeViewControllerAnimated:YES completion:NULL];
}


- (void)postFailed:(id<WTShareService>)service
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Cannot Send Message", @"")
                                                        message:[NSString stringWithFormat:NSLocalizedString(@"The message, \"%@\" cannot be sent because the connection to %@ failed.", @""), _composeView.textView.text, self.service.title]
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
                                              otherButtonTitles:NSLocalizedString(@"Try Again", @""), nil];
    alertView.tag = WTShareComposeViewControllerCannotSendAlert;
    [alertView show];
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
}


- (void)postFailedAuthentication:(id<WTShareService>)service
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Cannot Send Message", @"")
                                                        message:[NSString stringWithFormat:NSLocalizedString(@"Unable to login to %@ with existing credentials. Try again with new credentials.", @""), self.service.title]
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                              otherButtonTitles:nil];
    
    [alertView show];
    
    [self dismissModalShareComposeViewControllerAnimated:YES completion:NULL];
}


#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if ([self isCharacterCountSupportEnabled])
        [self updateCharacterCount];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.theme shouldDisplayNavigationBarDropShadow] == WTShareThemeDisplayNavigationBarDropShadowAuto)
    {
        CGFloat alpha = (scrollView.contentOffset.y * 0.25);
        
        if (alpha < 0.0) alpha = 0.0;
        if (alpha > 1.0) alpha = 1.0;
        
        [_composeView.navigationBarShadowView setAlpha:alpha];
    }
}


#pragma mark - UIAlertView delegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
// This gets called if there's an error sending the tweet.
{
    if (alertView.tag == WTShareComposeViewControllerNoAccountsAlert)
    {
        [self dismissModalViewControllerAnimated:YES];
    }
    
    else if (alertView.tag == WTShareComposeViewControllerCannotSendAlert)
    {
        if (buttonIndex == 1)
        {
            // The user wants to try again.
            [self sendButtonPressed:self.navigationItem.rightBarButtonItem event:nil];
        }
    }
}

@end
