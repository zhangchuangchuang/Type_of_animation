//
//  ViewController.h
//  打字动画
//
//  Created by MS on 15-12-20.
//  Copyright (c) 2015年 Tong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController : UIViewController<AVAudioPlayerDelegate>
{
    AVAudioPlayer * _mp3;//播放器;
    UIProgressView * _schedule;//进度;
    UISlider * _voice;  //声音控制;
    NSTimer * _timer;   //控制进度;
}

@end

