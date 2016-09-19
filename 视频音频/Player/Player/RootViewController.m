//
//  RootViewController.m
//  Player
//
//  Created by dllo on 15/11/9.
//  Copyright © 2015年 zhaoqingwen. All rights reserved.
//

#import "RootViewController.h"
#import "MoviePlayerViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (void)buttonAction
{
    MoviePlayerViewController *movie = [[MoviePlayerViewController alloc]init];
//    [self.navigationController pushViewController:movie animated:NO];
//    movie.modalTransitionStyle = 0;
    [self presentViewController:movie animated:YES completion:^{
    
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
