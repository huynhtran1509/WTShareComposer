//
//  WTShareComposeViewController.h
//  WTShareComposer
//
//  Created by Joel Garrett on 8/2/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WTShareComposer/WTShareService.h>
#import <WTShareComposer/WTShareTheme.h>

@class WTShareComposeViewController;

enum WTShareComposeViewControllerResult
{
    WTShareComposeViewControllerResultCancelled,
    WTShareComposeViewControllerResultDone
};
typedef enum WTShareComposeViewControllerResult WTShareComposeViewControllerResult;

// Completion handler for WTShareComposeViewController
typedef void (^WTShareComposeViewControllerCompletionHandler)(WTShareComposeViewControllerResult result);


@interface WTShareComposeViewController : UIViewController <WTShareServiceDelegate>

- (id)initWithService:(id<WTShareService>)service theme:(id<WTShareTheme>)theme;

// Sets the initial text to be shared. Returns NO if the specified text will
// not fit within the character space currently available, or if the sheet
// has already been presented to the user.
- (BOOL)setInitialText:(NSString *)text;

// Adds an image to the share. Returns NO if the additional image will not fit
// within the character space currently available, or if the sheet has already
// been presented to the user.
- (BOOL)addImage:(UIImage *)image;

// Removes all images from the share. Returns NO and does not perform an operation
// if the sheet has already been presented to the user.
- (BOOL)removeAllImages;

// Adds a URL to the tweet. Returns NO if the additional URL will not fit
// within the character space currently available, or if the sheet has already
// been presented to the user.
- (BOOL)addURL:(NSURL *)url;

// Removes all URLs from the tweet. Returns NO and does not perform an operation
// if the sheet has already been presented to the user.
- (BOOL)removeAllURLs;

// Specify a block to be called when the user is finished. This block is not guaranteed
// to be called on any particular thread.
@property (nonatomic, copy) WTShareComposeViewControllerCompletionHandler completionHandler;

// Sharing service to use for sending composed content
@property (nonatomic, strong) id <WTShareService> service;
@property (nonatomic, strong) id <WTShareTheme> theme;

@property (nonatomic, readonly) NSArray *images;
@property (nonatomic, readonly) NSString *text;
@property (nonatomic, readonly) CLLocation *location;

@end
