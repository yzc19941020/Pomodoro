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
@property (nonatomic) BOOL isRest;
@property (nonatomic) BOOL isSuccess;
@property (nonatomic, weak) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainLabel;
@property (weak, nonatomic) IBOutlet UILabel *restLabel;
@property (weak, nonatomic) IBOutlet UIButton *tipButton;

@end

@implementation TimeViewController

- (instancetype)initWithRemainTime:(NSInteger)remainTime
                          restTime:(NSInteger)restTime
                              rest:(NSInteger)rest {
    self = [super init];
    if (self) {
        self.remainTime = remainTime;
        self.restTime = restTime;
        self.rest = rest;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tipLabel.text = @"下次休息";
    _remainLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", _remainTime / 60, _remainTime % 60];
    _restLabel.text = [NSString stringWithFormat:@"%ld", (long)_rest];
    
    _tipButton.hidden = YES;
    
    _currentTime = _remainTime;
    _isRest = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didFailed)
                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didFailed)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    [_timer invalidate];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didFailed {
    _isSuccess = NO;
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
//            [self startForRest];
        } else {
            [_tipButton setTitle:@"已完成，点击结束" forState:UIControlStateNormal];
//            [self finishTime];
        }
    } else {
        [_tipButton setTitle:@"休息结束，点击继续" forState:UIControlStateNormal];
//        [self startForNotRest];
    }
    _tipButton.hidden = NO;
}

- (void)finishTime {
    _isSuccess = YES;
//    [_timer invalidate];
    [self goBack];
}

- (IBAction)tipButtonHandler:(UIButton *)sender {
    if (!_isRest) {
        if (_rest > 0) {
            [self startForRest];
            _tipButton.hidden = YES;
            [_tipButton setTitle:@"" forState:UIControlStateNormal];
        } else {
            [self finishTime];
        }
    } else {
        [self startForNotRest];
        _tipButton.hidden = YES;
        [_tipButton setTitle:@"" forState:UIControlStateNormal];
    }
}

- (IBAction)backHandler:(UIButton *)sender {
    [self goBack];
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
