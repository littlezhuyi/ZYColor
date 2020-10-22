//
//  ViewController.m
//  Example
//
//  Created by zhuyi on 2020/10/15.
//

#import "ViewController.h"
#import "YQQChart.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self column];
}

- (void)column {
    YQQChart *chart = [[YQQChart alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 600)];
    chart.backgroundColor = [UIColor whiteColor];
    chart.type = YQQChartTypeHorizontalColumn;
    chart.colors = @[[UIColor colorOfHex:0x9270CA alpha:1], [UIColor colorOfHex:0xEB7E65 alpha:1], [UIColor colorOfHex:0x359BEE alpha:1], [UIColor colorOfHex:0x7585A2 alpha:1], [UIColor colorOfHex:0x1ACB97 alpha:1], [UIColor colorOfHex:0xF3B545 alpha:1]];
    
    chart.values = @[
    @[@10, @20, @30, @40, @50, @60],
    @[@70, @80, @90, @100, @110, @120],
    @[@130, @140, @150, @160, @170, @180],
    @[@190, @200, @210, @220, @230, @240],
    @[@250, @260, @270, @280, @290, @300],
    @[@310, @320, @330, @340, @350, @360]
    
    ];
    
    chart.coordinateTitles = @[@"北京", @"上海", @"广州", @"深圳", @"郑州", @"杭州"];
    
    [self.view addSubview:chart];
}

- (void)pie {
    YQQChart *chart = [[YQQChart alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 600)];
    chart.backgroundColor = [UIColor whiteColor];
    chart.colors = @[
    @[[UIColor colorOfHex:0x9270CA alpha:1], [UIColor colorOfHex:0xEB7E65 alpha:1], [UIColor colorOfHex:0x359BEE alpha:1], [UIColor colorOfHex:0x7585A2 alpha:1], [UIColor colorOfHex:0x1ACB97 alpha:1], [UIColor colorOfHex:0xF3B545 alpha:1]],
    @[[UIColor colorOfHex:0x9270CA alpha:1], [UIColor colorOfHex:0xEB7E65 alpha:1], [UIColor colorOfHex:0x359BEE alpha:1], [UIColor colorOfHex:0x7585A2 alpha:1], [UIColor colorOfHex:0x1ACB97 alpha:1], [UIColor colorOfHex:0xF3B545 alpha:1]]
    ];
    chart.values = @[@[@10, @20, @30, @40, @50, @60], @[@70, @80, @90, @100, @110, @120]];
    chart.pieTitles = @[
    @[@"车速通&以租代购", @"整备", @"网约车", @"约车", @"二手车", @"商务车队 待租"],
    @[@"新能源", @"短租 待租", @"短租 在租", @"长租 待租", @"长租 在租", @"其他"]
    ];
    chart.startAngle = - M_PI_2;
    chart.radian = M_PI * 2;
    chart.radius = 70;
    chart.insideRadius = 40;
    [self.view addSubview:chart];
}

@end
