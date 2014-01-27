//
//  SpinningDiskView.m
//  streetvoice
//
//  Created by Stan Tsai on 2014/1/27.
//  Copyright (c) 2014年 Stan Tsai. All rights reserved.
//

#import "SpinningDiskView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface SpinningDiskView ()

@property (nonatomic, strong) UIImageView *CDImageView;

@end

@implementation SpinningDiskView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomViews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initCustomViews];
    }
    return self;
}

- (void)initCustomViews
{
    UIImage *border = [self stylishBorder];
    self.CDImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.CDImageView setImage:border];
    [self addSubview:self.CDImageView];
    
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 6.0f;
    rotationAnimation.RepeatCount = FLT_MAX;
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO; //No Remove
    [self.CDImageView.layer addAnimation:rotationAnimation forKey:@"rotation"];
    
    self.layer.speed = 0.0f;
}

- (void)setImage:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
    [image drawInRect:self.bounds];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.CDImageView.backgroundColor = [UIColor colorWithPatternImage:resizedImage];
}


- (UIImage *)stylishBorder
{
    CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    
    self.clipsToBounds = YES;
    
    self.layer.cornerRadius = center.x;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [[UIColor grayColor] CGColor];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOpacity = 0.6f;
    self.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // outside circular
    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithWhite:1.0f alpha:0.7f] CGColor]);
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, self.frame.size.width / 10.0f);
    CGContextAddArc(context, center.x, center.y, center.x, 0, 2 * M_PI, 0);
    CGContextStrokePath(context);
    CGContextClosePath(context);
    
    // inside circular
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, self.frame.size.width / 40.0f);
    CGContextAddArc(context, center.x, center.y, self.frame.size.width / 10.0f, 0, 2 * M_PI, 0);
    CGContextStrokePath(context);
    CGContextClosePath(context);
    
    // hollow center 
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, self.frame.size.width / 20.0f);
    CGContextAddArc(context, center.x, center.y, self.frame.size.width / 40.0f, 0, 2 * M_PI, 0);
    CGContextStrokePath(context);
    CGContextClosePath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)startRotation
{
    self.layer.speed = 1.0f;
    self.layer.beginTime = 0.0f;
    CFTimeInterval pausedTime = [self.layer timeOffset];
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

- (void)stopRotation
{
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}

- (void)toggleRotation
{
    if (self.layer.speed == 0.0f) {
        [self startRotation];
    } else {
        [self stopRotation];
    }
}

- (void)setRotaion:(BOOL)isRotation
{
    if (isRotation) {
        [self startRotation];
    } else {
        [self stopRotation];
    }
}


@end
