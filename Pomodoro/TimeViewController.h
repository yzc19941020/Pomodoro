//
//  TimeViewController.h
//  Pomodoro
//
//  Created by Yzc's mac on 2018/4/8.
//  Copyright © 2018年 Yzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "constant.h"

@interface TimeViewController : UIViewController

- (instancetype)initWithTitle:(NSString *)title
                   remainTime:(NSInteger)remainTime
                          restTime:(NSInteger)restTime
                              rest:(NSInteger)rest;

@end
