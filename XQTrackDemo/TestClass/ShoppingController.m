//
//  ShoppingController.m
//  XQTrackDemo
//
//  Created by 小强 on 2018/7/8.
//  Copyright © 2018年 小强. All rights reserved.
//

#import "ShoppingController.h"

@interface ShoppingController ()

@property(nonatomic,strong)UIButton * buyBtn;

@end

@implementation ShoppingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewInit];
    
    self.view.isNeedTrack = YES;
    // Do any additional setup after loading the view.
}

- (void)viewInit
{
    [self.view addSubview:self.buyBtn];
}

- (UIButton *)buyBtn
{
    if(!_buyBtn)
    {
        CGFloat btnW = 100;
        CGFloat btnH = 35;
        _buyBtn = [[UIButton alloc] initWithFrame:CGRectMake((WW - btnW)/2, (HH - btnH)/2, btnW, btnH)];
        _buyBtn.layer.cornerRadius = 5;
        [_buyBtn setTitle:@"购买" forState:UIControlStateNormal];
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_buyBtn setTitleColor:RGBColor(222, 222, 222) forState:UIControlStateNormal];
        _buyBtn.trackMessage = @"点击了购买按钮";
        _buyBtn.backgroundColor = RandomColor;
    }
    return _buyBtn;
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
