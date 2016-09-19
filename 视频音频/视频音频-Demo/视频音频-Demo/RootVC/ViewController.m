//
//  ViewController.m
//  视频音频-Demo
//
//  Created by stkcctv on 16/8/25.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "ViewController.h"

#import <MediaPlayer/MediaPlayer.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
    MPMoviePlayerViewController *_moviePlayerVC;
}

/* 数据源数组  */
@property (nonatomic, strong) NSArray *dataArrM;
/* tableView  */
@property (nonatomic, weak) UITableView *tableView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataArrM = @[@"播放音频",@"播放本地视频",@"播放网络视频",@"MPMoviePlayerController",@"播放器"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView = tableView;
    self.tableView.rowHeight = 100;
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
}


#pragma mark - <UITableViewDataSource> -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = _dataArrM[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0: //音乐
        {
            UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AudioVC"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1: //本地视频
        {
            //获取播放文件路径
            NSString *path = [[NSBundle mainBundle] pathForResource:@"dzs" ofType:@"mp4"];
            //调用根据路径加载视频的方法
            [self loadMovieWithPath:path];

        }
            break;
        case 2: //网络视频
        {
            UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"VedioVC"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3: //视频多任务下载
        {
            UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DownloadVC"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4: //视频播放
        {
            UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PlayerVC"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

//加载视频的方法 根据路径
- (void)loadMovieWithPath:(NSString *)path {
    
    NSURL *url = nil;
    //判断是否是本地视频还是网络视频，如果路径前缀是http://或者https://开头 ，说明网络视频 否则是本地视频
    if ([path hasPrefix:@"http://"] || [path hasPrefix:@"https://"]) {
        //网络视频
        url = [NSURL URLWithString:path];
    }else {
        //本地视频
        url = [NSURL fileURLWithPath:path];
    }
    //根据url对象得到（创建）视频控制器对象
    _moviePlayerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    //播放play 视图控制器对象没有播放方法 是里面（属性）的moviePlayer 去播放
    [_moviePlayerVC.moviePlayer play];
    //设置普通类型视频 （资源类型）
    _moviePlayerVC.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
    
    //push跳转
    [self.navigationController pushViewController:_moviePlayerVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
