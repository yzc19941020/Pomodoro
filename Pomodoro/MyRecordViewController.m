//
//  MyRecordViewController.m
//  Pomodoro
//
//  Created by Yzc's mac on 2018/4/14.
//  Copyright © 2018年 Yzc. All rights reserved.
//

#import "MyRecordViewController.h"
#import "TomatoClock.h"
@import PureLayout;

@interface MyRecordViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *clockArray;

@end

@implementation MyRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)clockArray {
    if (_clockArray == nil) {
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [documentPath stringByAppendingPathComponent:@"clockArray.plist"];
        
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        NSMutableArray *tmpArray = [NSMutableArray new];
        if (array == nil) {
            array = [NSArray array];
        }
        for (int64_t i = array.count - 1; i >= 0; i--) {
            [tmpArray addObject:array[i]];
        }
        _clockArray = [tmpArray copy];
    }
    return _clockArray;
}

- (IBAction)backHandler:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.clockArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"clockCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"clockCell"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    TomatoClock *tmpClock = self.clockArray[indexPath.row];
    cell.textLabel.text = tmpClock.title;
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    cell.detailTextLabel.text = tmpClock.finishDate;
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = tmpClock.isSuccess ? [UIColor blueColor] : [UIColor redColor];
    label.text = tmpClock.isSuccess ? @"已完成" : @"未完成";
    [cell.contentView addSubview:label];
    [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
    [label autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [label sizeToFit];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
