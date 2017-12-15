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
- (void)startOrEndAnimation:(BOOL)startOrEnd;
/**
 粒子动画
 */
- (void)touchLayer;

/**
 咻咻动画
 */
- (void)radAnimation:(UIColor *)color;

@end

