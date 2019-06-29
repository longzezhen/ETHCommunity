//
//  BaseWKWebView.m
//  ThreeSandOcean
//
//  Created by 龙泽桢 on 2019/5/27.
//  Copyright © 2019 tools. All rights reserved.
//

#import "BaseWKWebView.h"
@interface BaseWKWebView()
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation BaseWKWebView
- (instancetype)init{
    
    self = [super init];
    if (self) {
        self.opaque = NO;
        self.scrollView.bounces = NO;
        self.backgroundColor = [UIColor clearColor];
        self.scrollView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.progressView];
        [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

- (void)dealloc{
    
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
    
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        _progressView.progress = self.estimatedProgress;
        
        if (_progressView.progress == 1) {
            
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
                
            } completion:^(BOOL finished) {
                
                self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
                self.progressView.progress = 0;
                
            }];
        }
    }
}

#pragma mark - SET/GET
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 2)];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progressTintColor = [UIColor greenColor];
        // 设置初始的进度，防止用户进来就懵逼了（微信大概也是一开始设置的10%的默认值）
        [_progressView setProgress:0.1 animated:YES];
    }
    return _progressView;
}

@end
