//
//  WTShareService.h
//  WTShareComposer
//
//  Created by Joel Garrett on 8/2/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol WTShareServiceDelegate;
@protocol WTShareService <NSObject>

// Returns if service is accessible and at least one account has been setup.
+ (BOOL)canShare;

- (id<WTShareServiceDelegate>)delegate;
- (void)setDelegate:(id<WTShareServiceDelegate>)delegate;

- (NSString *)title;
- (void)postText:(NSString *)text withImages:(NSArray *)images URLs:(NSArray *)urls;

@optional

- (NSUInteger)imageAttachmentsLimit;
- (NSUInteger)URLAttachmentsLimit;

- (void)postText:(NSString *)text withImages:(NSArray *)images URLs:(NSArray *)urls location:(CLLocation *)location;

@end

@protocol WTShareServiceDelegate <NSObject>

- (void)postSucceeded:(id<WTShareService>)service;
- (void)postFailed:(id<WTShareService>)service;
- (void)postFailedAuthentication:(id<WTShareService>)service;

@end

@protocol WTShareServiceCharacterLimit <WTShareService>

- (NSUInteger)characterLimit;
- (NSUInteger)characterCountForImages:(NSArray *)images;
- (NSUInteger)characterCountForURLs:(NSArray *)urls;

@end
