//
//  VideoInteractor.m
//  VIPVideo
//
//  Created by lichanghong on 2/6/19.
//  Copyright © 2019 li.haihong.com. All rights reserved.
//

#import "VideoInteractor.h"


@interface VideoInteractor()


@end


@implementation VideoInteractor
{
    NSDateFormatter *_dateFormatter;
    NSString *_totalTime;

}

// KVO方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            [self.presenter avPlayerStatusReadyToPlay];
            [self avPlayerReadyToPlayWithPlayerItem:playerItem];
        } else {
            [self.presenter avPlayerStatusFailed];
            NSLog(@"AVPlayerStatusFailed %ld",[playerItem status]);
        }
    }
    //    else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
    //        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
    //        NSLog(@"Time Interval:%f",timeInterval);
    //        CMTime duration = _playerItem.duration;
    //        CGFloat totalDuration = CMTimeGetSeconds(duration);
    //        [self.videoProgress setProgress:timeInterval / totalDuration animated:YES];
    //    }
}

- (void)avPlayerReadyToPlayWithPlayerItem:(AVPlayerItem *)playerItem
{
    CMTime duration = playerItem.duration;// 获取视频总长度
    _totalTime = [self formatTimeWithTimeInterVal: CMTimeGetSeconds(duration)];
    CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;// 转换成秒
    NSLog(@"AVPlayerStatusReadyToPlay duration = %@",_totalTime);
    //            [self customVideoSlider:duration];// 自定义UISlider外观
  
}

//- (NSTimeInterval)availableDuration {
//    NSArray *loadedTimeRanges = [[self.player currentItem] loadedTimeRanges];
//    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
//    float startSeconds = CMTimeGetSeconds(timeRange.start);
//    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
//    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
//    return result;
//}

- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [[self dateFormatter] stringFromDate:d];
    return showtimeNew;
}

//转换时间格式的方法
- (NSString *)formatTimeWithTimeInterVal:(NSTimeInterval)timeInterVal{
    int minute = 0, hour = 0, secend = timeInterVal;
    minute = (secend % 3600)/60;
    hour = secend / 3600;
    secend = secend % 60;
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, secend];
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}



 


@end
