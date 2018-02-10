//
//  ShakeViewController.m
//  SHSnowflakesAnimation
//
//  Created by angle on 2018/2/10.
//  Copyright © 2018年 angle. All rights reserved.
//

#import "ShakeViewController.h"
#import "AnimationView.h"
#import "UIView+Layout.h"


@interface ShakeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) UILabel *shakeView;


@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.title = @"抖动动画";
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 180)];
    header.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    [header addSubview:self.shakeView];
    [self.view addSubview:header];
    [self.view addSubview:self.tableView];
}
#pragma mark -
#pragma mark   ==============UITableViewDelegate==============
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.dataArr.count) {
        [AnimationView shakeView:self.shakeView
                        duration:2
                           range:20
                       direction:(SHShakeViewDirection)(indexPath.row + 1)
                      completion:^{
                          self.shakeView.textColor = [self colorArc4random];
                      }];
    }
}
- (UIColor *)colorArc4random {
    
    float red = arc4random()%256 / 255.0;
    float bule = arc4random()%256 / 255.0;
    float green = arc4random()%256 / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:bule alpha:1.0];
}
#pragma mark -
#pragma mark   ==============UITableViewDataSource==============
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    if (indexPath.row < self.dataArr.count) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row]];
    }
    return cell;
}

#pragma mark -
#pragma mark   ==============lazy==============
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@"左右---抖动动画",
                     @"左上---抖动动画",
                     @"左下---抖动动画",
                     @"右左---抖动动画",
                     @"右上---抖动动画",
                     @"右下---抖动动画",
                     @"上下---抖动动画",
                     @"上左---抖动动画",
                     @"上右---抖动动画",
                     @"下上---抖动动画",
                     @"下左---抖动动画",
                     @"下右---抖动动画"];
    }
    return _dataArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, self.view.width, self.view.height - 180 - 64)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
        [_tableView setTableFooterView:[UIView new]];
    }
    return _tableView;
}
- (UILabel *)shakeView {
    if (!_shakeView) {
        _shakeView = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width * 0.5 - 25, 65, 50, 50)];
        _shakeView.backgroundColor = [UIColor cyanColor];
        _shakeView.text = @"看我看我";
        _shakeView.font = [UIFont systemFontOfSize:12];
        _shakeView.textColor = [UIColor redColor];
        _shakeView.clipsToBounds = YES;
        _shakeView.layer.cornerRadius = 25;
    }
    return _shakeView;
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
