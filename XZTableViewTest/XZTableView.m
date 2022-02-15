//
//  XZTableView.m
//  XZTableViewTest
//
//  Created by 方振兴 on 2022/2/15.
//

#import "XZTableView.h"
#import "XZTableViewCell.h"

@implementation XZTableView

@synthesize delegate = _delegate;

/// 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/// 更新布局
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self reloadData];
}

/// 固定行高
const float SHC_ROW_HEIGHT = 50.0f;

- (void)reloadData {
    NSLog(@"%@", [NSThread callStackSymbols]);
    
    //设置scrollView的高度
    self.contentSize = CGSizeMake(self.bounds.size.width, [self.dataSource numberOfRows] * SHC_ROW_HEIGHT);
    
    //添加cell
    for (int row = 0; row < [_dataSource numberOfRows]; row++) {
        //获得cell
        XZTableViewCell * cell = [_dataSource cellForRow:row];
        //每个cell的y坐标
        float topEdgeForRow = row * SHC_ROW_HEIGHT;
        //每个cell的位置
        CGRect frame = CGRectMake(0, topEdgeForRow, self.frame.size.width, SHC_ROW_HEIGHT);
        cell.frame = frame;
        //添加到视图
        [self addSubview:cell];
    }
}

#pragma mark - property setters
- (void)setDataSource:(id<XZTableViewDataSource>)dataSource {
    _dataSource = dataSource;
}

@end
