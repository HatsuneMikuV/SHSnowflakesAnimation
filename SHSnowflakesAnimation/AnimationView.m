//
//  AnimationView.m
//  SHSnowflakesAnimation
//
//  Created by angle on 2017/8/18.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "AnimationView.h"
#import "UIView+Layout.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface AnimationView ()

@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, strong) NSArray<UIImage *> *imageArr;

@property (nonatomic, strong) UIImage *oldImage;

@property (strong) CAEmitterLayer *ringEmitter;

@property (nonatomic, strong) UIColor *raderColor;

@end

@implementation AnimationView


- (void)dealloc {
    [self startOrEndAnimation:NO];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.imageArr = @[[UIImage imageNamed:@"ani_blu"],
                          [UIImage imageNamed:@"ani_red"],
                          [UIImage imageNamed:@"ani_gre"],
                          [UIImage imageNamed:@"ani_yel"]];
    }
    return self;
}
#pragma mark -
#pragma mark   =============帧动画==============
- (void)addImageViewAnimation {
    UIImage *image = self.imageArr[arc4random()%4];
    while (self.oldImage == image) {
        image = self.imageArr[arc4random()%4];
    }
    self.oldImage = image;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [imageView setImage:image];
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
    CFTimeInterval duration = arc4random()%3 + 1.5;
    keyframeAnimation.duration = duration;
    keyframeAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [view.layer addAnimation:keyframeAnimation forKey:@"keyframeAnimation"];
    
    NSInteger index = arc4random()%3;
    
    if (index == 0) {
        [self animationXXX:duration byVIew:view];
        [self animationYYY:duration byVIew:view];
    }else if (index == 1) {
        [self animationXXX:duration byVIew:view];
        [self animationZZZ:duration byVIew:view];
    }else if (index == 2) {
        [self animationYYY:duration byVIew:view];
        [self animationZZZ:duration byVIew:view];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        view.hidden = YES;
        [view removeFromSuperview];
    });
}
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
    
    NSInteger width  = (NSInteger)self.width + 1;
    NSInteger height = (NSInteger)(self.height - 9) + 4;
    
    CGFloat startX    = arc4random()%width;
    CGFloat controlX1 = arc4random()%width;
    CGFloat controlX2 = arc4random()%width;
    CGFloat endX      = arc4random()%width;
    
    if (controlX1 + controlX2 > width - 1) {
        CGFloat control = controlX1;
        controlX1 = controlX2;
        controlX2 = control;
    }
    
    CGFloat startY    = -5;
    CGFloat controlY1 = arc4random()%height + 5;
    CGFloat controlY2 = arc4random()%height + 5;
    if (controlY1 + controlY2 > self.height + 5) {
        CGFloat control = controlY1;
        controlY1 = controlY2;
        controlY2 = control;
    }
    CGFloat endY      = self.height + 5;
    
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
        if (self.raderColor) {
            [self radAnimation:self.raderColor];
            return;
        }
        if (self.timer) {
            return;
        }else {
            dispatch_queue_t queue = dispatch_get_main_queue();
            
            self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            
            dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC));
            
            uint64_t interval;
            if (self.ringEmitter) {
                NSTimeInterval time = self.repetition > 0 ? self.repetition:2;
                interval = (uint64_t)(time * NSEC_PER_SEC);
            }else {
                NSInteger count = self.count > 0 ? self.count:10;
                interval = (uint64_t)( (1.0 / count) * NSEC_PER_SEC);
            }

            dispatch_source_set_timer(self.timer, start, interval, 0);
            
            dispatch_source_set_event_handler(self.timer, ^{
                if (self.ringEmitter) {
                    [self touchAtPosition:CGPointMake(self.width * 0.5, self.height * 0.5)];
                }else {
                    [self addImageViewAnimation];
                }
            });
            
            dispatch_resume(self.timer);
        }
    }else {
        if (self.raderColor) {
            [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeAllAnimations];
            }];
            [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
            return;
        }
        if (self.timer) {
            dispatch_cancel(self.timer);
            self.timer = nil;
        }
    }
}
#pragma mark -
#pragma mark   ==============粒子动画==============
- (void)touchLayer {
    
    self.ringEmitter = [CAEmitterLayer layer];
    
    
    self.ringEmitter.emitterPosition    = CGPointMake(self.width / 2, self.height / 2);
    self.ringEmitter.emitterSize        = CGSizeMake(50, 0);
    
    self.ringEmitter.emitterMode        = kCAEmitterLayerOutline;
    self.ringEmitter.emitterShape       = kCAEmitterLayerCircle;
    self.ringEmitter.renderMode         = kCAEmitterLayerBackToFront;
    
    
    CAEmitterCell *ring = [CAEmitterCell emitterCell];
    [ring setName:@"ring"];
    
    ring.birthRate      = 0;
    ring.velocity       = 250;
    ring.scale          = 0.5;
    ring.scaleSpeed     =- 0.2;
    ring.greenSpeed     =- 0.2;
    ring.redSpeed       =- 0.5;
    ring.blueSpeed      =- 0.5;
    ring.lifetime       =  2;
    
    ring.color          = [UIColor whiteColor].CGColor;
    ring.contents       = (id)[UIImage imageNamed:@"DazTriangle"].CGImage;
    
    
    
    CAEmitterCell *circle   =[CAEmitterCell emitterCell];
    [circle setName:@"circle"];
    
    circle.birthRate            = 10;
    circle.emissionLongitude    = M_PI * 0.5;
    circle.velocity             = 50;
    circle.scale                = 0.5;
    circle.scaleSpeed           =- 0.2;
    circle.greenSpeed           =- 0.1;
    circle.redSpeed             =- 0.2;
    circle.blueSpeed            =  0.1;
    circle.alphaSpeed           =- 0.2;
    circle.lifetime             =  4;
    circle.color                = [UIColor whiteColor].CGColor;
    circle.contents             = (id)[UIImage imageNamed:@"DazRing"].CGImage;
    
    
    CAEmitterCell *star         = [CAEmitterCell emitterCell];
    [star setName:@"star"];
    
    star.birthRate              = 10;
    star.velocity               = 100;
    star.zAcceleration          = -1;
    star.emissionLongitude      = -M_PI;
    star.scale                  = 0.5;
    star.scaleSpeed             =- 0.2;
    star.greenSpeed             =- 0.1;
    star.redSpeed               = 0.4;
    star.blueSpeed              =- 0.1;
    star.alphaSpeed             =- 0.2;
    star.lifetime               = 2;
    
    star.color = [[UIColor whiteColor] CGColor];
    star.contents = (id) [[UIImage imageNamed:@"DazStarOutline"] CGImage];
    
    self.ringEmitter.emitterCells = @[ring];
    ring.emitterCells   = @[star];
    [self.layer addSublayer:self.ringEmitter];
    
    [self startOrEndAnimation:YES];
}
- (void)manualOperationTouchAtPosition:(CGPoint)position {
    [self startOrEndAnimation:NO];
    [self touchAtPosition:position];
}

