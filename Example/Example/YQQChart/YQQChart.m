//
//  YQQChart.m
//  Example
//
//  Created by zhuyi on 2020/10/15.
//

#import "YQQChart.h"
#import "YQQPieChartModel.h"
#import "YQQChartCalculate.h"
#import "YQQCoordinateChartModel.h"

@interface YQQChart ()

@property (nonatomic, assign) UIEdgeInsets chartEdgesInsets;
// 纵坐标有效长度
@property (nonatomic, assign) CGFloat y_length;
// 横坐标有效长度
@property (nonatomic, assign) CGFloat x_length;
// 纵坐标单元格长度
@property (nonatomic, assign) CGFloat y_unit_length;
// 横坐标单元格长度
@property (nonatomic, assign) CGFloat x_unit_length;

@property (nonatomic, strong) NSArray *verticalTextArray;
@property (nonatomic, strong) NSArray *horizontalTextArray;

@property (nonatomic, strong) NSMutableArray *verticalModelArray;
@property (nonatomic, strong) NSMutableArray *horizontalModelArray;

@end

@implementation YQQChart

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.type == YQQChartTypePie) {
        [self pie];
    } else {
        [self refreshState];
    }
}

- (void)refreshState {
    CGFloat left = 0;
    CGFloat top = 0;
    CGFloat bottom = 20;
    CGFloat right = 20;
    
    NSInteger overFlowValue = [YQQChartCalculate calculateOverFlowValueWithValues:self.values];
    NSInteger average = overFlowValue / 5;
    NSArray *averageArray = [NSArray arrayWithObjects:
                             [NSString stringWithFormat:@"%d", 0],
                             [NSString stringWithFormat:@"%ld", (long)average],
                             [NSString stringWithFormat:@"%ld", average * 2],
                             [NSString stringWithFormat:@"%ld", average * 3],
                             [NSString stringWithFormat:@"%ld", average * 4],
                             [NSString stringWithFormat:@"%ld", average * 5], nil];
    
    if (self.type == YQQChartTypeHorizontalColumn || self.type == YQQChartTypeHorizontalLine) {
        left = [YQQChartCalculate calculateMaxWidthWithTitles:averageArray];
        self.chartEdgesInsets = UIEdgeInsetsMake(top, left, bottom, right);
        self.verticalTextArray = averageArray;
        self.horizontalTextArray = self.coordinateTitles;
        // Y轴伸出的长度
        CGFloat verticalIncrement = 30.0;
        CGFloat vertivalUnitLenth = (self.frame.size.height - self.chartEdgesInsets.top - self.chartEdgesInsets.bottom - verticalIncrement) / (self.verticalTextArray.count - 1);
        self.verticalModelArray = [NSMutableArray array];
        for (NSInteger i = 0; i < self.verticalTextArray.count; i++) {
            YQQCoordinateChartModel *model = [YQQCoordinateChartModel new];
            model.coordinatePoint = CGPointMake(self.chartEdgesInsets.left, self.frame.size.height - self.chartEdgesInsets.bottom - vertivalUnitLenth * i);
            model.text = [self.verticalTextArray objectAtIndex:i];
            model.labelFrame = CGRectMake(0, model.coordinatePoint.y - 7, self.chartEdgesInsets.left - 10, 14);
            [self.verticalModelArray addObject:model];
        }
        // X轴伸出的长度
        CGFloat horizontalIncrement = 50.0;
        CGFloat horizontalUnitLenth = (self.frame.size.width - self.chartEdgesInsets.left - self.chartEdgesInsets.right - horizontalIncrement) / self.horizontalTextArray.count;
        self.horizontalModelArray = [NSMutableArray array];
        for (NSInteger i = 0; i < self.horizontalTextArray.count; i++) {
            CGFloat width = [YQQChartCalculate calculateTextWidth:[self.horizontalTextArray objectAtIndex:i] font:[UIFont fontWithName:@"PingFangSC-Regular" size:10]];
            
            YQQCoordinateChartModel *model = [YQQCoordinateChartModel new];
            model.coordinatePoint =  CGPointMake(self.chartEdgesInsets.left + horizontalUnitLenth * i + horizontalIncrement, self.frame.size.height - self.chartEdgesInsets.bottom);
            model.text = [self.horizontalTextArray objectAtIndex:i];
            model.labelFrame = CGRectMake(model.coordinatePoint.x -  width / 2.0, model.coordinatePoint.y + self.chartEdgesInsets.bottom - 14, width, 14);
            [self.horizontalModelArray addObject:model];
        }
    } else {
        left = [YQQChartCalculate calculateMaxWidthWithTitles:self.coordinateTitles];
        self.chartEdgesInsets = UIEdgeInsetsMake(top, left, bottom, right);
        self.verticalTextArray = self.coordinateTitles;
        self.horizontalTextArray = averageArray;
        // Y轴伸出的长度
        CGFloat verticalIncrement = 20.0;
        CGFloat vertivalUnitLenth = (self.frame.size.height - self.chartEdgesInsets.top - self.chartEdgesInsets.bottom - verticalIncrement) / self.verticalTextArray.count;
        self.verticalModelArray = [NSMutableArray array];
        for (NSInteger i = 0; i < self.verticalTextArray.count; i++) {
            YQQCoordinateChartModel *model = [YQQCoordinateChartModel new];
            model.coordinatePoint = CGPointMake(self.chartEdgesInsets.left, self.frame.size.height - self.chartEdgesInsets.bottom - vertivalUnitLenth * i - verticalIncrement);
            model.text = [self.verticalTextArray objectAtIndex:i];
            model.labelFrame = CGRectMake(0, model.coordinatePoint.y - 7, self.chartEdgesInsets.left - 10, 14);
            [self.verticalModelArray addObject:model];
        }
        // X轴伸出的长度
        CGFloat horizontalIncrement = 50.0;
        CGFloat horizontalUnitLenth = (self.frame.size.width - self.chartEdgesInsets.left - self.chartEdgesInsets.right - horizontalIncrement) / (self.horizontalTextArray.count - 1);
        self.horizontalModelArray = [NSMutableArray array];
        for (NSInteger i = 0; i < self.horizontalTextArray.count; i++) {
            CGFloat width = [YQQChartCalculate calculateTextWidth:[self.horizontalTextArray objectAtIndex:i] font:[UIFont fontWithName:@"PingFangSC-Regular" size:10]];
            
            YQQCoordinateChartModel *model = [YQQCoordinateChartModel new];
            model.coordinatePoint = CGPointMake(self.chartEdgesInsets.left + horizontalUnitLenth * i, self.frame.size.height - self.chartEdgesInsets.bottom);
            model.text = [self.horizontalTextArray objectAtIndex:i];
            model.labelFrame = CGRectMake(model.coordinatePoint.x -  width / 2.0, model.coordinatePoint.y + self.chartEdgesInsets.bottom - 14, width, 14);
            [self.horizontalModelArray addObject:model];
        }
    }
    [self drawCoordinateSystem];
}

