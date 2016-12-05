//
//  ViewLayer.m
//  若隐若现的电波
//
//  Created by 王奥东 on 16/12/5.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewLayer.h"

@implementation ViewLayer

-(id)init {
    
    if (self= [super init]) {
        
        //contentsScale对于寄宿图的绘制有所影响，但不会太明显作用于显示。
        //但在设置寄宿图需要进行设置，以免显示错误。
        self.contentsScale = [UIScreen mainScreen].scale;
        //不透明
        self.opacity = 0;
        
        self.radius = 60;
        self.animationDuration = 3;
        //脉冲值
        self.pulseInterval = 0;
        self.backgroundColor = [[UIColor colorWithRed:0.0 green:0.478 blue:1.0 alpha:1] CGColor];
        //子线程里开启动画
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self setupAnimationGroup];
            //INFINITY无穷
            if (self.pulseInterval != INFINITY) {
                //主线程里刷新动画
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self addAnimation:self.animationGroup forKey:@"pulse"];
                });
            }
        });
    }
    return self;
}

-(void)setRadius:(CGFloat)radius {
    
    _radius = radius;
    //锚点
    CGPoint tempPos = self.position;
    
    CGFloat diameter = self.radius * 2;
    //根据半径来扩大自身的宽高为半径一倍，通过锚点固定位置，并画圆
    self.bounds = CGRectMake(0, 0, diameter, diameter);
    self.cornerRadius = self.radius;
    self.position = tempPos;
    
}


-(void)setupAnimationGroup {
 
    //速度控制函数,模式为默认
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    //CAAnimationGroup允许多个动画同时播放
    self.animationGroup = [CAAnimationGroup animation];
    self.animationGroup.duration = self.animationDuration + self.pulseInterval;
    self.animationGroup.repeatCount = INFINITY;
    //为true时，一旦活动持续时间过去，动画就从渲染树中移除。 默认为YES。
    self.animationGroup.removedOnCompletion = NO;
    //定义动画的步调的计时函数。 默认为nil，表示线性起搏。
    self.animationGroup.timingFunction = defaultCurve;
    
    //提供了对单一动画的实现
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.0;
    scaleAnimation.toValue = @1.0;
    scaleAnimation.duration = self.animationDuration;
    //关键帧动画,可以定义透明度的动画效果
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = self.animationDuration;
    opacityAnimation.values = @[@0.45,@0.45,@0];
    opacityAnimation.keyTimes = @[@0,@0.2,@1];
    opacityAnimation.removedOnCompletion = NO;
    
    NSArray *animations = @[opacityAnimation,scaleAnimation];
    
    self.animationGroup.animations = animations;
    
}



@end
