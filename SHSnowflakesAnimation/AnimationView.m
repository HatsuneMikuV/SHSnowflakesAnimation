//
//  AnimationView.m
//  SHSnowflakesAnimation
//
//  Created by angle on 2017/8/18.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "AnimationView.h"

@interface AnimationView ()

@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, strong) NSArray<UIColor *> *imageArr;

@property (nonatomic, strong) UIColor *oldImage;


@end

@implementation AnimationView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageArr = @[[UIColor redColor],
                          [UIColor greenColor],
                          [UIColor yellowColor],
                          [UIColor blueColor],
                          [UIColor cyanColor],
                          [UIColor grayColor],
                          [UIColor magentaColor],
                          [UIColor orangeColor],
                          [UIColor brownColor],
                          [UIColor purpleColor]];
    }
    return self;
}

- (void)addImageViewAnimation {
    UIColor *image = self.imageArr[arc4random()%10];
    while (self.oldImage == image) {
        image = self.imageArr[arc4random()%10];
    }
    
    self.oldImage = image;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    imageView.backgroundColor = image;
//    [imageView setImage:image];
    imageView.layer.shouldRasterize = YES;
    imageView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    [self startAnimation:imageView];
    [self addSubview:imageView];
}
#pragma mark -
#pragma mark   ==============startAnimation==============
- (void)startAnimation:(UIView *)view {
    
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyframeAnimation.path = [self SPathMore].CGPath;
    keyframeAnimation.repeatCount = 1;
    keyframeAnimation.removedOnCompletion = NO;
    keyframeAnimation.fillMode = kCAFillModeForwards;
    keyframeAnimation.calculationMode = kCAAnimationPaced;
    CFTimeInterval duration = arc4random()%3 + 2.5;
    keyframeAnimation.duration = duration;
    keyframeAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [view.layer addAnimation:keyframeAnimation forKey:@"keyframeAnimation"];
    
    NSInteger index = arc4random()%6;
    
    if (index == 0) {
        [self animationXXX:duration byVIew:view];
        [self animationYYY:duration byVIew:view];
    }else if (index == 1) {
        [self animationXXX:duration byVIew:view];
        [self animationZZZ:duration byVIew:view];
    }else if (index == 2) {
        [self animationYYY:duration byVIew:view];
        [self animationZZZ:duration byVIew:view];
    }else if (index == 1) {
        [self animationYYY:duration byVIew:view];
        [self animationXXX:duration byVIew:view];
    }else if (index == 2) {
        [self animationYYY:duration byVIew:view];
        [self animationZZZ:duration byVIew:view];
    }
    
    /**
     执行完之后删除碎片
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        view.hidden = YES;
        [view removeFromSuperview];
    });
}
#pragma mark -
#pragma mark   ==============X-Y-Z==============
- (void)animationXXX:(CFTimeInterval) duration byVIew:(UIView *)view {
    CABasicAnimation* rotationAnimationX = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotationAnimationX.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimationX.duration = duration;
    rotationAnimationX.cumulative = YES;
    rotationAnimationX.repeatCount = MAXFLOAT;
    [view.layer addAnimation:rotationAnimationX forKey:@"rotationAnimationX"];
}
- (void)animationYYY:(CFTimeInterval) duration byVIew:(UIView *)view {
    CABasicAnimation* rotationAnimationY = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimationY.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimationY.duration = duration;
    rotationAnimationY.cumulative = YES;
    rotationAnimationY.repeatCount = MAXFLOAT;
    [view.layer addAnimation:rotationAnimationY forKey:@"rotationAnimationY"];
}
- (void)animationZZZ:(CFTimeInterval) duration byVIew:(UIView *)view {
    CABasicAnimation* rotationAnimationZ = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimationZ.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimationZ.duration = duration;
    rotationAnimationZ.cumulative = YES;
    rotationAnimationZ.repeatCount = MAXFLOAT;
    [view.layer addAnimation:rotationAnimationZ forKey:@"rotationAnimationZ"];
}
#pragma mark -
#pragma mark   ==============UIBezierPath==============
- (UIBezierPath *)SPathMore{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    NSInteger width = self.frame.size.width;
    NSInteger heigh = self.frame.size.height;
    
    CGFloat startX    = arc4random()%width + 1;
    CGFloat controlX1 = arc4random()%width + 1;
    CGFloat controlX2 = arc4random()%width + 1;
    CGFloat endX      = arc4random()%width + 1;
    
    if (controlX1 + controlX2 > width) {
        CGFloat control = controlX1;
        controlX1 = controlX2;
        controlX2 = control;
    }
    
    CGFloat startY    = -10;
    CGFloat controlY1 = arc4random()%heigh + 1;
    CGFloat controlY2 = arc4random()%heigh + 1;
    if (controlY1 + controlY2 > heigh) {
        CGFloat control = controlY1;
        controlY1 = controlY2;
        controlY2 = control;
    }
    CGFloat endY      = heigh + 10;
    
    CGPoint startPoint    = CGPointMake(startX, startY);
    CGPoint controlPoint1 = CGPointMake(controlX1, controlY1);
    CGPoint controlPoint2 = CGPointMake(controlX2, controlY2);
    CGPoint endPoint      = CGPointMake(endX, endY);
    
    [path moveToPoint:startPoint];
    [path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    return path;
}
#pragma mark -
#pragma mark   ==============定时器==============
- (void)startOrEndAnimation:(BOOL)startOrEnd {
    if (startOrEnd) {
        if (self.timer) {
            return;
        }else {
            dispatch_queue_t queue = dispatch_get_main_queue();
            
            self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

            dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC));
            
            NSInteger count = self.count > 0 ?self.count:10;
            
            uint64_t interval = (uint64_t)( (1.0 / count) * NSEC_PER_SEC);
            
            dispatch_source_set_timer(self.timer, start, interval, 0);
            
            dispatch_source_set_event_handler(self.timer, ^{
                [self addImageViewAnimation];
            });
            
            dispatch_resume(self.timer);
        }
    }else {
        if (self.timer) {
            dispatch_cancel(self.timer);
            self.timer = nil;
        }
    }
}

@end
