//
//  HelpViewController.m
//  Pomodoro
//
//  Created by Yzc's mac on 2018/4/13.
//  Copyright © 2018年 Yzc. All rights reserved.
//

#import "HelpViewController.h"
@import PureLayout;

@interface HelpViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;
@property (weak, nonatomic) IBOutlet UITextView *textView3;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [_textView1 sizeToFit];
    [_textView1 autoSetDimension:ALDimensionHeight toSize:_textView1.frame.size.height];
    
    [_textView2 sizeToFit];
    [_textView2 autoSetDimension:ALDimensionHeight toSize:_textView2.frame.size.height];
    
    [_textView3 sizeToFit];
    [_textView3 autoSetDimension:ALDimensionHeight toSize:_textView3.frame.size.height];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonHandler:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
