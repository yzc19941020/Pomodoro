//
//  TimeViewController.m
//  Pomodoro
//
//  Created by Yzc's mac on 2018/4/8.
//  Copyright © 2018年 Yzc. All rights reserved.
//

#import "TimeViewController.h"

@interface TimeViewController ()

@property (nonatomic) NSInteger remainTime;
@property (nonatomic) NSInteger restTime;
@property (nonatomic) NSInteger rest;
@property (nonatomic) NSInteger currentTime;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic) BOOL isRest;
@property (nonatomic) BOOL isSuccess;
@property (nonatomic, weak) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainLabel;
@property (weak, nonatomic) IBOutlet UILabel *restLabel;
@property (weak, nonatomic) IBOutlet UIButton *tipButton;
@property (weak, nonatomic) IBOutlet UIImageView *fruitImageView;
@property (weak, nonatomic) IBOutlet UILabel *finishLabel;
@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet UIView *tipPlane;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipTitleLabel;

@end

@implementation TimeViewController

- (instancetype)initWithTitle:(NSString *)title
                   remainTime:(NSInteger)remainTime
                          restTime:(NSInteger)restTime
                              rest:(NSInteger)rest {
    self = [super init];
    if (self) {
        self.titleStr = title;
        self.remainTime = remainTime;
        self.restTime = restTime;
        self.rest = rest;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleLabel.text = _titleStr ? _titleStr : @"";
    _tipTitleLabel.text = _titleStr ? _titleStr : @"";
    
    _tipLabel.text = @"下次休息";
    _remainLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", _remainTime / 60, _remainTime % 60];
    _restLabel.text = [NSString stringWithFormat:@"%ld", (long)_rest];
    
    _tipButton.hidden = YES;
    
    switch (_remainTime / 60) {
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
    
    _tipView.layer.cornerRadius = 8.0f;
    
    _currentTime = _remainTime;
    _isRest = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showFinishedState)
                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showFinishedState)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    if (_timer) {
        [_timer invalidate];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)startForNotRest {
    _isRest = NO;
    _currentTime = _remainTime;
    _tipLabel.text = @"下次休息";
    _remainLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", _currentTime / 60, _currentTime % 60];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

- (void)startForRest {
    _isRest = YES;
    _rest--;
    _restLabel.text = [NSString stringWithFormat:@"%ld", (long)_rest];
    _currentTime = _restTime;
    _tipLabel.text = @"正在休息";
    _remainLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", _currentTime / 60, _currentTime % 60];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

- (void)updateTime {
    if (_currentTime > 0) {
        _currentTime--;
        _remainLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", _currentTime / 60, _currentTime % 60];
    } else if (_currentTime == 0) {
//        _remainLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", _currentTime / 60, _currentTime % 60];
        [self checkTipButtonText];
    }
}

- (void)checkTipButtonText {
    [_timer invalidate];
    if (!_isRest) {
        if (_rest > 0) {
            [_tipButton setTitle:@"开始休息" forState:UIControlStateNormal];
        } else {
            [_tipButton setTitle:@"已完成，点击结束" forState:UIControlStateNormal];
        }
    } else {
        [_tipButton setTitle:@"休息结束，点击继续" forState:UIControlStateNormal];
    }
    [_tipButton sizeToFit];
    _tipButton.hidden = NO;
}

- (void)finishSuccess {
    _isSuccess = YES;
    [self showFinishedState];
}

- (IBAction)tipButtonHandler:(UIButton *)sender {
    if (!_isRest) {
        if (_rest > 0) {
            [self startForRest];
            [_tipButton setTitle:@"" forState:UIControlStateNormal];
        } else {
            [self finishSuccess];
        }
    } else {
        [self startForNotRest];
        [_tipButton setTitle:@"" forState:UIControlStateNormal];
    }
    _tipButton.hidden = YES;
}

- (void)showFinishedState {
    [_timer invalidate];
    _tipPlane.hidden = NO;
    if (_isSuccess) {
        _finishLabel.text = @"恭喜！本次番茄钟成功完成！";
    } else {
        _finishLabel.text = @"很遗憾！本次番茄钟未完成！";
    }
}

- (IBAction)finishHandler:(UIButton *)sender {
    [self goBack];
}

- (IBAction)backHandler:(UIButton *)sender {
    [self showFinishedState];
}

- (void)goBack {
    NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
    [tmpArray removeObject:tmpArray[tmpArray.count - 2]];
    self.navigationController.viewControllers = tmpArray;
    [self.navigationController popViewControllerAnimated:YES];
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
