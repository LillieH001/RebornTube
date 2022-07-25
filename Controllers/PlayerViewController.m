#import "PlayerViewController.h"

@interface PlayerViewController ()
{
	AVPlayer *player;
	AVPlayerLayer *playerLayer;
	AVPictureInPictureController *pictureInPictureController;

	UIView *rewindView;
	UIView *playPauseView;
	UIView *forwardView;

	UILabel *videoTitleLabel;
	UILabel *videoInfoLabel;
}
@end

@implementation PlayerViewController

- (void)loadView {
	[super loadView];

	/* self.title = @"";
	self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
	[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack; */

	[self.navigationController setNavigationBarHidden:YES animated:NO];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
	
	UIWindow *boundsWindow = [[UIApplication sharedApplication] keyWindow];

	AVURLAsset *audioAsset = [[AVURLAsset alloc] initWithURL:self.audioURL options:nil];
	AVURLAsset *videoAsset = [[AVURLAsset alloc] initWithURL:self.videoURL options:nil];

	AVMutableComposition *mixComposition = [AVMutableComposition composition];

	AVMutableCompositionTrack *compositionCommentaryTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
	[compositionCommentaryTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration) ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];

	AVMutableCompositionTrack *compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
	[compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration) ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:kCMTimeZero error:nil];

	AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithAsset:mixComposition];

	player = [AVPlayer playerWithPlayerItem:playerItem];
	[player addObserver:self forKeyPath:@"status" options:0 context:nil];

	playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
	playerLayer.frame = CGRectMake(0, boundsWindow.safeAreaInsets.top, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
	[self.view.layer addSublayer:playerLayer];

	rewindView = [[UIView alloc] init];
	rewindView.frame = CGRectMake(0, boundsWindow.safeAreaInsets.top, self.view.bounds.size.width / 3, self.view.bounds.size.width * 9 / 16);
	UITapGestureRecognizer *rewindViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rewindTap:)];
	rewindViewTap.numberOfTapsRequired = 2;
	[rewindView addGestureRecognizer:rewindViewTap];
	[self.view addSubview:rewindView];
	
	playPauseView = [[UIView alloc] init];
	playPauseView.frame = CGRectMake(self.view.bounds.size.width / 3, boundsWindow.safeAreaInsets.top, self.view.bounds.size.width / 3, self.view.bounds.size.width * 9 / 16);
	UITapGestureRecognizer *playPauseViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playPauseTap:)];
	playPauseViewTap.numberOfTapsRequired = 2;
	[playPauseView addGestureRecognizer:playPauseViewTap];
	[self.view addSubview:playPauseView];

	forwardView = [[UIView alloc] init];
	forwardView.frame = CGRectMake((self.view.bounds.size.width / 3) * 2, boundsWindow.safeAreaInsets.top, self.view.bounds.size.width / 3, self.view.bounds.size.width * 9 / 16);
	UITapGestureRecognizer *forwardViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forwardTap:)];
	forwardViewTap.numberOfTapsRequired = 2;
	[forwardView addGestureRecognizer:forwardViewTap];
	[self.view addSubview:forwardView];

	videoTitleLabel = [[UILabel alloc] init];
	videoTitleLabel.frame = CGRectMake(0, boundsWindow.safeAreaInsets.top + playerLayer.frame.size.height, self.view.bounds.size.width, 40);
	videoTitleLabel.text = self.videoTitle;
	videoTitleLabel.textColor = [UIColor whiteColor];
	videoTitleLabel.numberOfLines = 2;
	videoTitleLabel.adjustsFontSizeToFitWidth = true;
	videoTitleLabel.adjustsFontForContentSizeCategory = false;
	[self.view addSubview:videoTitleLabel];

	videoInfoLabel = [[UILabel alloc] init];
	videoInfoLabel.frame = CGRectMake(0, boundsWindow.safeAreaInsets.top + playerLayer.frame.size.height + videoTitleLabel.frame.size.height, self.view.bounds.size.width, 60);
	videoInfoLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@", self.videoViewCount, self.videoLikes, self.videoDislikes];
	videoInfoLabel.textColor = [UIColor whiteColor];
	videoInfoLabel.numberOfLines = 3;
	videoInfoLabel.adjustsFontSizeToFitWidth = true;
	videoInfoLabel.adjustsFontForContentSizeCategory = false;
	[self.view addSubview:videoInfoLabel];
}

