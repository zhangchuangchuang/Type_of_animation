//
//  ViewController.m
//  打字动画
//
//  Created by MS on 15-12-20.
//  Copyright (c) 2015年 Tong. All rights reserved.
//

#import "ViewController.h"
#import "XFTViewController.h"
@interface ViewController ()

@end

@implementation ViewController

#pragma mark - 创建界面
-(void)creatButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(100, 100, 60, 40)];
    [button setTitle:@"Play" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 setFrame:CGRectMake(100, 150, 60, 40)];
    [button1 setTitle:@"pause" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 setFrame:CGRectMake(100, 200, 60, 40)];
    [button2 setTitle:@"stop" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100, self.view.frame.size.height-100, 70, 50)];
    [button3 setTitle:@"下一页" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
    button3.backgroundColor = [UIColor redColor];
    [self.view addSubview:button3];


}

#pragma mark - 接口
-(void)play{
    [_mp3 play];
}
-(void)pause{
    [_mp3 pause];
}
-(void)stop{
    [_mp3 stop];
}

//播放进度条
-(void)playProgress{
    //通过音频播放时长的百分比,给_schedule(进度)进行赋值;
    _schedule.progress = _mp3.currentTime/_mp3.duration;
}
-(void)volumeChange{
    _mp3.volume = _voice.value;
}


//播放完成时调用的方法  (代理里的方法),需要设置代理才可以调用
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [_timer invalidate]; //NSTimer暂停   invalidate  使...无效;
}

//下一页
-(void)btn3Click{
    [_mp3 stop];
    XFTViewController * next = [[XFTViewController alloc]init];
    [self presentViewController:next animated:YES completion:nil];
    
}


#pragma mark - 设置播放器

-(void)setPlayer{
    NSString * str = [[NSBundle mainBundle]pathForResource:@"雅尼 - 夜莺 - Yanni 天籁之音" ofType:@"mp3"];
    //把音频文件转换成url格式
    NSURL * url = [NSURL fileURLWithPath:str];
    //初始化音频类并且,添加播放条件
    _mp3 = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    _mp3.delegate = self;
    //设置初始音量
    _mp3.volume = 1.0;
    //设置播放次数
    _mp3.numberOfLoops = -1;    //-1为循环播放

    //预播放
    [_mp3 play];
    [_mp3 prepareToPlay];


    //初始化一个播放进度条
    _schedule = [[UIProgressView alloc] initWithFrame:CGRectMake(20, 50, 200, 20)];

    [self.view addSubview:_schedule];

    //监控音频播放进度
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playProgress) userInfo:nil repeats:YES];
    //初始化音量控制
    _voice = [[UISlider alloc]initWithFrame:CGRectMake(20, 70, 200, 20)];
    [_voice addTarget:self action:@selector(volumeChange) forControlEvents:UIControlEventValueChanged];
    //最小音量
    _voice.minimumValue = 0.0;
    //最大
    _voice.maximumValue = 10.0;
    //初始音量
    _voice.value = 3.0;
    [self.view addSubview:_voice];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatButton];
    [self setPlayer];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
