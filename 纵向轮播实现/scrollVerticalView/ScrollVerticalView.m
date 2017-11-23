//
//  ReportInvestInfoView.m
//  MinaiDai
//
//  Created by zhangting on 2017/11/10.
//  Copyright © 2017年 Xu Ting. All rights reserved.
//

#import "ScrollVerticalView.h"

@interface ScrollVerticalView()

@property(nonatomic, strong) UIImageView *hornImgView;

@property(nonatomic, strong) UIView *bkgView;
@property(nonatomic, strong) UILabel    *frontLabel;
@property(nonatomic, strong) UILabel    *lastLabel;

@property(nonatomic, strong) UIView     *nextBkgView;
@property(nonatomic, strong) UILabel    *nextFrontLabel;
@property(nonatomic, strong) UILabel    *nextLastLabel;

@property(nonatomic, strong) dispatch_source_t timer;
@property(nonatomic, assign) NSInteger     scrollCounts;

@end

static CGFloat const  timeWidth = 70;

@implementation ScrollVerticalView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.scrollCounts = -1;
        self.layer.masksToBounds = YES;
        [self addSubview:self.hornImgView];
        
        [self addSubview:self.bkgView];
        [self.bkgView addSubview:self.frontLabel];
        [self.bkgView addSubview:self.lastLabel];
        
        [self addSubview:self.nextBkgView];
        [self.nextBkgView addSubview:self.nextFrontLabel];
        [self.nextBkgView addSubview:self.nextLastLabel];
    }
    return self;
}

-(void)setInfoArray:(NSMutableArray *)infoArray
{
    _infoArray = infoArray;
    self.scrollCounts = -1;
    [self scrollTimer];
}

#pragma mark getters

-(UIImageView *)hornImgView
{
    if (_hornImgView == nil) {
        _hornImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, CGRectGetHeight(self.frame))];
        _hornImgView.contentMode = UIViewContentModeCenter;
        [_hornImgView setImage:[UIImage imageNamed:@"invest_list_horn_report_icon"]];
    }
    return _hornImgView;
}

-(UIView*)bkgView
{
    if (_bkgView == nil) {
        _bkgView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.hornImgView.frame), CGRectGetHeight(self.frame), CGRectGetWidth(self.frame)-CGRectGetWidth(self.hornImgView.frame)-15, CGRectGetHeight(self.frame))];
        _bkgView.backgroundColor = [UIColor clearColor];
    }
    return _bkgView;
}

-(UILabel*)frontLabel
{
    if (_frontLabel == nil) {
        _frontLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bkgView.frame)-timeWidth, CGRectGetHeight(self.frame))];
        _frontLabel.backgroundColor = [UIColor clearColor];
        _frontLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        _frontLabel.font = [UIFont systemFontOfSize:14.0];
        _frontLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _frontLabel;
}

-(UILabel*)lastLabel
{
    if (_lastLabel == nil) {
        _lastLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frontLabel.frame), 0, CGRectGetWidth(self.bkgView.frame) - CGRectGetWidth(self.frontLabel.frame), CGRectGetHeight(self.frame))];
        _lastLabel.backgroundColor = [UIColor clearColor];
        _lastLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _lastLabel.font = [UIFont systemFontOfSize:14.0];
        _lastLabel.textAlignment = NSTextAlignmentRight;
        _lastLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _lastLabel;
}

-(UIView*)nextBkgView
{
    if (_nextBkgView == nil) {
        _nextBkgView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.hornImgView.frame), CGRectGetMaxY(self.bkgView.frame), CGRectGetWidth(self.frame)-CGRectGetWidth(self.hornImgView.frame)-15, CGRectGetHeight(self.frame))];
        _nextBkgView.backgroundColor = [UIColor clearColor];
    }
    return _nextBkgView;
}

-(UILabel*)nextFrontLabel
{
    if (_nextFrontLabel == nil) {
        _nextFrontLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.nextBkgView.frame)-timeWidth, CGRectGetHeight(self.frame))];
        _nextFrontLabel.backgroundColor = [UIColor clearColor];
        _nextFrontLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        _nextFrontLabel.font = [UIFont systemFontOfSize:14.0];
        _nextFrontLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nextFrontLabel;
}

