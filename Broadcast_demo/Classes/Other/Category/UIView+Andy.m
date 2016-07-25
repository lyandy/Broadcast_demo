//
//  UIView+Andy.m
//  Broadcast_demo
//
//  Created by 李扬 on 16/7/20.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "UIView+Andy.h"

@implementation UIView (Andy)


- (CGSize)andy_Size
{
    return self.frame.size;
}

- (void)setAndy_Size:(CGSize)andy_Size
{
    CGRect frame = self.frame;
    frame.size = andy_Size;
    self.frame = frame;
}

- (CGFloat)andy_Width
{
    return self.frame.size.width;
}

- (void)setAndy_Width:(CGFloat)andy_Width
{
    CGRect frame = self.frame;
    frame.size.width = andy_Width;
    self.frame = frame;
}

- (CGFloat)andy_Height
{
    return self.frame.size.height;
}

- (void)setAndy_Height:(CGFloat)andy_Height
{
    CGRect frame = self.frame;
    frame.size.height = andy_Height;
    self.frame = frame;
}

- (CGFloat)andy_X
{
    return self.frame.origin.x;
}

- (void)setAndy_X:(CGFloat)andy_X
{
    CGRect frame = self.frame;
    frame.origin.x = andy_X;
    self.frame = frame;
}

- (CGFloat)andy_Y
{
    return self.frame.origin.y;
}

- (void)setAndy_Y:(CGFloat)andy_Y
{
    CGRect frame = self.frame;
    frame.origin.y = andy_Y;
    self.frame = frame;
}

- (CGFloat)andy_CenterX
{
    return self.center.x;
}

- (void)setAndy_CenterX:(CGFloat)andy_CenterX
{
    CGPoint center = self.center;
    center.x = andy_CenterX;
    self.center = center;
}

- (CGFloat)andy_CenterY
{
    return self.center.y;
}

- (void)setAndy_CenterY:(CGFloat)andy_CenterY
{
    CGPoint center = self.center;
    center.y = andy_CenterY;
    self.center = center;
}


@end
