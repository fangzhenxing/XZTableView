//
//  XZTableView.h
//  XZTableViewTest
//
//  Created by 方振兴 on 2022/2/15.
//

#import <UIKit/UIKit.h>
@class XZTableViewCell,XZTableView;
NS_ASSUME_NONNULL_BEGIN

/// 数据源协议
@protocol XZTableViewDataSource <NSObject>

//表示表中的行数
- (NSInteger)numberOfRows;

//获取给定的单元格
- (nullable __kindof XZTableViewCell *)cellForRow:(NSUInteger)row;

@end

/// 代理协议
@protocol XZTableViewDelegate <NSObject, UIScrollViewDelegate>

@optional

- (void)tableView:(XZTableView *)tableView willDisplayCell:(XZTableViewCell *)cell forRow:(NSUInteger)row;

- (void)tableView:(XZTableView *)tableView didEndDisplayingCell:(XZTableViewCell *)cell forRow:(NSUInteger)row;

@end

@interface XZTableView : UIScrollView

@property (nonatomic, weak, nullable) id <XZTableViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id <XZTableViewDelegate> delegate;

- (void)reloadData;

- (nullable __kindof XZTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
