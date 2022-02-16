//
//  ViewController.m
//  XZTableViewTest
//
//  Created by 方振兴 on 2022/2/15.
//

#import "ViewController.h"
#import "XZTableView.h"
#import "XZTableViewCell.h"

#define SCREEB_SIZE [UIScreen mainScreen].bounds.size

@interface ViewController ()<XZTableViewDataSource, XZTableViewDelegate>

@property (nonatomic,strong) XZTableView * tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[XZTableView alloc] initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 假装给了数据
    [self.tableView reloadData];
}

#pragma mark - datasource
- (NSInteger)numberOfRows {
    return 30;
}

- (nullable __kindof XZTableViewCell *)cellForRow:(NSUInteger)row {
    NSString * identify = @"cell";
    XZTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[XZTableViewCell alloc] initWithReuseIdentifier:identify];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试%ld", (long)row];
    cell.tag = row;
    return cell;
}

#pragma mark - delegate
- (void)tableView:(XZTableView *)tableView willDisplayCell:(XZTableViewCell *)cell forRow:(NSUInteger)row {
    NSLog(@"cell(%lu)出现了", (unsigned long)row);
}

- (void)tableView:(XZTableView *)tableView didEndDisplayingCell:(XZTableViewCell *)cell forRow:(NSUInteger)row {
    NSLog(@"cell(%lu)不见了", (unsigned long)row);
}

@end

