//
//  XZTableViewCell.m
//  XZTableViewTest
//
//  Created by 方振兴 on 2022/2/15.
//

#import "XZTableViewCell.h"

@implementation XZTableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    static int count = 0;
    if (self = [super init]) {
        _reuseIdentifier = reuseIdentifier;
        self.backgroundColor = UIColor.blueColor;
        NSLog(@"创建cell(%d)", count++);
        [self addSubview:self.textLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor.whiteColor CGColor]);
    CGContextMoveToPoint(context, 0, self.bounds.size.height - 0.5);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height - 0.5);
    CGContextStrokePath(context);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textLabel.frame = self.bounds;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:14.0f];
        _textLabel.textColor = UIColor.whiteColor;
    }
    return _textLabel;
}

@end
