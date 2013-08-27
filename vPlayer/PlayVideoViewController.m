//
//  PlayVideoViewController.m
//  vPlayer
//
//  Created by Annelie Berner on 8/24/13.
//  Copyright (c) 2013 Annelie Berner. All rights reserved.
//

#import "PlayVideoViewController.h"

@interface PlayVideoViewController ()

@property (nonatomic, strong) MPMoviePlayerController *mplayer;

@end

@implementation PlayVideoViewController
//@synthesize moviePlayer;
//@synthesize player;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor clearColor];
    
        NSString * videoFile = [[NSBundle mainBundle] pathForResource:@"Sensor iPad VIDEO" ofType:@"mov"];
    
//        _playerViewController=[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:videoFile]];
    
    _mplayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:videoFile]];
    _mplayer.view.frame = self.view.bounds;
    _mplayer.controlStyle = MPMovieControlStyleNone;

    [self.view addSubview:_mplayer.view];
    _mplayer.shouldAutoplay = NO;
    [_mplayer prepareToPlay];
    
    [self registerPlayerNotification];
    
    UIView *overlay = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:overlay];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    [overlay addGestureRecognizer:tap];
}


- (void)registerPlayerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_mplayer];
}


- (void)playerStateDidChange:(NSNotification *)notification
{
    switch (_mplayer.playbackState) {
        case MPMoviePlaybackStateStopped:
            NSLog(@"stopped");
            break;
        case MPMoviePlaybackStateInterrupted:
            NSLog(@"inter");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"pause");
            _mplayer.currentPlaybackTime = 12.0; //0.2
            break;
        case MPMoviePlaybackStatePlaying:
            NSLog(@"play");
            _mplayer.currentPlaybackTime = .1; //0.2
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tapRecognized:(UITapGestureRecognizer *)recognizer
{
    [_mplayer play];

//    switch (_mplayer.playbackState) {
//        case .currentPlaybackTime==12:
//            NSLog(@"play");
//            break;
//        default:
//            break;
//    }

}


@end
