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
        CGFloat verticalIncrement = 20.0;
        CGFloat verticalLength = self.frame.size.height - self.chartEdgesInsets.top - self.chartEdgesInsets.bottom - verticalIncrement;
        CGFloat verticalUnitLength = verticalLength / (self.verticalTextArray.count - 1);
        self.verticalModelArray = [NSMutableArray array];
        for (NSInteger i = 0; i < self.verticalTextArray.count; i++) {
            YQQCoordinateChartModel *model = [YQQCoordinateChartModel new];
            model.coordinatePoint = CGPointMake(self.chartEdgesInsets.left, self.frame.size.height - self.chartEdgesInsets.bottom - verticalUnitLength * i);
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
            model.values = [self.values objectAtIndex:i];
            NSMutableArray *valuePointArray = [NSMutableArray array];
            CGPoint lastPoint = model.coordinatePoint;
            for (NSNumber *number in model.values) {
                CGFloat length = number.floatValue / overFlowValue * verticalLength;
                CGPoint point = CGPointMake(lastPoint.x, lastPoint.y - length);
                [valuePointArray addObject:[NSValue valueWithCGPoint:point]];
                lastPoint = point;
            }
            model.valuePointArray = valuePointArray;
            model.colors = self.colors;
            [self.horizontalModelArray addObject:model];
        }
    } else {
        left = [YQQChartCalculate calculateMaxWidthWithTitles:self.coordinateTitles];
        self.chartEdgesInsets = UIEdgeInsetsMake(top, left, bottom, right);
        self.verticalTextArray = self.coordinateTitles;
        self.horizontalTextArray = averageArray;
        // X轴伸出的长度
        CGFloat horizontalIncrement = 50.0;
        CGFloat horizontalLength = self.frame.size.width - self.chartEdgesInsets.left - self.chartEdgesInsets.right - horizontalIncrement;
        CGFloat horizontalUnitLength = horizontalLength / (self.horizontalTextArray.count - 1);
        self.horizontalModelArray = [NSMutableArray array];
        for (NSInteger i = 0; i < self.horizontalTextArray.count; i++) {
            CGFloat width = [YQQChartCalculate calculateTextWidth:[self.horizontalTextArray objectAtIndex:i] font:[UIFont fontWithName:@"PingFangSC-Regular" size:10]];
            
            YQQCoordinateChartModel *model = [YQQCoordinateChartModel new];
            model.coordinatePoint = CGPointMake(self.chartEdgesInsets.left + horizontalUnitLength * i, self.frame.size.height - self.chartEdgesInsets.bottom);
            model.text = [self.horizontalTextArray objectAtIndex:i];
            model.labelFrame = CGRectMake(model.coordinatePoint.x -  width / 2.0, model.coordinatePoint.y + self.chartEdgesInsets.bottom - 14, width, 14);
            [self.horizontalModelArray addObject:model];
        }
        CGFloat vertivalUnitLenth = (self.frame.size.height - self.chartEdgesInsets.top - self.chartEdgesInsets.bottom) / self.verticalTextArray.count;
        // Y轴的偏移
        CGFloat verticalOffsetY = vertivalUnitLenth / 2.0;
        self.verticalModelArray = [NSMutableArray array];
        for (NSInteger i = 0; i < self.verticalTextArray.count; i++) {
            YQQCoordinateChartModel *model = [YQQCoordinateChartModel new];
            model.coordinatePoint = CGPointMake(self.chartEdgesInsets.left, self.frame.size.height - self.chartEdgesInsets.bottom - vertivalUnitLenth * i - verticalOffsetY);
            model.text = [self.verticalTextArray objectAtIndex:i];
            model.labelFrame = CGRectMake(0, model.coordinatePoint.y - 7, self.chartEdgesInsets.left - 10, 14);
            model.values = [self.values objectAtIndex:i];
            NSMutableArray *valuePointArray = [NSMutableArray array];
            CGPoint lastPoint = model.coordinatePoint;
            for (NSNumber *number in model.values) {
                CGFloat length = number.floatValue / overFlowValue * horizontalLength;
                CGPoint point = CGPointMake(lastPoint.x + length, lastPoint.y);
                [valuePointArray addObject:[NSValue valueWithCGPoint:point]];
                lastPoint = point;
            }
            model.valuePointArray = valuePointArray;
            model.colors = self.colors;
            [self.verticalModelArray addObject:model];
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
    
    NSMutableArray *dotPointArray = [NSMutableArray array];
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
        
        if (self.type == YQQChartTypeVerticalLine) {
            [dotPointArray addObject:[model.valuePointArray lastObject]];
            if (i == self.horizontalModelArray.count - 1) {
                [self drawLineWithPoints:dotPointArray];
            }
        }
        if (self.type == YQQChartTypeVerticalColumn) {
            CGPoint lastPoint = model.coordinatePoint;
            for (NSInteger j = 0; j < model.valuePointArray.count; j++) {
                NSValue *value = [model.valuePointArray objectAtIndex:j];
                CGPoint point = value.CGPointValue;
                UIBezierPath *lineBezierPath = [UIBezierPath bezierPath];
                [lineBezierPath moveToPoint:lastPoint];
                [lineBezierPath addLineToPoint:point];
                CAShapeLayer *lineShapeLayer = [CAShapeLayer layer];
                lineShapeLayer.lineWidth = 10;
                lineShapeLayer.path = lineBezierPath.CGPath;
                lineShapeLayer.strokeColor = [[model.colors objectAtIndex:j] CGColor];
                [self.layer addSublayer:lineShapeLayer];
                lastPoint = point;
            }
        }
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
        
        if (self.type == YQQChartTypeHorizontalLine) {
            [dotPointArray addObject:[model.valuePointArray lastObject]];
            if (i == self.horizontalModelArray.count - 1) {
                [self drawLineWithPoints:dotPointArray];
            }
        }
        if (self.type == YQQChartTypeHorizontalColumn) {
            CGPoint lastPoint = model.coordinatePoint;
            for (NSInteger j = 0; j < model.valuePointArray.count; j++) {
                NSValue *value = [model.valuePointArray objectAtIndex:j];
                CGPoint point = value.CGPointValue;
                UIBezierPath *lineBezierPath = [UIBezierPath bezierPath];
                [lineBezierPath moveToPoint:lastPoint];
                [lineBezierPath addLineToPoint:point];
                CAShapeLayer *lineShapeLayer = [CAShapeLayer layer];
                lineShapeLayer.lineWidth = 10;
                lineShapeLayer.path = lineBezierPath.CGPath;
                lineShapeLayer.strokeColor = [[model.colors objectAtIndex:j] CGColor];
                [self.layer addSublayer:lineShapeLayer];
                lastPoint = point;
            }
        }
    }
}

