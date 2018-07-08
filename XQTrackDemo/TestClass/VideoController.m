//
//  VideoController.m
//  XQTrackDemo
//
//  Created by 小强 on 2018/7/8.
//  Copyright © 2018年 小强. All rights reserved.
//

#import "VideoController.h"

@interface VideoController ()

@property(nonatomic,strong)UIButton * playBtn;

@end

@implementation VideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewInit];
    
    self.view.isNeedTrack = YES;

    // Do any additional setup after loading the view.
}

- (void)viewInit
{
    [self.view addSubview:self.playBtn];
}

- (UIButton *)playBtn
{
    if(!_playBtn)
    {
        CGFloat btnW = 100;
        CGFloat btnH = 35;
        _playBtn = [[UIButton alloc] initWithFrame:CGRectMake((WW - btnW)/2, (HH - btnH)/2, btnW, btnH)];
        _playBtn.layer.cornerRadius = 5;
        [_playBtn setTitle:@"播放视频" forState:UIControlStateNormal];
        [_playBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_playBtn setTitleColor:RGBColor(222, 222, 222) forState:UIControlStateNormal];
        _playBtn.trackMessage = @"点击了播放视频按钮";
        _playBtn.backgroundColor = RandomColor;
    }
    return _playBtn;
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
