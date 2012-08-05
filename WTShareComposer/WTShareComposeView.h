//
//  WTShareComposeView.h
//  WTShareComposer
//
//  Created by Joel Garrett on 8/2/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTShareComposeView : UIView

@property (nonatomic, readonly) UINavigationBar *navigationBar;
@property (nonatomic, readonly) UITextView *textView;

- (id)initWithNavigationItem:(UINavigationItem *)navigationItem;

- (void)showAnimated:(BOOL)animated;
- (void)showAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

- (void)hideAnimated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

@end
