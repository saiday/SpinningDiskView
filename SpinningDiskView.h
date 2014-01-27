//
//  SpinningDiskView.h
//  streetvoice
//
//  Created by Stan Tsai on 2014/1/27.
//  Copyright (c) 2014年 Stan Tsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpinningDiskView : UIView

- (void)setRotaion:(BOOL)isRotation;
- (void)toggleRotation;
- (void)startRotation;
- (void)stopRotation;
- (void)setImage:(UIImage *)image;

@end
