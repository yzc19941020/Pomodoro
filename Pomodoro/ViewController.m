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
    
    self.navigationController.navigationBarHidden = YES;
    [self setupSubView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubView {
    _fruitList = @[@(FruitListApple), @(FruitListLemon), @(FruitListPear), @(FruitListBanana), @(FruitListPeach)];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, screenWidth, screenHeight - 200)];
    _scrollView.contentSize = CGSizeMake(screenWidth * _fruitList.count, screenHeight - 200);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _fruitList.count; i++) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor blueColor];
        
        UIButton *button = [UIButton new];
        button.backgroundColor = [UIColor redColor];
        button.tag = 10 + i * 5;
        [view addSubview:button];
        [button autoSetDimensionsToSize:CGSizeMake(200, 200)];
        [button autoCenterInSuperview];
        [button addTarget:self action:@selector(buttonHandler:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [UILabel new];
        label.text = [NSString stringWithFormat:@"test %d", i];
        [view addSubview:label];
        [label autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [label autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_scrollView addSubview:view];
        [view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:screenWidth * i];
        [view autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [view autoSetDimensionsToSize:CGSizeMake(screenWidth, screenHeight - 200)];
        
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
