//
//  ViewController.m
//  Example
//
//  Created by zhuyi on 2020/10/15.
//

#import "ViewController.h"
#import "YQQChart.h"

@interface ViewController () <YQQChartDelegate>

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
    chart.delegate = self;
    chart.colors = @[
        [UIColor colorOfHex:0x9270CA alpha:1],
        [UIColor colorOfHex:0xEB7E65 alpha:1],
        [UIColor colorOfHex:0x359BEE alpha:1],
        [UIColor colorOfHex:0x7585A2 alpha:1],
        [UIColor colorOfHex:0x1ACB97 alpha:1],
        [UIColor colorOfHex:0xF3B545 alpha:1]
    ];
    
    chart.values = @[
        @[
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000)
        ],
        @[
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000)
        ],
        @[
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000)
        ],
        @[
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000)
        ],
        @[
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000)
        ],
        @[
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000),
            @(arc4random() % 1000)
        ]
    ];
    
    chart.coordinateTitles = @[@"北京", @"上海", @"广州", @"深圳", @"郑州", @"杭州"];
    
    [self.scrollView addSubview:chart];
}

- (void)pie {
    YQQChart *chart = [[YQQChart alloc] initWithFrame:CGRectMake(0, 1300, [UIScreen mainScreen].bounds.size.width, 300)];
    chart.backgroundColor = [UIColor whiteColor];
    chart.delegate = self;
    chart.colors = @[
        @[
            [UIColor colorOfHex:0x9270CA alpha:1]
        ],
        @[
            [UIColor colorOfHex:0xEB7E65 alpha:1]
        ],
        @[
            [UIColor colorOfHex:0x359BEE alpha:1]
        ],
        @[
            [UIColor colorOfHex:0x7585A2 alpha:1]
        ],
        @[
            [UIColor colorOfHex:0x1ACB97 alpha:1]
        ],
        @[
            [UIColor colorOfHex:0xF3B545 alpha:1],
            [UIColor colorOfHex:0xF3B545 alpha:1]
        ],
        @[
            [UIColor colorOfHex:0x9270CA alpha:1]
        ],
        @[
            [UIColor colorOfHex:0xEB7E65 alpha:1]
        ],
        @[
            [UIColor colorOfHex:0x359BEE alpha:1]
        ],
        @[
            [UIColor colorOfHex:0x7585A2 alpha:1]
        ]
    ];
    chart.values = @[
        @[
            @(arc4random() % 1000)
        ],
        @[
            @(arc4random() % 1000)
        ],
        @[
            @(arc4random() % 1000)
        ],
        @[
            @(arc4random() % 1000)
        ],
        @[
            @(arc4random() % 1000)
        ],
        @[
            @(arc4random() % 1000),
            @(arc4random() % 1000)
        ],
        @[
            @(arc4random() % 1000)
        ],
        @[
            @(arc4random() % 1000)
        ],
        @[
            @(arc4random() % 1000)
        ],
        @[
            @(arc4random() % 1000)
        ]
    ];
    chart.pieTitles = @[
        @[
            @"一"
        ],
        @[
            @"二"
        ],
        @[
            @"三"
        ],
        @[
            @"四"
        ],
        @[
            @"五"
        ],
        @[
            @"六",
            @"七"
        ],
        @[
            @"八"
        ],
        @[
            @"九"
        ],
        @[
            @"十"
        ],
        @[
            @"十一"
        ]
    ];
    chart.startAngle = - M_PI_2;
    chart.radian = M_PI * 2;
    chart.radius = 70;
    chart.insideRadius = 40;
    [self.scrollView addSubview:chart];
}

- (void)chart:(YQQChart *)chart didSelectIndex:(NSInteger)index {
    if (chart.type == YQQChartTypePie) {
        chart.values = @[
            @[
                @(arc4random() % 1000)
            ],
            @[
                @(arc4random() % 1000)
            ],
            @[
                @(arc4random() % 1000)
            ],
            @[
                @(arc4random() % 1000)
            ],
            @[
                @(arc4random() % 1000)
            ],
            @[
                @(arc4random() % 1000),
                @(arc4random() % 1000)
            ],
            @[
                @(arc4random() % 1000)
            ],
            @[
                @(arc4random() % 1000)
            ],
            @[
                @(arc4random() % 1000)
            ],
            @[
                @(arc4random() % 1000)
            ]
        ];
        [chart setNeedsLayout];
        [chart layoutIfNeeded];
    }
}

@end
