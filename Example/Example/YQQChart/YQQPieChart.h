//
//  YQQChart.h
//  Example
//
//  Created by zhuyi on 2020/10/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQQPieChart : UIControl

@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *pieTitles;

@property (nonatomic, strong) NSArray<NSArray<UIColor *> *> *pieColors;

@property (nonatomic, strong) NSArray<NSArray<NSNumber *> *> *pieValues;

@property (nonatomic, assign) CGFloat startAngle;

@property (nonatomic, assign) CGFloat radian;

@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, assign) CGFloat insideRadius;

@end

NS_ASSUME_NONNULL_END
