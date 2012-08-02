//
//  WTShareComposeViewController.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/2/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTShareComposeViewController.h"
#import "WTShareComposeView.h"
#import "WTTwitterTheme.h"

@interface WTShareComposeViewController ()

@end

@implementation WTShareComposeViewController

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
            _theme = [[WTTwitterTheme alloc] init];
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
