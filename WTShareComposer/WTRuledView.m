//
//  WTRuledView.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/9/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTRuledView.h"

@implementation WTRuledView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {   
        _rowHeight = 20.0f;
        _lineWidth = 1.0f;
        _lineColor = [UIColor colorWithWhite:0.5f alpha:0.15f];
        
        self.contentMode = UIViewContentModeRedraw;
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}


- (void)setRowHeight:(CGFloat)rowHeight
{
    _rowHeight = rowHeight;
    [self setNeedsDisplay];
}


- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}


- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextSetLineWidth(context, self.lineWidth);
    CGFloat strokeOffset = (self.lineWidth * 0.5);  // Because lines are drawn between pixels. This moves it back onto the pixel.
    
    if (self.rowHeight > 0.0f)
    {
        CGRect rowRect = self.frame;
        rowRect.size.height = self.rowHeight;
        
        NSInteger rowNumber = 1;
        
        while (rowRect.origin.y < self.frame.size.height + 100.0f)
        {
            CGContextMoveToPoint(context, rowRect.origin.x + strokeOffset, rowRect.origin.y + strokeOffset);
            CGContextAddLineToPoint(context, rowRect.origin.x + rowRect.size.width + strokeOffset, rowRect.origin.y + strokeOffset);
            CGContextDrawPath(context, kCGPathStroke);
            
            rowRect.origin.y += self.rowHeight;
            rowNumber++;
        }
    }
}

@end
