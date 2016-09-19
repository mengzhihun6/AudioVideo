//
//  JGVedioViewController.m
//  视频音频-Demo
//
//  Created by stkcctv on 16/8/26.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGVedioViewController.h"
#import "WMPlayer.h"
#import "JGVedioModel.h"
#import "JGVedioViewCell.h"

@interface JGVedioViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArrM;

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString * const JGVedioCellId = @"JGVedioCellId";

@implementation JGVedioViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createTable];
    
    
    [self getNetData];
}

- (void)createTable {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 270;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JGVedioViewCell class]) bundle:nil] forCellReuseIdentifier:JGVedioCellId];
}

#pragma mark - 懒加载 -
- (NSMutableArray *)dataArrM {
    
    if (!_dataArrM) {
        _dataArrM = [NSMutableArray array];
    }
    
    return _dataArrM;
}

#pragma mark - <UITableViewDataSouse> -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JGVedioViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JGVedioCellId forIndexPath:indexPath];
    
    JGVedioModel *model = [_dataArrM objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}



#pragma mark - 加载数据 -
- (void)getNetData {
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"newlist";
    params[@"c"] = @"data";
    params[@"type"] = @(41);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = responseObject[@"list"];
        
        for (NSDictionary *dict in array) {
            JGVedioModel *model = [[JGVedioModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArrM addObject:model];
            
        }
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
        
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
