//
//  ThirdViewController.m
//  NotificationDemo
//
//  Created by watchnail on 2018/8/28.
//  Copyright © 2018年 watchnail. All rights reserved.
//

#import "ThirdViewController.h"
#import "ZJNotificationCenter.h"
@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ThirdViewController";


    [[ZJNotificationCenter defaultCenter] postNotificationName:@"TestNotificationName" object:nil];
    [[ZJNotificationCenter defaultCenter] postNotificationName:@"TestNotificationName_Sec" object:nil];
    
    [[ZJNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification_Third) name:@"TestNotificationName_Third" object:nil];;
    
}

- (void)didReceiveNotification_Third {
    
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