- (void) touchAtPosition:(CGPoint)position {
    CABasicAnimation *burst = [CABasicAnimation animationWithKeyPath:@"emitterCells.ring.birthRate"];
    burst.fromValue            = [NSNumber numberWithFloat: 125.0];
    burst.toValue            = [NSNumber numberWithFloat: 0.0];
    burst.duration            = 0.5;
    burst.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.ringEmitter addAnimation:burst forKey:@"burst"];
    
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    self.ringEmitter.emitterPosition    = position;
    [CATransaction commit];
}

#pragma mark -
#pragma mark   ==============雷达动画／咻咻动画==============
- (void)radAnimation:(UIColor *)color {
    self.raderColor = color;
    
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = NO;
    for (int i = 0; i < 9; i++) {
        [self addAnimationDelay:i];
    }
}
//画雷达圆圈图
-(void)addAnimationDelay:(int)time
{
    CGPoint centerPoint = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    //使用贝塞尔画圆
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:10 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.fillColor = self.raderColor.CGColor;
    shapeLayer.opacity = 0.3;
    shapeLayer.path = path.CGPath;
    
    
    [self.layer addSublayer:shapeLayer];
    
    //雷达圈圈大小的动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"path";
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:center radius:10 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:center radius:SCREEN_WIDTH * 0.5 + 10 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    basicAnimation.fromValue = (__bridge id _Nullable)(path1.CGPath);
    basicAnimation.toValue = (__bridge id _Nullable)(path2.CGPath);
    basicAnimation.fillMode = kCAFillModeForwards;
    
    
    //雷达圈圈的透明度
    CABasicAnimation *opacityAnimation = [CABasicAnimation animation];
    opacityAnimation.keyPath = @"opacity";
    
    opacityAnimation.fromValue = @(0.3);
    opacityAnimation.toValue = @(0);
    opacityAnimation.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[basicAnimation,opacityAnimation];
    
    //动画间隔时间  这里的值和创建的动画个数需要计算好，避免最后一轮动画结束了，第一个动画好没有结束，出现效果差
    group.duration = 3;
    //动画开始时间
    group.beginTime = CACurrentMediaTime() + (double)time/3;
    
    //循环次数最大（无尽）  HUGE
    group.repeatCount = HUGE;
    
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //指定的时间段完成后,动画就自动的从层上移除
    group.removedOnCompletion = YES;
    //添加动画到layer
    [shapeLayer addAnimation:group forKey:nil];
    
}

