//
//  TestViewController.m
//  SHSnowflakesAnimation
//
//  Created by angle on 2017/12/15.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "TestViewController.h"

#import "AnimationView.h"

@interface TestViewController ()

@property (nonatomic, strong) AnimationView *animationView;


@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.96 alpha:1.00];
    //启动
    [self startAnimation];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(startOrEnd:)];
    
}
#pragma mark -
#pragma mark   ==============开关==============
- (void)startOrEnd:(UIBarButtonItem *)bar {
    if ([bar.title isEqualToString:@"关闭"]) {
        bar.title = @"开启";
        [self.animationView startOrEndAnimation:NO];
    }else {
        bar.title = @"关闭";
        [self.animationView startOrEndAnimation:YES];
    }
}
#pragma mark -
#pragma mark   ==============animation==============
- (void)startAnimation {
    switch (self.type) {
        case 0:
            [self frameOfAnimations];
            break;
        case 1:
            [self particleOfAnimations];
            break;
        case 2:
            [self radarOfAnimations];
            break;
        default:
            break;
    }
}
#pragma mark -
#pragma mark   ============================
- (void)frameOfAnimations {
    AnimationView *ani = [[AnimationView alloc] initWithFrame:self.view.bounds];
    ani.count = 24;
    [self.view addSubview:ani];
    self.animationView = ani;
    [ani startOrEndAnimation:YES];
}

- (void)particleOfAnimations {
    AnimationView *ani = [[AnimationView alloc] initWithFrame:self.view.bounds];
    [ani touchLayer];
    [self.view addSubview:ani];
    self.animationView = ani;
}
- (void)radarOfAnimations {
    AnimationView *ani = [[AnimationView alloc] initWithFrame:self.view.bounds];
    [ani radAnimation:[UIColor cyanColor]];
    [self.view addSubview:ani];
    self.animationView = ani;
}
#pragma mark -
#pragma mark   ============================
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.type == 1 && self.animationView) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.animationView];
        [self.animationView manualOperationTouchAtPosition:point];
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.type == 1 && self.animationView) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.animationView];
        [self.animationView manualOperationTouchAtPosition:point];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
