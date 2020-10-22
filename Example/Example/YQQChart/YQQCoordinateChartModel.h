//
//  YQQCoordinateChartModel.h
//  Example
//
//  Created by zhuyi on 2020/10/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQQCoordinateChartModel : NSObject

@property (nonatomic, assign) CGPoint coordinatePoint;
// 标签文案
@property (nonatomic, copy) NSString *text;
// 标签Frame
@property (nonatomic, assign) CGRect labelFrame;
// 数据
@property (nonatomic, strong) NSArray *values;
// 颜色
@property (nonatomic, strong) NSArray *colors;
// 数据的坐标点
@property (nonatomic, strong) NSArray *valuePointArray;

@end

NS_ASSUME_NONNULL_END
