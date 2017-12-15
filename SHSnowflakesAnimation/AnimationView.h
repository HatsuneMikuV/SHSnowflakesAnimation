//
//  AnimationView.h
//  SHSnowflakesAnimation
//
//  Created by angle on 2017/8/18.
//  Copyright © 2017年 angle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationView : UIView

/**
 帧动画
 */
/**
 秒帧数
 */
@property (nonatomic, assign) NSInteger count;
- (void)startOrEndAnimation:(BOOL)startOrEnd;
/**
 粒子动画
 */
/**
 N秒1次
 */
@property (nonatomic, assign) NSTimeInterval repetition;
- (void)touchLayer;
//手动执行
- (void)manualOperationTouchAtPosition:(CGPoint)position;
/**
 咻咻动画
 */
- (void)radAnimation:(UIColor *)color;

@end

