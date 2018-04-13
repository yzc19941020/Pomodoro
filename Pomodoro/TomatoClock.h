//
//  TomatoClock.h
//  Pomodoro
//
//  Created by Yzc's mac on 2018/4/14.
//  Copyright © 2018年 Yzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TomatoClock : NSObject <NSCoding>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *finishDate;
@property (nonatomic) BOOL isSuccess;

@end
