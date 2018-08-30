//
//  SecViewController.m
//  NotificationDemo
//
//  Created by watchnail on 2018/8/28.
//  Copyright © 2018年 watchnail. All rights reserved.
//

#import "SecViewController.h"
#import "ZJNotificationCenter.h"
@interface SecViewController ()

@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SecViewController";
    
    [[ZJNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification) name:@"TestNotificationName" object:nil];
    [[ZJNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification) name:@"TestNotificationName" object:nil];
    
    
    [[ZJNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification_sec) name:@"TestNotificationName_Sec" object:nil];
}
- (void)didReceiveNotification {
    NSLog(@"SecViewController didReceiveNotification");
    
}
- (void)didReceiveNotification_sec {
    NSLog(@"SecViewController didReceiveNotification_sec");
    
}


@end
