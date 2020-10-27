//
//  YQQChartCalculate.m
//  Example
//
//  Created by zhuyi on 2020/10/15.
//

#import "YQQChartCalculate.h"
#import "YQQPieChartModel.h"

@implementation YQQChartCalculate

+ (CGFloat)calculateMaxWidthWithTitles:(NSArray<NSString *> *)titles {
    CGFloat maxTitleWidth = 0;
    for (NSString *title in titles) {
        CGFloat titleWidth = [self calculateTextWidth:title font:[UIFont fontWithName:@"PingFangSC-Regular" size:10]];
        if (titleWidth > maxTitleWidth) {
            maxTitleWidth = titleWidth;
        }
    }
    return maxTitleWidth + 30;
}

// 计算文字宽度
+ (CGFloat)calculateTextWidth:(NSString *)text font:(UIFont *)font {
    NSDictionary *btAtt = @{NSFontAttributeName : font};
    CGSize textSize = CGSizeMake(MAXFLOAT, 10);
    CGRect textRect = [text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:btAtt context:nil];
    return textRect.size.width;
}

// 找出一个封顶值
+ (NSInteger)calculateOverFlowValueWithValues:(NSArray<NSArray<NSNumber *> *> *)pieValues {
    // 找出一个最大值
    CGFloat maxValue = 0;
    for (NSArray *array in pieValues) {
        CGFloat insideValue = 0;
        for (NSNumber *number in array) {
            insideValue += number.floatValue;
        }
        maxValue = MAX(maxValue, insideValue);
    }
    
    NSInteger tempMaxValue = (NSInteger)ceilf(maxValue);
    NSString *valueString = [NSString stringWithFormat:@"%ld", (long)tempMaxValue];
    if (valueString.length == 1) {
        tempMaxValue = 10;
    } else if (valueString.length == 2) {
        if (tempMaxValue % 5 != 0) {
            NSInteger remainder = tempMaxValue % 5;
            tempMaxValue = tempMaxValue + 5 - remainder;
        }
    } else if (valueString.length == 3) {
        if (tempMaxValue % 50 != 0) {
            NSInteger remainder = tempMaxValue % 50;
            tempMaxValue = tempMaxValue + 50 - remainder;
        }
    } else {
        if (tempMaxValue % 500 != 0) {
            NSInteger remainder = tempMaxValue % 500;
            tempMaxValue = tempMaxValue + 500 - remainder;
        }
    }
    return tempMaxValue;
}

+ (NSMutableArray *)calculatePieWithSize:(CGSize)size
                                  radius:(CGFloat)radius
                              startAngle:(CGFloat)startAngle
                                  radian:(CGFloat)radian
                               pieTitles:(NSArray<NSArray<NSString *> *> *)pieTitles
                               pieValues:(NSArray<NSArray<NSNumber *> *> *)pieValues
                               pieColors:(NSArray<NSArray<UIColor *> *> *)pieColors {
    CGFloat sum = 0;
    for (NSArray *array in pieValues) {
        for (NSNumber *number in array) {
            sum += number.floatValue;
        }
    }
    
    // 延长线最小长度
    CGFloat lineLength = 10;
    
    // 扇形原点
    CGPoint center = CGPointMake(0, 0);
    
    NSMutableArray *modelValues = [NSMutableArray array];
    YQQPieChartModel *lastModel;
    for (NSInteger i = 0; i < pieValues.count; i++) {
        NSArray *values = [pieValues objectAtIndex:i];
        NSArray *titles = [pieTitles objectAtIndex:i];
        NSArray *colors = [pieColors objectAtIndex:i];
        for (NSInteger j = 0; j < values.count; j++) {
            NSNumber *value = [values objectAtIndex:j];
            NSString *title = [titles objectAtIndex:j];
            UIColor *color = [colors objectAtIndex:j];
            
            YQQPieChartModel *model = [[YQQPieChartModel alloc] init];
            model.lastModel = lastModel;
            model.number = value;
            model.color = color;
            model.title = title;
            [modelValues addObject:model];
            
            model.center = center;
            model.percent = value.floatValue / sum;
            model.radian = radian * model.percent;
            if (lastModel) {
                if (CGColorEqualToColor(model.color.CGColor, model.lastModel.color.CGColor)) {
                    model.startAngle = lastModel.endAngle + M_PI / 180.0;
                } else {
                    model.startAngle = lastModel.endAngle;
                }
            } else {
                model.startAngle = startAngle;
            }
            model.middleAngle = model.startAngle + model.radian / 2.0;
            model.endAngle = model.startAngle + model.radian;
            
            CGFloat intersectionX = center.x + cos(model.middleAngle) * radius;
            CGFloat intersectionY = center.y + sin(model.middleAngle) * radius;
            model.intersectionPoint = CGPointMake(intersectionX, intersectionY);
            
            if (model.middleAngle >= -M_PI / 2.0 && model.middleAngle <= 0) {
                model.quadrant = YQQPieChartModelQuadrantFirst;
            } else if (model.middleAngle > 0 && model.middleAngle <= M_PI / 2) {
                model.quadrant = YQQPieChartModelQuadrantSecond;
            } else if (model.middleAngle > M_PI / 2 && model.middleAngle <= M_PI) {
                model.quadrant = YQQPieChartModelQuadrantThird;
            } else {
                model.quadrant = YQQPieChartModelQuadrantFourth;
            }
                        
            CGFloat joinX = center.x + cos(model.middleAngle) * (radius + lineLength);
            CGFloat joinY = center.y + sin(model.middleAngle) * (radius + lineLength);
            model.joinPoint = CGPointMake(joinX, joinY);
            
            lastModel = model;
        }
    }
    
    CGFloat maxY = 0;
    CGFloat minY = CGFLOAT_MAX;
    CGFloat maxX = 0;
    CGFloat minX = CGFLOAT_MAX;
    for (YQQPieChartModel *model in modelValues) {
        if (model.joinPoint.y > maxY) {
            maxY = model.joinPoint.y;
        }
        if (model.joinPoint.y < minY) {
            minY = model.joinPoint.y;
        }
        if (model.joinPoint.x > maxX) {
            maxX = model.joinPoint.x;
        }
        if (model.joinPoint.x < minX) {
            minX = model.joinPoint.x;
        }
    }
        
    CGFloat minOriginY = (size.height - (maxY - minY)) / 2.0;
    CGFloat minOriginX = (size.width - (maxX - minX)) / 2.0;
    CGFloat offsetY = minOriginY - minY;
    CGFloat offsetX = minOriginX - minX;
    
    for (YQQPieChartModel *model in modelValues) {
        model.intersectionPoint = CGPointMake(model.intersectionPoint.x + offsetX, model.intersectionPoint.y + offsetY);
        model.joinPoint = CGPointMake(model.joinPoint.x + offsetX, model.joinPoint.y + offsetY);
        model.center = CGPointMake(model.center.x + offsetX, model.center.y + offsetY);
    }
    return modelValues;
}

@end
