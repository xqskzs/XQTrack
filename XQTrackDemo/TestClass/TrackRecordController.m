//
//  TrackRecordController.m
//  XQTrackDemo
//
//  Created by 小强 on 2018/7/8.
//  Copyright © 2018年 小强. All rights reserved.
//

#import "TrackRecordController.h"
#import "XQTrackData.h"

@interface TrackRecordController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray * dataA;
@end

@implementation TrackRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dataInit];
    
    [self viewInit];
    // Do any additional setup after loading the view.
}

- (void)dataInit
{
    if(!_dataA)
        _dataA = [[NSMutableArray alloc] init];
    [_dataA addObjectsFromArray:[[[[XQTrackData sharedInstance] trackModels] reverseObjectEnumerator] allObjects]];
}

- (void)viewInit
{
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WW, HH) style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}

#pragma mark --------------- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataA.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    XQTrackModel * md = _dataA[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = md.message;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XQTrackModel * md = _dataA[indexPath.row];

    return [XQTrackHandle sizeWithStr:md.message withMaxWidth:WW - 32 withFont:14].height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
