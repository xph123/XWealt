//
//  CXSelectTableViewController.m
//  XWealth
//
//  Created by chx on 15/7/13.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXSelectTableViewController.h"
#import "XSelectRightCell.h"

@interface CXSelectTableViewController ()
@property (nonatomic, assign) int selectIndex;
@end

@implementation CXSelectTableViewController

- (id)initWithSourceData:(NSArray*)sourceDatas andSelect:(int)selectIndex
{
    self = [super init];
    if (self)
    {
        _sourceDatas = sourceDatas;
        _selectIndex = selectIndex;
        _nameId=0;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
//    self.title = StringSex;
    
//    [self initRightBarButton];
    
    //tableView
    CGRect frame = CGRectMake(0, kDefaultMargin, self.view.frame.size.width, self.view.frame.size.height - 2 * kDefaultMargin);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = kControlBgColor;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) initRightBarButton
{
    UIButton *complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    complateBtn.frame = CGRectMake(0, 0, 60, 30);
    [complateBtn setTitle:StringSave forState:UIControlStateNormal];
    complateBtn.titleLabel.font = kNavBarTextFont;
    [complateBtn setTitleColor:kNavBarTextColor forState:UIControlStateNormal];
    [complateBtn addTarget:self action:@selector(clickComplateBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBar = [[UIBarButtonItem alloc] initWithCustomView:complateBtn];
    self.navigationItem.rightBarButtonItem = saveBar;
}

#pragma mark - private methods

- (void)clickComplateBtn
{
    [self.delegate setSelected:_nameId andIndex:self.selectIndex];
    //[self.delegate setSelectedIndex:self.selectIndex];
    
    [self goBack];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sourceDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CXSelectRightCellIdentifier = @"CXSelectRightCellIdentifier";
    XSelectRightCell *cell = [tableView dequeueReusableCellWithIdentifier:CXSelectRightCellIdentifier];
    if (cell == nil) {
        cell = [[XSelectRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CXSelectRightCellIdentifier];
    }
    
    NSString *text = [_sourceDatas objectAtIndex:indexPath.row];
    
    if (indexPath.row == self.selectIndex)
    {
        [cell setTitle:text andSelect:1];
    }
    else
    {
        [cell setTitle:text andSelect:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kMenuHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectIndex = (int)indexPath.row;
    
    [self.tableView reloadData];
    [self clickComplateBtn];
}

@end
