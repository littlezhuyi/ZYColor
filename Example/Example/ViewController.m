//
//  ViewController.m
//  Example
//
//  Created by zhuyi on 2020/10/15.
//

#import "ViewController.h"
#import "YQQChart.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.contentSize = CGSizeMake(0, 1600);
    [self.view addSubview:self.scrollView];
    
    [self chartWithType:YQQChartTypeVerticalColumn offset:20];
    [self chartWithType:YQQChartTypeVerticalLine offset:340];
    [self chartWithType:YQQChartTypeHorizontalColumn offset:660];
    [self chartWithType:YQQChartTypeHorizontalLine offset:980];
    
    [self pie];
}

- (void)chartWithType:(YQQChartType)type offset:(CGFloat)offset {
    YQQChart *chart = [[YQQChart alloc] initWithFrame:CGRectMake(0, offset, [UIScreen mainScreen].bounds.size.width, 300)];
    chart.backgroundColor = [UIColor whiteColor];
    chart.type = type;
    chart.colors = @[[UIColor colorOfHex:0x9270CA alpha:1], [UIColor colorOfHex:0xEB7E65 alpha:1], [UIColor colorOfHex:0x359BEE alpha:1], [UIColor colorOfHex:0x7585A2 alpha:1], [UIColor colorOfHex:0x1ACB97 alpha:1], [UIColor colorOfHex:0xF3B545 alpha:1]];
    
    chart.values = @[
    @[@100, @230, @230, @140, @550, @680],
    @[@730, @180, @950, @100, @610, @920],
    @[@130, @240, @50, @560, @70, @980],
    @[@90, @500, @210, @320, @230, @40],
    @[@250, @60, @70, @380, @290, @30],
    @[@310, @520, @30, @540, @50, @960]
    
    ];
    
    chart.coordinateTitles = @[@"北京", @"上海", @"广州", @"深圳", @"郑州", @"杭州"];
    
    [self.scrollView addSubview:chart];
}

- (void)pie {
    YQQChart *chart = [[YQQChart alloc] initWithFrame:CGRectMake(0, 1300, [UIScreen mainScreen].bounds.size.width, 300)];
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
    [self.scrollView addSubview:chart];
}

@end
