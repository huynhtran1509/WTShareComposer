//
//  WTFacebookService.h
//  WTShareComposer
//
//  Created by Joel Garrett on 8/5/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTFacebookService : NSObject <WTShareService>

@property (nonatomic, weak) id <WTShareServiceDelegate> delegate;

@end
