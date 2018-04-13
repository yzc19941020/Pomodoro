//
//  TomatoClock.m
//  Pomodoro
//
//  Created by Yzc's mac on 2018/4/14.
//  Copyright © 2018年 Yzc. All rights reserved.
//

#import "TomatoClock.h"

@implementation TomatoClock
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.finishDate forKey:@"finishDate"];
    [aCoder encodeBool:self.isSuccess forKey:@"isSuccess"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.finishDate = [aDecoder decodeObjectForKey:@"finishDate"];
        self.isSuccess = [aDecoder decodeBoolForKey:@"isSuccess"];
    }
    return self;
}
@end
