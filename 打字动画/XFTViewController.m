//
//  XFTViewController.m
//  打字动画
//
//  Created by MS on 15-12-20.
//  Copyright (c) 2015年 Tong. All rights reserved.
//

#import "XFTViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface XFTViewController ()

@property (nonatomic,strong)MPMoviePlayerController * moviePlayer;//视频控制器
@end

@implementation XFTViewController
#pragma mark - 懒加载
-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSString *urlStr=[[NSBundle mainBundle] pathForResource:@"222.mp4" ofType:nil];
        NSURL * url = [NSURL fileURLWithPath:urlStr];

        _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.frame = self.view.bounds;
        _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];

    }
    return _moviePlayer;
}

//添加通知监控媒体播放监控控制器状态
-(void)addNotification{
    NSNotificationCenter * notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [notification addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
}

//播放状态改变，注意播放完成时的状态是暂停
//通知对象
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
            break;
    }
}


//播放完成   @param notification 通知对象

-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.moviePlayer.playbackState);
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.moviePlayer play];
    [self addNotification];
    // Do any additional setup after loading the view.
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
