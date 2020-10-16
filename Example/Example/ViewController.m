//
//  ViewController.m
//  Example
//
//  Created by zhuyi on 2020/10/15.
//

#import "ViewController.h"
#import "YQQPieChart.h"
#import "YQQPieChartCalculate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    YQQPieChart *chart = [[YQQPieChart alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 600)];
    chart.backgroundColor = [UIColor whiteColor];
    chart.pieColors = @[
    @[[UIColor colorWithRed:70/255.0 green:169/255.0 blue:168/255.0 alpha:1.0]],
    @[[UIColor colorWithRed:93/255.0 green:112/255.0 blue:146/255.0 alpha:0.85]],
    @[[UIColor colorWithRed:246/255.0 green:212/255.0 blue:22/255.0 alpha:0.85]],
    @[[UIColor colorWithRed:232/255.0 green:104/255.0 blue:74/255.0 alpha:0.85]],
    @[[UIColor colorWithRed:146/255.0 green:112/255.0 blue:202/255.0 alpha:1.0]],
    @[[UIColor colorWithRed:243/255.0 green:181/255.0 blue:69/255.0 alpha:1.0]],
    @[[UIColor colorWithRed:26/255.0 green:203/255.0 blue:151/255.0 alpha:1.0]],
    @[[UIColor colorWithRed:70/255.0 green:169/255.0 blue:168/255.0 alpha:1.0]],
    @[[UIColor colorWithRed:93/255.0 green:112/255.0 blue:146/255.0 alpha:0.85]],
    @[[UIColor colorWithRed:246/255.0 green:212/255.0 blue:22/255.0 alpha:0.85]],
    @[[UIColor colorWithRed:232/255.0 green:104/255.0 blue:74/255.0 alpha:0.85]]
    ];
    chart.pieValues = @[@[@10], @[@30], @[@40], @[@70], @[@90], @[@100], @[@110], @[@150], @[@190], @[@220], @[@280]];
    chart.pieTitles = @[@[@"车速通&以租代购"], @[@"整备"], @[@"网约车"], @[@"约车"], @[@"二手车"], @[@"商务车队 待租"], @[@"新能源"], @[@"短租 待租"], @[@"短租 在租"], @[@"长租 待租"], @[@"长租 在租"]];
    chart.startAngle = - M_PI_2;
    chart.radian = M_PI * 2;
    chart.radius = 70;
    chart.insideRadius = 40;
    [self.view addSubview:chart];
}


@end
