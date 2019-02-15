

@protocol VideoPlayerVCInputProtocol <NSObject>



@end


@protocol VideoPlayerVCOutputProtocol <NSObject>

- (void)setPlayer:(AVPlayer *)player;

- (void)avPlayerStatusReadyToPlay;
- (void)avPlayerStatusFailed;

@end
