//
//  ZJNotificationCenter.m
//  NotificationDemo
//
//  Created by watchnail on 2018/8/28.
//  Copyright © 2018年 watchnail. All rights reserved.
//

#import "ZJNotificationCenter.h"
#import <pthread.h>
#import <objc/runtime.h>

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
    block();\
} else {\
    dispatch_async(dispatch_get_main_queue(), block);\
}
#endif


@interface ZJNotificationTag: NSObject
@property (nonatomic, weak) id observer;

@end
@implementation ZJNotificationTag
- (void)setObserver:(id)observer {
    _observer = observer;
    
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self.observer];
}
@end


@interface NSObject (Tag)
@property (nonatomic, strong) ZJNotificationTag *tag;
@end

static void *NSObject_ZJTag_Key = &NSObject_ZJTag_Key;

@implementation NSObject (ZJTag)

- (void)setTag:(ZJNotificationTag *)tag {
    objc_setAssociatedObject(self, NSObject_ZJTag_Key, tag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(ZJNotificationTag *)tag {
    return (ZJNotificationTag *)objc_getAssociatedObject(self, NSObject_ZJTag_Key);
}

@end


@implementation ZJNotificationCenter {
    
    NSMutableDictionary <NSString*, NSHashTable*>*_dic;
    pthread_mutex_t _lock;
    
}

#pragma mark - init

+ (instancetype)defaultCenter {
    static dispatch_once_t onceToken;
    static ZJNotificationCenter *center;
    dispatch_once(&onceToken, ^{
        center = [[ZJNotificationCenter alloc] init];
    });
    return center;
}
- (id)init {
    _dic = @{}.mutableCopy;
    pthread_mutex_init(&_lock, NULL);
    return self;
}

#pragma mark - private

- (void)_addObserver:(id)observer
            selector:(SEL)selector
                name:(NSString *)name
              object:(id)object
           hashTable:(NSHashTable *)hashTable{
    
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:object];
    
    NSObject *_observer = (NSObject *)observer;
    if(!_observer.tag){
        ZJNotificationTag *tag = [[ZJNotificationTag alloc] init];
        _observer.tag = tag;
        tag.observer = _observer;
    }
    [hashTable addObject:observer];
}

#pragma mark - public

- (void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)name object:(id)object {
    
    if(name == nil || observer == nil) {
        return;
    }
    
    pthread_mutex_lock(&_lock);
    
    NSHashTable *hashTable = [_dic objectForKey:name];
    if(!hashTable) {
        hashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
        [self _addObserver:observer selector:selector name:name object:object hashTable:hashTable];
    }
    else {
        if(![hashTable containsObject:observer]) {
            [self _addObserver:observer selector:selector name:name object:object hashTable:hashTable];
        }
    }
    [_dic setObject:hashTable forKey:name];

    pthread_mutex_unlock(&_lock);
}

- (void)postNotificationName:(NSString *)name object:(id)object {
    
    dispatch_main_async_safe(^{
        [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
    });
    
}
@end
