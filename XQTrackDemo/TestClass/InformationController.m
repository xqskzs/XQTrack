//
//  InformationController.m
//  XQTrackDemo
//
//  Created by 小强 on 2018/7/8.
//  Copyright © 2018年 小强. All rights reserved.
//

#import "InformationController.h"

@interface InformationController ()

@property(nonatomic,strong)UIButton * lookInforBtn;

@end

@implementation InformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewInit];
    
    self.view.isNeedTrack = YES;

    // Do any additional setup after loading the view.
}

- (void)viewInit
{
    [self.view addSubview:self.lookInforBtn];
}

- (UIButton *)lookInforBtn
{
    if(!_lookInforBtn)
    {
        CGFloat btnW = 100;
        CGFloat btnH = 35;
        _lookInforBtn = [[UIButton alloc] initWithFrame:CGRectMake((WW - btnW)/2, (HH - btnH)/2, btnW, btnH)];
        _lookInforBtn.layer.cornerRadius = 5;
        [_lookInforBtn setTitle:@"查看资讯" forState:UIControlStateNormal];
        [_lookInforBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_lookInforBtn setTitleColor:RGBColor(222, 222, 222) forState:UIControlStateNormal];
        _lookInforBtn.trackMessage = @"点击了查看资讯按钮";
        _lookInforBtn.backgroundColor = RandomColor;
    }
    return _lookInforBtn;
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
