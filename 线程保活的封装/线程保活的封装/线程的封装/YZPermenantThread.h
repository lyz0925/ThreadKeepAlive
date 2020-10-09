//
//  YZPermenantThread.h
//  线程保活的封装
//
//  Created by 李雅珠 on 2020/10/9.
//  Copyright © 2020 李雅珠. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^YZPermenantThreadTask)(void);

@interface YZPermenantThread : NSObject

/**
 在当前子线程执行一个任务
 */
- (void)executeTask:(YZPermenantThreadTask)task;

/**
 结束线程
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
