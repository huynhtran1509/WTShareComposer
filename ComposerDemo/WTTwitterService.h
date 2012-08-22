//
//  WTTwitterService.h
//  WTShareComposer
//
//  Created by Joel Garrett on 8/5/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTTwitterService : NSObject <WTShareServiceCharacterLimit>

@property (nonatomic, weak) id <WTShareServiceDelegate> delegate;

@end
