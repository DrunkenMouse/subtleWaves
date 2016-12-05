//
//  ViewLayer.h
//  若隐若现的电波
//
//  Created by 王奥东 on 16/12/5.
//  Copyright © 2016年 王奥东. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ViewLayer : CALayer

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) NSTimeInterval pulseInterval;
@property (nonatomic, strong) CAAnimationGroup *animationGroup;

@end
