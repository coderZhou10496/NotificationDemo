//
//  ViewController.m
//  NotificationDemo
//
//  Created by watchnail on 2018/8/28.
//  Copyright © 2018年 watchnail. All rights reserved.
//

#import "ViewController.h"
#import "ZJNotificationCenter.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ZJNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification:) name:@"TestNotificationName" object:nil];
    
}
- (void)didReceiveNotification:(NSNotification *)notification {
    NSLog(@"ViewController didReceiveNotification");
    
}

@end