-(UILabel*)nextLastLabel
{
    if (_nextLastLabel == nil) {
        _nextLastLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frontLabel.frame), 0, CGRectGetWidth(self.nextBkgView.frame) - CGRectGetWidth(self.frontLabel.frame), CGRectGetHeight(self.frame))];
        _nextLastLabel.backgroundColor = [UIColor clearColor];
        _nextLastLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _nextLastLabel.font = [UIFont systemFontOfSize:14.0];
        _nextLastLabel.textAlignment = NSTextAlignmentRight;
        _nextLastLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nextLastLabel;
}

//设置定时器，三秒滚动一次
-(void)scrollTimer
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 3.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        self.scrollCounts++;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.scrollCounts%2 == 0) {
                [self fillScrollContent:YES];
                
                self.bkgView.frame = CGRectMake(CGRectGetWidth(self.hornImgView.frame), CGRectGetHeight(self.frame), CGRectGetWidth(self.frame)-CGRectGetWidth(self.hornImgView.frame)-15, CGRectGetHeight(self.frame));
                
                [UIView animateWithDuration:0.5 animations:^{
                    if (self.scrollCounts != 0) {
                        self.nextBkgView.frame = CGRectMake(CGRectGetWidth(self.hornImgView.frame), -CGRectGetHeight(self.frame), CGRectGetWidth(self.frame)-CGRectGetWidth(self.hornImgView.frame)-15, CGRectGetHeight(self.frame));
                    }
                    self.bkgView.frame = CGRectMake(CGRectGetWidth(self.hornImgView.frame), 0, CGRectGetWidth(self.frame)-CGRectGetWidth(self.hornImgView.frame)-15, CGRectGetHeight(self.frame));
                } completion:^(BOOL finished) {
                    if (finished) {
                        self.nextBkgView.frame = CGRectMake(CGRectGetWidth(self.hornImgView.frame), CGRectGetMaxY(self.bkgView.frame),CGRectGetWidth(self.frame)-CGRectGetWidth(self.hornImgView.frame)-15, CGRectGetHeight(self.frame));
                    }
                }];
            }
            else
            {
                [self fillScrollContent:NO];
                
                self.nextBkgView.frame = CGRectMake(CGRectGetWidth(self.hornImgView.frame), CGRectGetHeight(self.frame), CGRectGetWidth(self.frame)-CGRectGetWidth(self.hornImgView.frame)-15, CGRectGetHeight(self.frame));
                
                [UIView animateWithDuration:0.5 animations:^{
                    self.bkgView.frame = CGRectMake(CGRectGetWidth(self.hornImgView.frame), -CGRectGetHeight(self.frame), CGRectGetWidth(self.frame)-CGRectGetWidth(self.hornImgView.frame)-15, CGRectGetHeight(self.frame));
                    
                    self.nextBkgView.frame = CGRectMake(CGRectGetWidth(self.hornImgView.frame), 0, CGRectGetWidth(self.frame)-CGRectGetWidth(self.hornImgView.frame)-15, CGRectGetHeight(self.frame));
                } completion:^(BOOL finished) {
                    if (finished) {
                        self.bkgView.frame = CGRectMake(CGRectGetWidth(self.hornImgView.frame), CGRectGetMaxY(self.nextBkgView.frame),CGRectGetWidth(self.frame)-CGRectGetWidth(self.hornImgView.frame)-15, CGRectGetHeight(self.frame));
                    }
                }];
            }
        });
    });
    dispatch_resume(_timer);
}

-(void)fillScrollContent:(BOOL)isFirst
{
    if (self.infoArray.count>0) {
        if (isFirst) {
            [self fillLabel:self.frontLabel arrayIndexInfo:[self.infoArray objectAtIndex:self.scrollCounts%self.infoArray.count]];
            self.lastLabel.text = @"08:45";
        }
        else
        {
            [self fillLabel:self.nextFrontLabel arrayIndexInfo:[self.infoArray objectAtIndex:self.scrollCounts%self.infoArray.count]];
            self.nextLastLabel.text = @"10:23";
        }
    }
}

-(void)fillLabel:(UILabel*)label arrayIndexInfo:(NSString*)roll
{
    label.text = roll;
}

@end
