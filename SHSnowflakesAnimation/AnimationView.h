//
//  AnimationView.h
//  SHSnowflakesAnimation
//
//  Created by angle on 2017/8/18.
//  Copyright © 2017年 angle. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, SHShakeViewDirection) {
    SHShakeViewDirectionNone                 = 0,
    SHShakeViewDirectionLeftRight,//左右
    SHShakeViewDirectionLeftUp,//左上
    SHShakeViewDirectionLeftDown,//左下
    SHShakeViewDirectionRightLeft,//右左
    SHShakeViewDirectionRightUp,//右上
    SHShakeViewDirectionRightDown,//右下
    SHShakeViewDirectionUpDown,//上下
    SHShakeViewDirectionUpLeft,//上左
    SHShakeViewDirectionUpRight,//上右
    SHShakeViewDirectionDownUp,//下上
    SHShakeViewDirectionDownLeft,//下左
    SHShakeViewDirectionDownRight,//下右
};

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
- (void)radAnimation:(UIColor *_Nullable)color;

/**
 抖动动画

 @param shakeView 抖动视图
 @param duration 抖动时间
 @param width 抖动幅度
 @param direction 抖动方向
 @param completion 完成
 */
+ (void)shakeView:(UIView *_Nonnull)shakeView duration:(NSTimeInterval)duration range:(CGFloat)width direction:(SHShakeViewDirection)direction completion:(void (^ __nullable)(void))completion;

@end

