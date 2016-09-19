//
//  AudioPlayerViewController.m
//  视频音频-Demo
//
//  Created by stkcctv on 16/8/25.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "AudioPlayerViewController.h"
#import "JGMusicListModel.h"
#import "JGMusicListCell.h"
#import "JGMusicDetailController.h"


@interface AudioPlayerViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

static NSString *const JGMusicCellID = @"JGMusicCellID";

@implementation AudioPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getNetData];
    
    [self createTable];
    
}

- (void)createTable {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 90;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JGMusicListCell class]) bundle:nil] forCellReuseIdentifier:JGMusicCellID];
}


- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)getNetData {
    
    [JGNetWorkRequestManager requestWIthType:POST urlString:kMusicUrl parDic:nil success:^(NSData *data) {
        
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
//        JGLog(@"%@",dict);
        NSArray *array = dict[@"tracks"][@"list"];
        for (NSDictionary *dict in array) {
           
            JGMusicListModel *model = [[JGMusicListModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });

    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JGMusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:JGMusicCellID forIndexPath:indexPath];
    
    JGMusicListModel *model = [_dataArr objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailMusicVC"];
    JGMusicDetailController *detailVC = (JGMusicDetailController *)vc;
    
    [JGMusicManager shareMusicManager].musicArray = self.dataArr;
    [JGMusicManager shareMusicManager].index = indexPath.row;
    
    
//    JGLog(@"%@",vc.class);
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
    
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