- (void)drawCoordinateSystem {
    UIBezierPath *coordinatePath = [UIBezierPath bezierPath];
    [coordinatePath moveToPoint:CGPointMake(self.chartEdgesInsets.left, self.chartEdgesInsets.top)];
    [coordinatePath addLineToPoint:CGPointMake(self.chartEdgesInsets.left, self.frame.size.height - self.chartEdgesInsets.bottom)];
    [coordinatePath addLineToPoint:CGPointMake(self.frame.size.width - self.chartEdgesInsets.right, self.frame.size.height - self.chartEdgesInsets.bottom)];
    CAShapeLayer *coordinateShapeLayer = [CAShapeLayer layer];
    coordinateShapeLayer.path = coordinatePath.CGPath;
    coordinateShapeLayer.strokeColor = [UIColor colorOfHex:0xC8C8C8 alpha:1].CGColor;
    coordinateShapeLayer.fillColor = [UIColor whiteColor].CGColor;
    coordinateShapeLayer.borderWidth = 1.0;
    [self.layer addSublayer:coordinateShapeLayer];
    
    for (NSInteger i = 0; i < self.verticalModelArray.count; i++) {
        YQQCoordinateChartModel *model = [self.verticalModelArray objectAtIndex:i];
                
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:model.coordinatePoint];
        [bezierPath addLineToPoint:CGPointMake(model.coordinatePoint.x + 5, model.coordinatePoint.y)];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = bezierPath.CGPath;
        shapeLayer.strokeColor = [UIColor colorOfHex:0xC8C8C8 alpha:1].CGColor;
        shapeLayer.fillColor = [UIColor whiteColor].CGColor;
        shapeLayer.borderWidth = 1.0;
        [self.layer addSublayer:shapeLayer];
        
        UILabel *label = [[UILabel alloc] initWithFrame:model.labelFrame];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
        label.textColor = [UIColor colorOfHex:0x5A5A5A alpha:1];
        label.textAlignment = NSTextAlignmentRight;
        label.text = model.text;
        [self addSubview:label];
    }
    
    for (NSInteger i = 0; i < self.horizontalModelArray.count; i++) {
        YQQCoordinateChartModel *model = [self.horizontalModelArray objectAtIndex:i];
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:model.coordinatePoint];
        [bezierPath addLineToPoint:CGPointMake(model.coordinatePoint.x, model.coordinatePoint.y - 5)];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = bezierPath.CGPath;
        shapeLayer.strokeColor = [UIColor colorOfHex:0xC8C8C8 alpha:1].CGColor;
        shapeLayer.fillColor = [UIColor whiteColor].CGColor;
        shapeLayer.borderWidth = 1.0;
        [self.layer addSublayer:shapeLayer];
        
        UILabel *label = [[UILabel alloc] initWithFrame:model.labelFrame];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
        label.textColor = [UIColor colorOfHex:0xC8C8C8 alpha:1];
        label.text = model.text;
        [self addSubview:label];
    }
}

- (void)line {
    
}

- (void)pie {
    NSMutableArray *modelValues = [YQQChartCalculate calculatePieWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height)
                                                                   radius:self.radius
                                                               startAngle:self.startAngle
                                                                   radian:self.radian
                                                                pieTitles:self.pieTitles
                                                                pieValues:self.values
                                                                pieColors:self.colors];
    for (NSInteger j = 0; j < modelValues.count; j++) {
        YQQPieChartModel *model = [modelValues objectAtIndex:j];
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
        
        if (j == modelValues.count - 1) {
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

@end
