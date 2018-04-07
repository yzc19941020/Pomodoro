//
//  TimeStartViewController.m
//  Pomodoro
//
//  Created by Yzc's mac on 2018/4/8.
//  Copyright © 2018年 Yzc. All rights reserved.
//

#import "TimeStartViewController.h"
#import "TimeViewController.h"

@interface TimeStartViewController ()

@property (weak, nonatomic) IBOutlet UITextField *remainTimeText;

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
    NSInteger min = _remainTimeSecond / 60;
    _remainTimeText.text = [NSString stringWithFormat:@"%ld:00", (long)min];
    _remainTimeText.textAlignment = NSTextAlignmentCenter;
}

- (IBAction)backHandler:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)timeStart:(UIButton *)sender {
    UIViewController *vc = [TimeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
