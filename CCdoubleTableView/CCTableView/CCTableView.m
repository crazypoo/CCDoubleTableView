//
//  CCTableView.m
//  CCdoubleTableView
//
//  Created by 陈程 on 15/6/2.
//  Copyright (c) 2015年 陈程. All rights reserved.
//

#import "CCTableView.h"
#import "TakeOutModel.h"
#import "TakeOutViewCell.h"
#import "TakeOutHeader.h"
#import "CCBadgeButton.h"

@interface CCTableView()<UITableViewDataSource,UITableViewDelegate,TakeOutViewCellDelegate>
@property (nonatomic,weak) UITableView *leftTableView;
@property (nonatomic,weak) UITableView *rightTableView;
@property (nonatomic,weak) UILabel *totalPriceLabel;
@property (nonatomic,assign) NSInteger totalPrice;
@property (nonatomic,weak) CCBadgeButton *badge;
@property (nonatomic,strong) NSMutableArray *orderArray;
@end

@implementation CCTableView

- (void)awakeFromNib
{
    self.orderArray = [NSMutableArray array];
    [self initInterface];
}

- (void)initInterface
{
    //左边的tableview
    UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, 70, self.frame.size.height) style:UITableViewStylePlain];
    leftTableView.tag = 1;
    leftTableView.dataSource = self;
    leftTableView.delegate = self;
    self.leftTableView = leftTableView;
    self.leftTableView.tableFooterView = [[UIView alloc] init];
    leftTableView.showsVerticalScrollIndicator = NO;
    if ([leftTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [leftTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([leftTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [leftTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self addSubview:leftTableView];
    //右边tableview
    UITableView *rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(80, 0, [UIScreen mainScreen].bounds.size.width-80, self.frame.size.height) style:UITableViewStylePlain];
    rightTableView.tag = 2;
    rightTableView.dataSource = self;
    rightTableView.delegate = self;
    self.rightTableView = rightTableView;
    rightTableView.showsVerticalScrollIndicator = NO;
    if ([rightTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [rightTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([rightTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [rightTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self addSubview:rightTableView];
    
    [self initFooter];
}
/**
 * 界面下方的条形栏
 */
- (void)initFooter
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-40, SCREEN_WIDTH, 40)];
    footer.backgroundColor = [UIColor clearColor];
    CALayer *back = [CALayer layer];
    back.frame = CGRectMake(0, 10, self.frame.size.width,30);
    back.backgroundColor = [UIColor colorWithRed:238/255.0 green:240/255.0 blue:241/255.0 alpha:1].CGColor;
    [footer.layer addSublayer:back];
    [self addSubview:footer];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(25, 0, 34, 34);
    button.layer.cornerRadius = 17;
    button.clipsToBounds = YES;
    [button setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    [footer addSubview:button];
    
    UILabel *totleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+6, 24, 200, 10)];
    totleLabel.font = [UIFont systemFontOfSize:11];
    self.totalPriceLabel = totleLabel;
    [footer addSubview:totleLabel];
    
    UIButton *overbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    overbutton.frame = CGRectMake(self.frame.size.width-70, 10, 70, 30);
    overbutton.backgroundColor = [UIColor orangeColor];
    [overbutton setTitle:@"还差￥120起送" forState:UIControlStateNormal];
    [overbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    overbutton.titleLabel.font = [UIFont systemFontOfSize:9];
//    [overbutton addTarget:self action:@selector(overButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:overbutton];
    //购物车右上方的标记
    CCBadgeButton *badge = [[CCBadgeButton alloc] initWithFrame:CGRectMake(50, 3, 1, 1)];
    self.badge = badge;
    [footer addSubview:badge];
    
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}
#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableView.tag==1 ? 1 :self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableView.tag==1 ? self.dataArray.count : [self.dataArray[section][@"content"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag ==1) {
        static NSString *ID = @"tabkeOutLeftCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
                [cell setSeparatorInset:UIEdgeInsetsZero];
                
            }
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                [cell setLayoutMargins:UIEdgeInsetsZero];
            }
        }
        cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:11];
        cell.contentView.backgroundColor = [UIColor colorWithRed:238/255.0 green:240/255.0 blue:241/255.0 alpha:1];
        return cell;
    }else
    {
        TakeOutViewCell *cell = [[TakeOutViewCell alloc] cellWithTableView:tableView];
        cell.model = self.dataArray[indexPath.section][@"content"][indexPath.row];
        cell.indexPath = indexPath;
        cell.delegate = self;
        return cell;
    }
}
#pragma mark - tableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 2) {
        TakeOutHeader *header = [TakeOutHeader headerWithTableView:tableView];
        header.titleStr = self.dataArray[section][@"title"];
        return header;
    }else return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return tableView.tag == 1 ? 0 : 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.tag== 1 ? 44:60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag ==1) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor orangeColor];
        [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:nil];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.tag == 1 ? YES : NO;
}

#pragma mark - cell点击
/**
 * cell开始订购
 */
- (void)cellShowCountViewWithPath:(NSIndexPath *)indexPath
{
    TakeOutModel *model = self.dataArray[indexPath.section][@"content"][indexPath.row];
    model.showCount = YES;
    [self.orderArray addObject:model];
    self.badge.badgeValue = [NSString stringWithFormat:@"%ld",self.orderArray.count];
    [self.rightTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
/**
 * cell取消订购
 */
- (void)cellNotShowCountViewWithPath:(NSIndexPath *)indexPath
{
    TakeOutModel *model = self.dataArray[indexPath.section][@"content"][indexPath.row];
    model.orderCount = 0;
    model.showCount = NO;
    if ([self.orderArray containsObject:model]) {
        [self.orderArray removeObject:model];
    }
    self.badge.badgeValue = [NSString stringWithFormat:@"%ld",self.orderArray.count];
    [self.rightTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
/**
 * cell增加订购数量
 */
- (void)cellOrderAddPath:(NSIndexPath *)indexPath
{
    TakeOutModel *model = self.dataArray[indexPath.section][@"content"][indexPath.row];
    model.orderCount++;
    NSLog(@"%ld",model.orderCount);
    self.totalPrice = model.price + self.totalPrice;
    [self priceChange];
}
/**
 * cell减少订购数量
 */
- (void)cellOrderSubPath:(NSIndexPath *)indexPath
{
    TakeOutModel *model = self.dataArray[indexPath.section][@"content"][indexPath.row];
    if (model.orderCount > 0) {
        model.orderCount--;
    }
    NSLog(@"%ld",model.orderCount);
    self.totalPrice = self.totalPrice - model.price;
    [self priceChange];
}
/**
 * 总价格变化调用
 */
- (void)priceChange
{
    self.totalPriceLabel.text = [NSString stringWithFormat:@"共￥%ld",self.totalPrice];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.totalPriceLabel.text];
    NSRange range = NSMakeRange(1, self.totalPriceLabel.text.length-1);
    [str addAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:range];
    self.totalPriceLabel.attributedText = str;
}
@end
