//
//  AnimationView.h
//  SHSnowflakesAnimation
//
//  Created by angle on 2017/8/18.
//  Copyright © 2017年 angle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationView : UIView

//1s   产生的个数。默认10
@property (nonatomic, assign) NSInteger count;

- (void)startOrEndAnimation:(BOOL)startOrEnd;

@end
