//
//  ViewController.m
//  线程保活的封装
//
//  Created by 李雅珠 on 2020/10/9.
//  Copyright © 2020 李雅珠. All rights reserved.
//

#import "ViewController.h"
#import "YZPermenantThread.h"

@interface ViewController ()

@property (nonatomic, strong) YZPermenantThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.thread = [[YZPermenantThread alloc] init];
    [self.thread executeTask:^{
        NSLog(@"执行任务 - %@", [NSThread currentThread]);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.thread stop];
}


@end
