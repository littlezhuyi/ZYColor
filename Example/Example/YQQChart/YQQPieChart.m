//
//  YQQChart.m
//  Example
//
//  Created by zhuyi on 2020/10/15.
//

#import "YQQPieChart.h"
#import "YQQPieChartModel.h"
#import "YQQPieChartCalculate.h"

@implementation YQQPieChart

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSMutableArray *modelValues = [YQQPieChartCalculate calculateWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height)
                                                                   radius:self.radius
                                                               startAngle:self.startAngle
                                                                   radian:self.radian
                                                                pieTitles:self.pieTitles
                                                                pieValues:self.pieValues
                                                                pieColors:self.pieColors];
    for (NSInteger i = 0; i < modelValues.count; i++) {
        NSArray *eleModelValues = [modelValues objectAtIndex:i];
        for (NSInteger j = 0; j < eleModelValues.count; j++) {
            YQQPieChartModel *model = [eleModelValues objectAtIndex:j];
            UIBezierPath *outSideBezierPath = [UIBezierPath bezierPathWithArcCenter:model.center radius:self.radius startAngle:model.startAngle endAngle:model.endAngle clockwise:YES];
            [outSideBezierPath addLineToPoint:model.center];
            [outSideBezierPath closePath];
            CAShapeLayer *outSideShapeLayer = [CAShapeLayer layer];
            outSideShapeLayer.fillColor = model.color.CGColor;
            outSideShapeLayer.path = outSideBezierPath.CGPath;
            [self.layer addSublayer:outSideShapeLayer];
            
            UIBezierPath *lineBezierpath = [UIBezierPath bezierPath];
            [lineBezierpath moveToPoint:model.intersectionPoint];
            [lineBezierpath addLineToPoint:model.joinPoint];
            [lineBezierpath addLineToPoint:model.capPoint];
            CAShapeLayer *lineLayer = [CAShapeLayer layer];
            lineLayer.strokeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45].CGColor;
            lineLayer.fillColor = [UIColor whiteColor].CGColor;
            lineLayer.path = lineBezierpath.CGPath;
            lineLayer.lineDashPattern = @[@(2.0), @(1.0)];
            [self.layer addSublayer:lineLayer];
            
            UILabel *label = [[UILabel alloc] initWithFrame:model.titleRect];
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
            label.text = [NSString stringWithFormat:@"%@ %ld", model.title, (long)model.number.integerValue];
            [self addSubview:label];
            
            if (i == modelValues.count - 1 && j == eleModelValues.count - 1) {
                UIBezierPath *inSideBezierPath = [UIBezierPath bezierPathWithArcCenter:model.center radius:self.insideRadius startAngle:self.startAngle endAngle:self.startAngle + self.radian clockwise:YES];
                [inSideBezierPath addLineToPoint:model.center];
                [inSideBezierPath closePath];
                CAShapeLayer *inSideShapeLayer = [CAShapeLayer layer];
                inSideShapeLayer.fillColor = [UIColor whiteColor].CGColor;
                inSideShapeLayer.path = inSideBezierPath.CGPath;
                [self.layer addSublayer:inSideShapeLayer];
            }
        }
    }
}

@end
