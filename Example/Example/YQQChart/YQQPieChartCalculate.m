//
//  YQQChartCalculate.m
//  Example
//
//  Created by zhuyi on 2020/10/15.
//

#import "YQQPieChartCalculate.h"
#import "YQQPieChartModel.h"

@implementation YQQPieChartCalculate

+ (NSMutableArray *)calculateWithSize:(CGSize)size
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
    CGFloat protrudentMineLineLength = 10;
    // 延长线每次的增量
    CGFloat increment = 15;
    // 延长线最大长度
    CGFloat protrudentMaxLineLength = 10 + increment;
    // 标签的高度
    CGFloat titleLabelHeight = 14;
    // 水平线的宽度
    CGFloat horizontalLineLength = 10;
    // 延展线和标签的距离
    CGFloat margin = 5;
    
    // 落在第一象限内有多少个点
    CGFloat average = sum / 4.0;
    CGFloat preSum = 0;
    for (NSArray *array in pieValues) {
        for (NSNumber *number in array) {
            preSum += number.floatValue / 2.0;
            if (preSum + number.floatValue / 2.0 < average) {
                protrudentMaxLineLength += increment;
            }
            preSum += number.floatValue;
        }
    }
    
    // 扇形原点
    CGPoint center = CGPointMake(size.width / 2.0, titleLabelHeight / 2.0 + protrudentMaxLineLength + radius);
    
    NSMutableArray *modelValues = [NSMutableArray array];
    CGFloat lastAngle = startAngle;
    CGPoint lastJoinPoint;
    for (NSInteger i = 0; i < pieValues.count; i++) {
        NSMutableArray *eleModelValues = [NSMutableArray array];
        NSArray *values = [pieValues objectAtIndex:i];
        NSArray *titles = [pieTitles objectAtIndex:i];
        NSArray *colors = [pieColors objectAtIndex:i];
        for (NSInteger j = 0; j < values.count; j++) {
            NSNumber *value = [values objectAtIndex:j];
            NSString *title = [titles objectAtIndex:j];
            UIColor *color = [colors objectAtIndex:j];
                        
            YQQPieChartModel *model = [[YQQPieChartModel alloc] init];
            model.number = value;
            model.color = color;
            model.title = title;
            [eleModelValues addObject:model];
            [modelValues addObject:eleModelValues];
            
            model.center = center;
            model.percent = value.floatValue / sum;
            model.radian = radian * model.percent;
            model.startAngle = lastAngle;
            model.middleAngle = model.startAngle + model.radian / 2.0;
            model.endAngle = model.startAngle + model.radian;
            
            CGFloat intersectionX = center.x + cos(model.middleAngle) * radius;
            CGFloat intersectionY = center.y + sin(model.middleAngle) * radius;
            model.intersectionPoint = CGPointMake(intersectionX, intersectionY);
            
            protrudentMaxLineLength -= increment;
            
            CGFloat joinX = center.x + cos(model.middleAngle) * (radius + MAX(protrudentMaxLineLength, protrudentMineLineLength));
            CGFloat joinY = center.y + sin(model.middleAngle) * (radius + MAX(protrudentMaxLineLength, protrudentMineLineLength));
            
            // 在第一象限内才会处理
            if (joinX > center.x && joinY < center.y) {
                if (fabs(joinY - lastJoinPoint.y) < increment) {
                    if (joinY >= center.y) {
                        joinY -= increment;
                    } else {
                        joinY += increment;
                    }
                }
                if (fabs(joinX - lastJoinPoint.x) < increment) {
                    if (joinX >= center.x) {
                        joinX += increment;
                    } {
                        joinX -= increment;
                    }
                }
            }
            
            model.joinPoint = CGPointMake(joinX, joinY);
            
            NSString *newTitle = [NSString stringWithFormat:@"%@ %ld", title, (long)value.integerValue];
            CGRect newTitleRect = [newTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, titleLabelHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:10]} context:nil];
            
            if (joinX >= center.x) {
                model.capPoint = CGPointMake(model.joinPoint.x + horizontalLineLength, model.joinPoint.y);
                model.titleRect = CGRectMake(model.joinPoint.x + horizontalLineLength + margin, model.joinPoint.y - newTitleRect.size.height / 2.0, newTitleRect.size.width, newTitleRect.size.height);
            } else {
                model.capPoint = CGPointMake(model.joinPoint.x - horizontalLineLength, model.joinPoint.y);
                model.titleRect = CGRectMake(model.joinPoint.x - horizontalLineLength - margin - newTitleRect.size.width, model.joinPoint.y - newTitleRect.size.height / 2.0, newTitleRect.size.width, newTitleRect.size.height);
            }
            
            lastAngle = model.endAngle;
            lastJoinPoint = model.joinPoint;
        }
    }
    return modelValues;
}

@end
