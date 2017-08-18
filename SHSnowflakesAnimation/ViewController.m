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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"❄️关闭" style:UIBarButtonItemStylePlain target:self action:@selector(startOrEnd:)];
    
    
    AnimationView *ani = [[AnimationView alloc] initWithFrame:self.view.bounds];
    
    ani.count = 24;
    
    [self.view addSubview:ani];
    
    self.animationView = ani;
    
    [ani startOrEndAnimation:YES];
    
}

- (void)startOrEnd:(UIBarButtonItem *)bar {
    if ([bar.title isEqualToString:@"❄️启动"]) {
        bar.title = @"❄️关闭";
        [self.animationView startOrEndAnimation:YES];
    }else {
        bar.title = @"❄️启动";
        [self.animationView startOrEndAnimation:NO];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
