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

@interface ViewController ()<XZTableViewDataSource>

@property (nonatomic,strong) XZTableView * tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[XZTableView alloc] initWithFrame:CGRectMake(0, 20, SCREEB_SIZE.width, SCREEB_SIZE.height - 20)];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfRows {
    return 30;
}

- (nullable __kindof XZTableViewCell *)cellForRow:(NSInteger)row {
    NSString * ident = @"cell";
    XZTableViewCell * cell = [[XZTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
    cell.textLabel.text = [NSString stringWithFormat:@"测试%ld", (long)row];
    return cell;
}

@end

