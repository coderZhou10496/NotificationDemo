//
//  ZJNotificationCenter.h
//  NotificationDemo
//
//  Created by watchnail on 2018/8/28.
//  Copyright © 2018年 watchnail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJNotificationCenter : NSObject

+ (instancetype)defaultCenter;

/**
 注册,添加监听者
 */
- (void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)name object:(id)object;

/**
 发送通知
 */
- (void)postNotificationName:(NSString *)name object:(id)object;

@end
