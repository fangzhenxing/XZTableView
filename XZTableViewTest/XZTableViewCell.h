//
//  XZTableViewCell.h
//  XZTableViewTest
//
//  Created by 方振兴 on 2022/2/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZTableViewCell : UIView

@property(nonatomic, strong)UILabel *textLabel;

@property (nonatomic, readonly, copy, nullable) NSString *reuseIdentifier;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
