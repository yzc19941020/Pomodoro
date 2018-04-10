//
//  TimeStartViewController.m
//  Pomodoro
//
//  Created by Yzc's mac on 2018/4/8.
//  Copyright © 2018年 Yzc. All rights reserved.
//

#import "TimeStartViewController.h"
#import "TimeViewController.h"
@import HWDownSelectedView;

@interface TimeStartViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *remainTime;
@property (weak, nonatomic) IBOutlet HWDownSelectedView *restTime;
@property (weak, nonatomic) IBOutlet HWDownSelectedView *rest;
@property (weak, nonatomic) IBOutlet UIImageView *fruitImageView;

@property (nonatomic) NSInteger remainTimeSecond;

@end

@implementation TimeStartViewController

- (instancetype)initWithTime:(NSInteger)time {
    self = [super init];
    if (self) {
        self.remainTimeSecond = time * 60;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData {
    switch (_remainTimeSecond / 60) {
        case FruitListCherry:
            [_fruitImageView setImage:[UIImage imageNamed:@"cherry.png"]];
            break;
        case FruitListApple:
            [_fruitImageView setImage:[UIImage imageNamed:@"apple.png"]];
            break;
        case FruitListPear:
            [_fruitImageView setImage:[UIImage imageNamed:@"pear.png"]];
            break;
        case FruitListBanana:
            [_fruitImageView setImage:[UIImage imageNamed:@"banana.png"]];
            break;
        case FruitListWatermelon:
            [_fruitImageView setImage:[UIImage imageNamed:@"watermelon.png"]];
            break;
        default:
            break;
    }
    
    NSInteger min = _remainTimeSecond / 60;
    _remainTime.text = [NSString stringWithFormat:@"%ld:00", (long)min];
    
    _restTime.placeholder = @"请选择";
    _restTime.listArray = @[@"05:00", @"10:00", @"15:00"];
    
    _rest.placeholder = @"请选择";
    _rest.listArray = @[@"0", @"1", @"2", @"3"];
    
}

- (IBAction)backHandler:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)timeStart:(UIButton *)sender {
    UIViewController *vc = [[TimeViewController alloc] initWithRemainTime:[_remainTime.text integerValue] * 60
                                                                 restTime:[_restTime.text integerValue] * 60
                                                                     rest:[_rest.text integerValue]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_restTime close];
    [_rest close];
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
