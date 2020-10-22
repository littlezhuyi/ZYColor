//
//  YQQChartCalculate.h
//  Example
//
//  Created by zhuyi on 2020/10/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQQChartCalculate : NSObject

+ (NSMutableArray *)calculatePieWithSize:(CGSize)size
                                  radius:(CGFloat)radius
                              startAngle:(CGFloat)startAngle
                                  radian:(CGFloat)radian
                               pieTitles:(NSArray<NSArray<NSString *> *> *)pieTitles
                               pieValues:(NSArray<NSArray<NSNumber *> *> *)pieValues
                               pieColors:(NSArray<NSArray<UIColor *> *> *)pieColors;

+ (CGFloat)calculateMaxWidthWithTitles:(NSArray<NSString *> *)titles;

+ (CGFloat)calculateTextWidth:(NSString *)text font:(UIFont *)font;

+ (NSInteger)calculateOverFlowValueWithValues:(NSArray<NSArray<NSNumber *> *> *)pieValues;

@end

NS_ASSUME_NONNULL_END
