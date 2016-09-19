//
//  JGDownloadController.m
//  AudioAndVideoDemo
//
//  Created by stkcctv on 16/9/19.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGDownloadController.h"
#import "JGDownloadCell.h"
#import "MCDownloadManager.h"

@interface JGDownloadController ()

@property (strong, nonatomic) NSMutableArray *urls;

@end

static NSString * const JGDownloadCellID = @"JGDownloadCellID";

@implementation JGDownloadController

- (NSMutableArray *)urls
{
    if (!_urls) {
        _urls = [NSMutableArray array];
        for (int i = 1; i<=10; i++) {
            [_urls addObject:[NSString stringWithFormat:@"http://120.25.226.186:32812/resources/videos/minion_%02d.mp4", i]];
        }
    }
    return _urls;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.tableView.rowHeight = 100;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JGDownloadCell class]) bundle:nil] forCellReuseIdentifier:JGDownloadCellID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.urls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JGDownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:JGDownloadCellID forIndexPath:indexPath];
    
    cell.url = _urls[indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [[MCDownloadManager defaultInstance] removeWithURL:_urls[indexPath.row]];
        [self.tableView reloadData];
    }
}

@end
