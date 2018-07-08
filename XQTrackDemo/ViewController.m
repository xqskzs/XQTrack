//
//  ViewController.m
//  XQTrackDemo
//
//  Created by 小强 on 2018/7/4.
//  Copyright © 2018年 小强. All rights reserved.
//

#import "ViewController.h"
#import "InformationController.h"
#import "VideoController.h"
#import "VoiceController.h"
#import "ShoppingController.h"
#import "TrackRecordController.h"
#import "XQTrackSingle.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSArray * titleA;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInit];
    [self viewInit];
    
    [XQTrackSingle shareInstance].uploadDataBlock = ^(id obj, ...) {
//        va_list params; //定义一个指向个数可变的参数列表指针;
//        va_start(params,obj);//va_start 得到第一个可变参数地址,
//        NSMutableArray *argsArray = [[NSMutableArray alloc] init];
//        id arg;
//        if (obj) {
//            while((arg = obj))
//            {
//                [argsArray addObject:arg];
//                obj = va_arg(params, id);
//            }
//        }
//        va_end(params);
        NSLog(@"+++++++++++++++++用户切换到后台,并开始传跟踪记录到服务器");
    };
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)dataInit
{
    if(!_titleA)
        _titleA = @[@"资讯",@"视频",@"音频",@"购物",@"跟踪记录"];
    
}

- (void)viewInit
{
    [self.view addSubview:self.tableView];
    //    [self.view addSubview:self.verticalView];
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
    return _titleA.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = _titleA[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController * controller;
    switch (indexPath.row) {
        case 0:
        {
            controller = (UIViewController *)[[InformationController alloc] init];
        }
            break;
        case 1:
        {
            controller = (UIViewController *)[[VideoController alloc] init];
        }
            break;
        case 2:
        {
            controller = [(UIViewController *)[VoiceController alloc] init];
        }
            break;
        case 3:
        {
            controller = [(UIViewController *)[ShoppingController alloc] init];
        }
            break;
        case 4:
        {
            controller = [(UIViewController *)[TrackRecordController alloc] init];
        }
            break;
        default:
            break;
    }
    if(controller)
    {
        controller.navigationItem.title = _titleA[indexPath.row];
        [self pushController:controller];
    }
}

- (void)pushController:(UIViewController *)controller
{
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ev_nav_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] style:UIBarButtonItemStylePlain target:controller action:@selector(back)];
    controller.navigationItem.leftBarButtonItem = leftButton;
    UINavigationController * navc = [[UINavigationController alloc] initWithRootViewController:controller];
    CATransition *animation = [CATransition animation];
    animation.duration = XQ_KeyboardAnimation_Time;
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    animation.type = @"cube";
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:@"EVTransitionAnimation"];
    [self presentViewController:navc animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
