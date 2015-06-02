//
//  ViewController.m
//  CCdoubleTableView
//
//  Created by 陈程 on 15/6/2.
//  Copyright (c) 2015年 陈程. All rights reserved.
//

#import "ViewController.h"
#import "CCTableView.h"
#import "TakeOutModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CCTableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (nonatomic,strong) UIView *headerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initData];
    [self initInterface];
    self.tableView.dataArray = self.dataArray;
}

- (void)initInterface
{
    //设置头控件
    self.headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/6)];
    self.headerView.backgroundColor = [UIColor colorWithRed:238/255.0 green:240/255.0 blue:241/255.0 alpha:1];;
    [self.view addSubview:self.headerView];
    //头控件的标题
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetHeight(self.headerView.frame)/2.4, SCREEN_WIDTH-80, CGRectGetHeight(self.headerView.frame)/3.2*1.8)];
    labelTitle.text = @"简易点菜界面";
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.textColor = [UIColor blackColor];
    labelTitle.font = [UIFont boldSystemFontOfSize:14];
    [self.headerView addSubview:labelTitle];
}
/**
 * 添加假数据
 */
- (void)initData
{
    self.dataArray = [NSMutableArray array];
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setValue:@"汉堡" forKey:@"title"];
    NSMutableArray *array1 = [NSMutableArray array];
    for (NSInteger i = 0; i<5; i++) {
        TakeOutModel *model = [[TakeOutModel alloc] init];
        model.price = 99;
        model.title = [NSString stringWithFormat:@"汉堡%ld",i];
        model.soldCount = 10+i;
        [array1 addObject:model];
    }
    [dict1 setValue:array1 forKey:@"content"];
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    [dict2 setValue:@"火锅" forKey:@"title"];
    NSMutableArray *array2 = [NSMutableArray array];
    for (NSInteger i = 0; i<7; i++) {
        TakeOutModel *model = [[TakeOutModel alloc] init];
        model.price = 19+i;
        model.title = [NSString stringWithFormat:@"火锅%ld",i];
        model.soldCount = 20+i;
        [array2 addObject:model];
    }
    [dict2 setValue:array2 forKey:@"content"];
    
    NSMutableDictionary *dict3 = [NSMutableDictionary dictionary];
    [dict3 setValue:@"薯条" forKey:@"title"];
    NSMutableArray *array3 = [NSMutableArray array];
    for (NSInteger i = 0; i<8; i++) {
        TakeOutModel *model = [[TakeOutModel alloc] init];
        model.price = 99+i;
        model.title = [NSString stringWithFormat:@"薯条%ld",i];
        model.soldCount = 30+i;
        [array3 addObject:model];
    }
    [dict3 setValue:array3 forKey:@"content"];
    
    NSMutableDictionary *dict4 = [NSMutableDictionary dictionary];
    [dict4 setValue:@"麻饼" forKey:@"title"];
    NSMutableArray *array4 = [NSMutableArray array];
    for (NSInteger i = 0; i<9; i++) {
        TakeOutModel *model = [[TakeOutModel alloc] init];
        model.price = 89+i;
        model.title = [NSString stringWithFormat:@"麻%ld",i];
        model.soldCount = 40+i;
        [array4 addObject:model];
    }
    [dict4 setValue:array4 forKey:@"content"];
    
    [self.dataArray addObject:dict1];
    [self.dataArray addObject:dict2];
    [self.dataArray addObject:dict3];
    [self.dataArray addObject:dict4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
