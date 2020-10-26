//
//  YQQPieChartModel.m
//  Example
//
//  Created by zhuyi on 2020/10/15.
//

#import "YQQPieChartModel.h"

@interface YQQPieChartModel ()

// 标签的高度
@property (nonatomic, assign) CGFloat titleLabelHeight;
// 水平线的宽度
@property (nonatomic, assign) CGFloat horizontalLineLength;
// 延展线和标签的距离
@property (nonatomic, assign) CGFloat margin;
// 延长线每次的增量
@property (nonatomic, assign) CGFloat increment;


@end

@implementation YQQPieChartModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _increment = 20;
        _titleLabelHeight = 14;
        _horizontalLineLength = 10;
        _margin = 5;
    }
    return self;
}

- (void)setJoinPoint:(CGPoint)joinPoint {
    if (!self.lastModel) {
        _joinPoint = joinPoint;
    } else {
        if (self.quadrant == YQQPieChartModelQuadrantFirst) {
            if (fabs(joinPoint.y - self.lastModel.joinPoint.y) < _increment) {
                self.lastModel.joinPoint = CGPointMake(self.lastModel.joinPoint.x, self.lastModel.joinPoint.y - _increment);
                _joinPoint = joinPoint;
            } else {
                _joinPoint = joinPoint;
            }
        } else if (self.quadrant == YQQPieChartModelQuadrantSecond) {
            if (self.lastModel.quadrant == YQQPieChartModelQuadrantFirst) {
                if (fabs(joinPoint.y - self.lastModel.joinPoint.y) < _increment) {
                    _joinPoint = CGPointMake(joinPoint.x, joinPoint.y + _increment);
                } else {
                    _joinPoint = joinPoint;
                }
            } else {
                if (fabs(joinPoint.y - self.lastModel.joinPoint.y) < _increment || (fabs(joinPoint.y - self.lastModel.joinPoint.y) > _increment && joinPoint.y < self.lastModel.joinPoint.y)) {
                    _joinPoint = CGPointMake(joinPoint.x, self.lastModel.joinPoint.y + _increment);
                } else {
                    _joinPoint = joinPoint;
                }
            }
        } else if (self.quadrant == YQQPieChartModelQuadrantThird) {
            if (self.lastModel.quadrant == YQQPieChartModelQuadrantSecond) {
                _joinPoint = joinPoint;
            } else {
                if (fabs(joinPoint.y - self.lastModel.joinPoint.y) < _increment) {
                    self.lastModel.joinPoint = CGPointMake(self.lastModel.joinPoint.x, self.lastModel.joinPoint.y + _increment);
                    _joinPoint = joinPoint;
                } else {
                    _joinPoint = joinPoint;
                }
            }
        } else {
            if (self.lastModel.quadrant == YQQPieChartModelQuadrantThird) {
                if (fabs(joinPoint.y - self.lastModel.joinPoint.y) < _increment) {
                    _joinPoint = CGPointMake(joinPoint.x, joinPoint.y - _increment);
                } else {
                    _joinPoint = joinPoint;
                }
            } else {
                if (fabs(joinPoint.y - self.lastModel.joinPoint.y) < _increment || (fabs(joinPoint.y - self.lastModel.joinPoint.y) > _increment && joinPoint.y > self.lastModel.joinPoint.y)) {
                    _joinPoint = CGPointMake(joinPoint.x, self.lastModel.joinPoint.y - _increment);
                } else {
                    _joinPoint = joinPoint;
                }
            }
        }
    }
    
    NSString *newTitle = [NSString stringWithFormat:@"%@ %ld", _title, (long)_number.integerValue];
    CGRect newTitleRect = [newTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, _titleLabelHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:10]} context:nil];
    
    if (_middleAngle >= -M_PI / 2.0 && _middleAngle <= M_PI / 2) {
        _capPoint = CGPointMake(_joinPoint.x + _horizontalLineLength, _joinPoint.y);
        _titleRect = CGRectMake(_joinPoint.x + _horizontalLineLength + _margin, _joinPoint.y - newTitleRect.size.height / 2.0, newTitleRect.size.width, newTitleRect.size.height);
    } else {
        _capPoint = CGPointMake(_joinPoint.x - _horizontalLineLength, _joinPoint.y);
        _titleRect = CGRectMake(_joinPoint.x - _horizontalLineLength - _margin - newTitleRect.size.width, _joinPoint.y - newTitleRect.size.height / 2.0, newTitleRect.size.width, newTitleRect.size.height);
    }
}

@end