@end

@implementation PlayerViewController (Privates)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == player && [keyPath isEqualToString:@"status"]) {
        if (player.status == AVPlayerStatusReadyToPlay) {
            if ([AVPictureInPictureController isPictureInPictureSupported]) {
                pictureInPictureController = [[AVPictureInPictureController alloc] initWithPlayerLayer:playerLayer];
                pictureInPictureController.delegate = self;
                if (@available(iOS 14.2, *)) {
                    pictureInPictureController.canStartPictureInPictureAutomaticallyFromInline = YES;
                }
            }
            [player play];
        }
    }
}

- (void)rewindTap:(UITapGestureRecognizer *)recognizer {
	NSTimeInterval currentTime = CMTimeGetSeconds(player.currentTime);
	NSTimeInterval newTime = currentTime - 5.0f;
	CMTime time = CMTimeMakeWithSeconds(newTime, NSEC_PER_SEC);
	[player seekToTime:time];
}

- (void)playPauseTap:(UITapGestureRecognizer *)recognizer {
	if (player.timeControlStatus == AVPlayerTimeControlStatusPlaying) {
		[player pause];
	} else {
		[player play];
	}
}

- (void)forwardTap:(UITapGestureRecognizer *)recognizer {
	NSTimeInterval currentTime = CMTimeGetSeconds(player.currentTime);
	NSTimeInterval newTime = currentTime + 5.0f;
	CMTime time = CMTimeMakeWithSeconds(newTime, NSEC_PER_SEC);
	[player seekToTime:time];
}

- (void)orientationChanged:(NSNotification *)notification {
	UIWindow *boundsWindow = [[UIApplication sharedApplication] keyWindow];
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	switch (orientation) {
		case UIInterfaceOrientationPortrait:
		playerLayer.frame = CGRectMake(0, boundsWindow.safeAreaInsets.top, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
		rewindView.frame = CGRectMake(0, boundsWindow.safeAreaInsets.top, self.view.bounds.size.width / 3, self.view.bounds.size.width * 9 / 16);
		playPauseView.frame = CGRectMake(self.view.bounds.size.width / 3, boundsWindow.safeAreaInsets.top, self.view.bounds.size.width / 3, self.view.bounds.size.width * 9 / 16);
		forwardView.frame = CGRectMake((self.view.bounds.size.width / 3) * 2, boundsWindow.safeAreaInsets.top, self.view.bounds.size.width / 3, self.view.bounds.size.width * 9 / 16);
		break;

		case UIInterfaceOrientationLandscapeLeft:
		playerLayer.frame = self.view.bounds;
		rewindView.frame = CGRectMake(0, 0, self.view.bounds.size.width / 3, self.view.bounds.size.height);
		playPauseView.frame = CGRectMake(self.view.bounds.size.width / 3, 0, self.view.bounds.size.width / 3, self.view.bounds.size.height);
		forwardView.frame = CGRectMake((self.view.bounds.size.width / 3) * 2, 0, self.view.bounds.size.width / 3, self.view.bounds.size.height);
		break;

		case UIInterfaceOrientationLandscapeRight:
		playerLayer.frame = self.view.bounds;
		rewindView.frame = CGRectMake(0, 0, self.view.bounds.size.width / 3, self.view.bounds.size.height);
		playPauseView.frame = CGRectMake(self.view.bounds.size.width / 3, 0, self.view.bounds.size.width / 3, self.view.bounds.size.height);
		forwardView.frame = CGRectMake((self.view.bounds.size.width / 3) * 2, 0, self.view.bounds.size.width / 3, self.view.bounds.size.height);
		break;
	}
}

@end