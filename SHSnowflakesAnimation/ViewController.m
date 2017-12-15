//
//  ViewController.m
//  SHSnowflakesAnimation
//
//  Created by angle on 2017/8/18.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "ViewController.h"

#import "AnimationView.h"


@interface ViewController ()

@property (nonatomic, strong) AnimationView *animationView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.title = @"❄️❄️❄️";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"❄️" style:UIBarButtonItemStylePlain target:self action:@selector(startOrEnd:)];
    
    
    AnimationView *ani = [[AnimationView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:ani];
    
    self.animationView = ani;
    
    [ani startOrEndAnimation:YES];
    
}

- (void)startOrEnd:(UIBarButtonItem *)bar {
    if ([bar.title isEqualToString:@"❄️"]) {
        bar.title = @"粒子动画";
        [self.animationView startOrEndAnimation:YES];
    }else if ([bar.title isEqualToString:@"粒子动画"]){
        bar.title = @"咻咻/雷达";

    }else if ([bar.title isEqualToString:@"咻咻/雷达"]){
        bar.title = @"全部";

    }else {
        bar.title = @"❄️";
        [self.animationView startOrEndAnimation:NO];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
