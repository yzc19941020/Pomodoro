//
//  TimeViewController.m
//  Pomodoro
//
//  Created by Yzc's mac on 2018/4/8.
//  Copyright © 2018年 Yzc. All rights reserved.
//

#import "TimeViewController.h"

@interface TimeViewController ()

@end

@implementation TimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backHandler:(UIButton *)sender {
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
