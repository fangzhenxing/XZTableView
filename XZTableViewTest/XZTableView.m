//
//  XZTableView.m
//  XZTableViewTest
//
//  Created by 方振兴 on 2022/2/15.
//

#import "XZTableView.h"
#import "XZTableViewCell.h"

@interface XZTableView ()
{
    //可复用的一组单元格
    NSMutableDictionary<NSString *, NSMutableArray<XZTableViewCell *> *> *_reuseCells;
}

@end

@implementation XZTableView

@dynamic delegate;

/// 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        
        _reuseCells = [NSMutableDictionary dictionary];
    }
    return self;
}

/// 固定行高
const float SHC_ROW_HEIGHT = 50.0f;

- (void)reloadData {
    //设置scrollView的高度
    self.contentSize = CGSizeMake(self.bounds.size.width, [self.dataSource numberOfRows] * SHC_ROW_HEIGHT);
    
    //初始化cell
    for (int row = 0; row < [self.dataSource numberOfRows]; row++) {
        //每个cell的y坐标
        float topEdgeForRow = row * SHC_ROW_HEIGHT;
        //若将要添加的cell位置不在可视区域内，则不添加
        if (self.window.frame.size.height <= [self convertPoint:CGPointMake(0, topEdgeForRow) toView:self.window].y) continue;
        //每个cell的位置
        CGRect frame = CGRectMake(0, topEdgeForRow, self.frame.size.width, SHC_ROW_HEIGHT);
        //获得cell
        XZTableViewCell * cell = [self.dataSource cellForRow:row];
        cell.frame = frame;
        //添加到视图
        [self addSubview:cell];
        
        if ([self.delegate respondsToSelector:@selector(tableView:willDisplayCell:forRow:)]) {
            [self.delegate tableView:self willDisplayCell:cell forRow:cell.tag];
        }
    }
}

/// 通过添加一组复用单元格，并从视图中删除它来循环单元格
- (void)recycleCell:(XZTableViewCell *)cell {
    NSMutableArray *cellArr = [_reuseCells valueForKey:cell.reuseIdentifier];
    if (!cellArr) {
        cellArr = [NSMutableArray arrayWithObject:cell];
        [_reuseCells setValue:cellArr forKey:cell.reuseIdentifier];
    } else {
        [cellArr addObject:cell];
    }
    [cell removeFromSuperview];
}

- (NSArray *)allCells {
    NSMutableArray *allCells = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if (![view isKindOfClass:[XZTableViewCell class]]) continue;
        
        [allCells addObject:view];
    }
    return allCells.copy;
}

- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset:contentOffset];
    
    //删除不再可见的cell
    for (XZTableViewCell * cell in [self allCells]) {
        CGRect rect = [self convertRect:cell.frame toView:self.window];
        //需要保留 1.完全在屏幕内的 2.部分在屏幕内的
        //需要移除 1.滑出顶部的cell 2.滑入底部的cell
        if (CGRectGetMaxY(rect) <= 0 || rect.origin.y > self.window.frame.size.height) {
            [self recycleCell:cell];
            if ([self.delegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRow:)]) {
                [self.delegate tableView:self didEndDisplayingCell:cell forRow:cell.tag];
            }
        }
    }
    
    XZTableViewCell * firstCell = [self allCells].firstObject;
    XZTableViewCell * lastCell = [self allCells].lastObject;
    CGRect firstCellRect = [self convertRect:firstCell.frame toView:self.window];
    CGRect lastCellRect = [self convertRect:lastCell.frame toView:self.window];
    if (firstCell && firstCellRect.origin.y > 0 && firstCell.tag > 0) {
        XZTableViewCell *newCell = [self.dataSource cellForRow:firstCell.tag - 1];
        [self insertSubview:newCell atIndex:0];
        newCell.frame = CGRectMake(0, firstCell.frame.origin.y - SHC_ROW_HEIGHT, firstCell.frame.size.width, firstCell.frame.size.height);
        if ([self.delegate respondsToSelector:@selector(tableView:willDisplayCell:forRow:)]) {
            [self.delegate tableView:self willDisplayCell:newCell forRow:newCell.tag];
        }
    }
    if (lastCell && CGRectGetMaxY(lastCellRect) < self.window.frame.size.height && lastCell.tag < [self.dataSource numberOfRows] - 1) {
        XZTableViewCell *newCell = [self.dataSource cellForRow:lastCell.tag + 1];
        [self addSubview:newCell];
        newCell.frame = CGRectMake(0, lastCell.frame.origin.y + SHC_ROW_HEIGHT, lastCell.frame.size.width, lastCell.frame.size.height);
        if ([self.delegate respondsToSelector:@selector(tableView:willDisplayCell:forRow:)]) {
            [self.delegate tableView:self willDisplayCell:newCell forRow:newCell.tag];
        }
    }
}

- (__kindof XZTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    NSMutableArray *cellArr = [_reuseCells valueForKey:identifier];
    if (cellArr.count > 0) {
        XZTableViewCell *cell = cellArr.firstObject;
        [cellArr removeObject:cell];
        return cell;
    }
    return nil;
}

@end
