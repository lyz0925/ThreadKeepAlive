//
//  YZPermenantThread.m
//  线程保活的封装
//
//  Created by 李雅珠 on 2020/10/9.
//  Copyright © 2020 李雅珠. All rights reserved.
//

#import "YZPermenantThread.h"


/** MJThread **/
@interface YZThread : NSThread

@end

@implementation YZThread

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end


@interface YZPermenantThread()

@property (strong, nonatomic) YZThread *innerThread;

@end


@implementation YZPermenantThread

- (instancetype)init
{
    if (self = [super init]) {
        self.innerThread = [[YZThread alloc] initWithBlock:^{
            NSLog(@"begin----");
            
            // 创建上下文（要初始化一下结构体）
            CFRunLoopSourceContext context = {0};
            // 创建source
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
            // 往Runloop中添加source
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            // 销毁source
            CFRelease(source);
            // 启动
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
            
            NSLog(@"end----");
        }];
        
        [self.innerThread start];
    }
    return self;
}

- (void)executeTask:(YZPermenantThreadTask)task
{
    if (!self.innerThread || !task) return;
    
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}

- (void)stop
{
    if (!self.innerThread) return;
    
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    [self stop];
}

#pragma mark - private methods
- (void)__stop
{
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}

- (void)__executeTask:(YZPermenantThreadTask)task
{
    task();
}

@end
