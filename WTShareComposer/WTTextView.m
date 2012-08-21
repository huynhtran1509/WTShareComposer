//
//  WTTextView.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/9/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTTextView.h"
#import "WTRuledView.h"

@interface WTTextView ()

@property (nonatomic, strong) WTRuledView *ruledView;

@end

@implementation WTTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Initialization code
        _ruledView = [[WTRuledView alloc] initWithFrame:CGRectZero];
        _ruledView.lineColor = [UIColor colorWithWhite:0.5f alpha:0.15f];
        _ruledView.lineWidth = 1.0f;
        _ruledView.rowHeight = self.font.lineHeight;
        [self insertSubview:self.ruledView atIndex:0];
        
        [self setAlwaysBounceVertical:YES];
    }
    
    return self;
}


- (void)setContentSize:(CGSize)contentSize
{
    [super setContentSize:contentSize];
    self.ruledView.frame = [self ruledViewFrame];
}


- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.ruledView.rowHeight = self.font.lineHeight;
}


- (CGRect)ruledViewFrame
{
    CGFloat extraForBounce = 200.0f;  // Extra added to top and bottom so it's visible when the user drags past the bounds.
    CGFloat width = 1024.0f;  // Needs to be at least as wide as we might make the Tweet sheet.
    CGFloat textAlignmentOffset = -6.0f;  // To center the text between the lines. May want to find a way to determine this procedurally eventually.
    
    CGRect frame = CGRectZero;
    
    if (NO)
        frame = CGRectMake(0.0f, 30.0f, width, self.contentSize.height + extraForBounce);
    else
        frame = CGRectMake(0.0f, -extraForBounce + textAlignmentOffset, width, self.contentSize.height + (2 * extraForBounce));
    
    return frame;
}

@end
