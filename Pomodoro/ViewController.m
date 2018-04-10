//
//  ViewController.m
//  Pomodoro
//
//  Created by Yzc's mac on 2018/4/2.
//  Copyright © 2018年 Yzc. All rights reserved.
//

#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width

@import PureLayout;

#import "ViewController.h"
#import "TimeStartViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *fruitList;
@property (nonatomic, strong) NSArray *viewList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    self.navigationController.navigationBarHidden = YES;
    [self setupSubView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubView {
    _fruitList = @[@(FruitListCherry), @(FruitListApple), @(FruitListPear), @(FruitListBanana), @(FruitListWatermelon)];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.3, screenWidth, screenHeight * 0.7)];
    _scrollView.contentSize = CGSizeMake(screenWidth * _fruitList.count, screenHeight * 0.7);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _fruitList.count; i++) {
        UIView *view = [UIView new];
//        view.backgroundColor = [UIColor blueColor];
        
        UIButton *button = [UIButton new];
//        button.backgroundColor = [UIColor redColor];
        switch (i) {
            case 0:
                [button setImage:[UIImage imageNamed:@"cherry.png"] forState:UIControlStateNormal];
                break;
            case 1:
                [button setImage:[UIImage imageNamed:@"apple.png"] forState:UIControlStateNormal];
                break;
            case 2:
                [button setImage:[UIImage imageNamed:@"pear.png"] forState:UIControlStateNormal];
                break;
            case 3:
                [button setImage:[UIImage imageNamed:@"banana.png"] forState:UIControlStateNormal];
                break;
            case 4:
                [button setImage:[UIImage imageNamed:@"watermelon.png"] forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        button.tag = [_fruitList[i] integerValue];
        [view addSubview:button];
        [button autoSetDimensionsToSize:CGSizeMake(300, 300)];
        [button autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
        [button autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [button addTarget:self action:@selector(buttonHandler:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [UILabel new];
        label.text = [NSString stringWithFormat:@"test %d", i];
        [view addSubview:label];
        [label autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [label autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_scrollView addSubview:view];
        [view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:screenWidth * i];
        [view autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [view autoSetDimensionsToSize:CGSizeMake(screenWidth, screenHeight * 0.7)];
        
        [array addObject:view];
    }
    [self.view addSubview:_scrollView];
    _viewList = [array copy];
}

- (void)buttonHandler:(UIButton *)sender {
    UIViewController *vc = [[TimeStartViewController alloc] initWithTime:sender.tag];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
