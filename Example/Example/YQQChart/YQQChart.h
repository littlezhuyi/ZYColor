//
//  YQQChart.h
//  Example
//
//  Created by zhuyi on 2020/10/15.
//

#import <UIKit/UIKit.h>
#import "UIColor+YQQAdd.h"
@class YQQChart;

@protocol YQQChartDelegate <NSObject>

@optional
- (void)chart:(YQQChart *_Nullable)chart didSelectIndex:(NSInteger)index;

@end

typedef NS_ENUM(NSUInteger, YQQChartType) {
    YQQChartTypePie, // 扇形图
    YQQChartTypeHorizontalColumn, // 柱状图
    YQQChartTypeVerticalColumn,
    YQQChartTypeHorizontalLine, // 折线图
    YQQChartTypeVerticalLine
};

NS_ASSUME_NONNULL_BEGIN

@interface YQQChart : UIControl

@property (nonatomic, weak) id<YQQChartDelegate> delegate;

@property (nonatomic, assign) YQQChartType type;

// 坐标系
@property (nonatomic, strong) NSArray<NSString *> *coordinateTitles;
@property (nonatomic, strong) NSArray<UIColor *> *coordinateColors;

// 饼状图
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *pieTitles;
@property (nonatomic, strong) NSArray<NSArray<UIColor *> *> *pieColors;

@property (nonatomic, strong) NSArray<NSArray<NSNumber *> *> *values;

// 扇形图属性
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat radian;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat insideRadius;

@end

NS_ASSUME_NONNULL_END
