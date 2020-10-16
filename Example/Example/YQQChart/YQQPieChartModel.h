//
//  YQQPieChartModel.h
//  Example
//
//  Created by zhuyi on 2020/10/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQQPieChartModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, strong) NSNumber *number;
// 百分比
@property (nonatomic, assign) CGFloat percent;
// 弧度
@property (nonatomic, assign) CGFloat radian;
// 起始弧度
@property (nonatomic, assign) CGFloat startAngle;
// 中间弧度
@property (nonatomic, assign) CGFloat middleAngle;
// 延长线与圆交点
@property (nonatomic, assign) CGPoint intersectionPoint;
// 延长线转折点
@property (nonatomic, assign) CGPoint joinPoint;
// 延长线端点
@property (nonatomic, assign) CGPoint capPoint;
// 标签位置
@property (nonatomic, assign) CGRect titleRect;
// 结束弧度
@property (nonatomic, assign) CGFloat endAngle;
// 原点
@property (nonatomic, assign) CGPoint center;

@end

NS_ASSUME_NONNULL_END