- (void)drawLineWithPoints:(NSArray *)pointArray {
    // 画线
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:[pointArray[0] CGPointValue]];
    for (NSInteger i = 1; i < pointArray.count; i++) {
        CGPoint point = [pointArray[i] CGPointValue];
        [linePath addLineToPoint:point];
    }
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = linePath.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor colorOfHex:0x40B492 alpha:1.0].CGColor;
    shapeLayer.lineWidth = 1;
    [self.layer addSublayer:shapeLayer];
    
    // 绘制点
    for (NSInteger i = 0; i < pointArray.count; i++) {
        CGPoint point = [pointArray[i] CGPointValue];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(point.x-3, point.y-3, 6, 6) cornerRadius:3];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineWidth = 1;
        layer.path = path.CGPath;
        layer.strokeColor = [UIColor colorOfHex:0x60A6DF alpha:1.0].CGColor;
        layer.fillColor = self.backgroundColor.CGColor;
        [self.layer addSublayer:layer];
    }
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (self.type == YQQChartTypeVerticalColumn || self.type == YQQChartTypeVerticalLine) {
        CGFloat minMargin = CGFLOAT_MAX;
        NSInteger index = 0;
        for (NSInteger i = 0; i < self.verticalModelArray.count; i++) {
            YQQCoordinateChartModel *model = [self.verticalModelArray objectAtIndex:i];
            CGPoint coordinatePoint = model.coordinatePoint;
            if (fabs(point.y - coordinatePoint.y) < minMargin) {
                minMargin = fabs(point.y - coordinatePoint.y);
                index = i;
            }
        }
        NSLog(@"选中%ld", (long)index);
    }
    
    if (self.type == YQQChartTypeHorizontalLine || self.type == YQQChartTypeHorizontalColumn) {
        CGFloat minMargin = CGFLOAT_MAX;
        NSInteger index = 0;
        for (NSInteger i = 0; i < self.horizontalModelArray.count; i++) {
            YQQCoordinateChartModel *model = [self.horizontalModelArray objectAtIndex:i];
            CGPoint coordinatePoint = model.coordinatePoint;
            if (fabs(point.x - coordinatePoint.x) < minMargin) {
                minMargin = fabs(point.x - coordinatePoint.x);
                index = i;
            }
        }
        NSLog(@"选中%ld", (long)index);
    }
}

@end
