//
//  WTThumbnailView.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/22/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTThumbnailView.h"
#import <QuartzCore/QuartzCore.h>

@implementation WTThumbnailView

- (id)initWithFrame:(CGRect)frame
{
    frame.size = CGSizeMake(84.0f, 79.0f);
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        CGRect thumb_frame = frame;
        thumb_frame.origin = CGPointZero;
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.backgroundColor = [UIColor colorWithWhite:0.0 alpha:1.0].CGColor;
        shapeLayer.frame = CGRectMake(6.0f, 2.0f, 72.0f, 71.0f);
        shapeLayer.cornerRadius = 3.0;
        shapeLayer.masksToBounds = YES;
        
        self.layer.mask = shapeLayer;
        
        _frameImageView = [[UIImageView alloc] initWithFrame:thumb_frame];
        [self.frameImageView setImage:[UIImage imageNamed:@"DETweetAttachmentFrame.png"]];
        [self addSubview:self.frameImageView];
    }
    
    return self;
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