+ (void)shakeView:(UIView *_Nonnull)shakeView duration:(NSTimeInterval)duration range:(CGFloat)width direction:(SHShakeViewDirection)direction completion:(void (^ __nullable)(void))completion {
    if (shakeView && SHShakeViewDirectionNone != direction) {
        CGFloat widthRel  = width > 0 ? width : 8;
        
        NSTimeInterval time = duration > 0 ? duration * 0.25 : 0.05;
        
        CABasicAnimation *shake;
        
        if (direction == SHShakeViewDirectionNone || direction == SHShakeViewDirectionLeftRight) {
            
            //默认左右
            shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
            shake.fromValue = [NSNumber numberWithFloat:-widthRel];
            shake.toValue = [NSNumber numberWithFloat:widthRel];
        }else if (direction == SHShakeViewDirectionLeftUp || direction == SHShakeViewDirectionUpLeft) {
            
            //左上==左上
            widthRel = ceilf(sqrtf(width * width * 0.5));
            shake = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
            shake.fromValue = [NSValue valueWithCGPoint:CGPointMake(-widthRel, -widthRel)];
            shake.toValue = [NSValue valueWithCGPoint:CGPointMake(widthRel, widthRel)];
        }else if (direction == SHShakeViewDirectionLeftDown || direction == SHShakeViewDirectionDownLeft) {
            
            //左下==下左
            widthRel = ceilf(sqrtf(width * width * 0.5));
            shake = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
            shake.fromValue = [NSValue valueWithCGPoint:CGPointMake(- widthRel, widthRel)];
            shake.toValue = [NSValue valueWithCGPoint:CGPointMake(widthRel, - widthRel)];
        }else if (direction == SHShakeViewDirectionRightLeft) {
            
            //右左
            shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
            shake.fromValue = [NSNumber numberWithFloat:widthRel];
            shake.toValue = [NSNumber numberWithFloat:-widthRel];
        }else if (direction == SHShakeViewDirectionRightUp || direction == SHShakeViewDirectionUpRight) {
            
            //右上==上右
            widthRel = ceilf(sqrtf(width * width * 0.5));
            shake = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
            shake.fromValue = [NSValue valueWithCGPoint:CGPointMake(widthRel, -widthRel)];
            shake.toValue = [NSValue valueWithCGPoint:CGPointMake(-widthRel, widthRel)];
        }else if (direction == SHShakeViewDirectionRightDown || direction == SHShakeViewDirectionDownRight) {
            
            //右下==下右
            widthRel = ceilf(sqrtf(width * width * 0.5));
            shake = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
            shake.fromValue = [NSValue valueWithCGPoint:CGPointMake(widthRel, widthRel)];
            shake.toValue = [NSValue valueWithCGPoint:CGPointMake(-widthRel, -widthRel)];
        }else if (direction == SHShakeViewDirectionUpDown) {
            
            //上下
            shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
            shake.fromValue = [NSNumber numberWithFloat:-widthRel];
            shake.toValue = [NSNumber numberWithFloat:widthRel];
        }else if (direction == SHShakeViewDirectionDownUp) {
            
            //下上
            shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
            shake.fromValue = [NSNumber numberWithFloat:widthRel];
            shake.toValue = [NSNumber numberWithFloat:-widthRel];
        }
        
        shake.duration = time;//执行时间
        shake.autoreverses = YES; //是否重复
        shake.repeatCount = 2;//次数
        [shakeView.layer addAnimation:shake forKey:@"shakeAnimation"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
        });
    }
}

@end


