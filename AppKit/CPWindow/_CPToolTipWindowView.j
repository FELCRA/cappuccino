/*
 * _CPToolTipWindowView.j
 * AppKit
 *
 * Created by Antoine Mercadal 
 * Copyright 2011 <primalmotion@archipelproject.org>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

@import "_CPWindowView.j"


@implementation _CPToolTipWindowView : _CPWindowView
{
    BOOL            _mouseDownPressed   @accessors(getter=isMouseDownPressed, setter=setMouseDownPressed:);
    unsigned        _gravity            @accessors(property=gravity);

    CPColor         _backgroundColor;
    CPColor         _strokeColor;
}


#pragma mark -
#pragma mark Class methods

/*! compute the contentView frame from a given window frame
    @param aFrameRect the window frame
*/
+ (CGRect)contentRectForFrameRect:(CGRect)aFrameRect
{
    var contentRect = CGRectMakeCopy(aFrameRect);
    
    contentRect.origin.x += 3;
    contentRect.origin.y += 3;
    contentRect.size.width -= 6;
    contentRect.size.height -= 6;

    return contentRect;
}

/*! compute the window frame from a given contentView frame
    @param aContentRect the contentView frame
*/
+ (CGRect)frameRectForContentRect:(CGRect)aContentRect
{
    var aFrameRect = CGRectMakeCopy(aContentRect);

    aFrameRect.origin.x -= 3;
    aFrameRect.origin.y -= 3;
    aFrameRect.size.width += 6;
    aFrameRect.size.height += 6;

    return aFrameRect;
}


#pragma mark -
#pragma mark Initialization

- (id)initWithFrame:(CPRect)aFrame styleMask:(unsigned)aStyleMask
{
    if (self = [super initWithFrame:aFrame styleMask:aStyleMask])
    {
        _strokeColor = [CPColor colorWithHexString:@"E3E3E3"];
        _backgroundColor = [CPColor colorWithHexString:@"FFFFCA"];
    }

    return self;
}


#pragma mark -
#pragma mark drawing

- (void)drawRect:(CGRect)aRect
{
    [super drawRect:aRect];

    var context = [[CPGraphicsContext currentContext] graphicsPort],
        radius = 2,
        strokeWidth = 1;
        
    CGContextSetStrokeColor(context, _strokeColor);
    CGContextSetFillColor(context, _backgroundColor);
    CGContextSetLineWidth(context, strokeWidth);
    CGContextBeginPath(context);

    aRect.origin.x += strokeWidth;
    aRect.origin.y += strokeWidth;
    aRect.size.width -= strokeWidth * 2;
    aRect.size.height -= strokeWidth * 2;

    CGContextAddPath(context, CGPathWithRoundedRectangleInRect(aRect, radius, radius, YES, YES, YES, YES));
    CGContextClosePath(context);

    //Draw it
    CGContextStrokePath(context);
    CGContextFillPath(context);
}

@end