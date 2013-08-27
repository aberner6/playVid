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

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;

@end

@implementation PlayVideoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
 	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    NSString * videoFile = [[NSBundle mainBundle] pathForResource:@"Sensor iPad VIDEO" ofType:@"mov"];
    
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

    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [overlay addGestureRecognizer:self.leftSwipeGestureRecognizer];

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
        case MPMoviePlaybackStatePaused:
            NSLog(@"pause");
            break;
        case MPMoviePlaybackStatePlaying:
            NSLog(@"play");
            break;
        default:
            break;
    }
}

//- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
//{
//    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
//        switch (_mplayer.playbackState) {
//            case MPMoviePlaybackStatePaused:
//                NSLog(@"pauseTap");
//                [_mplayer stop];
//                _mplayer.currentPlaybackTime = .2;
//                _mplayer.shouldAutoplay = NO;
//                _mplayer.view.frame = self.view.bounds;
//                _mplayer.controlStyle = MPMovieControlStyleNone;
//                [self.view addSubview:_mplayer.view];
//                _mplayer.shouldAutoplay = NO;
//                [_mplayer prepareToPlay];
//            default:
//                break;
//        }
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapRecognized:(UITapGestureRecognizer *)recognizer
{
    if (_mplayer.currentPlaybackTime > 1) {
        _mplayer.currentPlaybackTime = 0.2;
    }
    else {
        [_mplayer play];
    }
    
    
//    [_mplayer play];
    
    
//    switch (_mplayer.playbackState) {
//        case MPMoviePlaybackStatePaused:
//            NSLog(@"pauseTap");
//            _mplayer.currentPlaybackTime = .2;
//            _mplayer.shouldAutoplay = NO;
//        case MPMoviePlaybackStateStopped:
//            NSLog(@"stoppedTap");
//            _mplayer.currentPlaybackTime = .2;
////            [_mplayer play];
//            break;
//        default:
//            [_mplayer play];
//            break;
//    }    
}













//- (void)twoTaps:(UITapGestureRecognizer *)recognizer
//{
//    switch (_mplayer.playbackState) {
//        case MPMoviePlaybackStatePaused:
//            NSLog(@"pauseTap");
//            _mplayer.currentPlaybackTime = .2;
//            _mplayer.shouldAutoplay = NO;
//        case MPMoviePlaybackStateStopped:
//            NSLog(@"stoppedTap");
//            _mplayer.currentPlaybackTime = .2;
//            _mplayer.shouldAutoplay = NO;
//            break;
//        default:
//            break;
//    }    
//}

//- (void)tapRecognized:(UITapGestureRecognizer *)recognizer
//{
//    [_mplayer play];
//}


@end
