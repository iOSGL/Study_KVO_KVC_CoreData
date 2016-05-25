//
//  firstScrollView.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/5/24.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "firstScrollView.h"

#define FIRST_TAG 1001

#define SECOND_TAG 1002

@interface firstScrollView () <UIScrollViewDelegate>

@end

@implementation firstScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.commentScrollView];
        [self configSecondScrollView];
        [self addSubview:self.contentScrollView];
        [self configFirstScrollView];

    }
    return self;
};

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

}

#pragma mark - System Method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.contentScrollView.contentOffset.y > self.frame.size.height) {

    if (scrollView == self.contentScrollView) {
            CGPoint firstOffset = self.contentScrollView.contentOffset;
            CGPoint secondOffset = self.commentScrollView.contentOffset;
            CGFloat y = firstOffset.y - self.frame.size.height;
            secondOffset.y = y;
            [self.commentScrollView setContentOffset:secondOffset];
    } else if (scrollView == self.commentScrollView) {

        CGPoint secondOffset = self.commentScrollView.contentOffset;
        CGPoint firstOffset = self.contentScrollView.contentOffset;
        firstOffset.y = secondOffset.y + self.frame.size.height;
        NSLog(@"scrollViewDidScroll second offset y %f  %f %f",secondOffset.y,self.contentScrollView.contentOffset.y, firstOffset.y);
        [self.contentScrollView setContentOffset:firstOffset];

     }
   }

}

#pragma mark - Private Method

- (void)configFirstScrollView {
    CGRect rect = self.contentScrollView.bounds;
    for (NSInteger i = 0; i < 2; i ++) {
        UIView *content = [[UIView alloc]init];
        rect.origin.y = i * self.frame.size.height;
        content.frame = rect;
        if (i == 0) {
            content.backgroundColor = [UIColor orangeColor];
        }else {
            content.backgroundColor = [UIColor blueColor];
        }
        [self.contentScrollView addSubview:content];
    }
    [self.contentScrollView setContentSize:CGSizeMake(self.frame.size.width, [UIScreen mainScreen].bounds.size.height * 3)];
}

- (void)configSecondScrollView {
    CGRect rect = self.commentScrollView.bounds;
    for (NSInteger i = 0; i < 2; i ++) {
        UIView *content = [[UIView alloc]init];
        rect.origin.y = i * self.frame.size.height;
        content.frame = rect;
        if (i == 0) {
            content.backgroundColor = [UIColor clearColor];
        }else {
            content.backgroundColor = [UIColor yellowColor];
        }
        [self.commentScrollView addSubview:content];
    }
    [self.commentScrollView setContentSize:CGSizeMake(self.frame.size.width, [UIScreen mainScreen].bounds.size.height * 2)];
}

#pragma mark - Setter Getter

- (ContentScrollView *)contentScrollView {
    if (_contentScrollView == nil) {
        _contentScrollView = [[ContentScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _contentScrollView.backgroundColor = [UIColor clearColor];
        _contentScrollView.delegate = self;
        _contentScrollView.tag = FIRST_TAG;
        _contentScrollView.showsVerticalScrollIndicator = NO;
    }
    return _contentScrollView;
}

- (CommentScrollView *)commentScrollView {
    if (_commentScrollView == nil) {
        _commentScrollView = [[CommentScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _commentScrollView.delegate = self;
        _commentScrollView.backgroundColor = [UIColor clearColor];
        _commentScrollView.tag = SECOND_TAG;
        _commentScrollView.showsVerticalScrollIndicator = NO;
//        _commentScrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0);
    }
    return _commentScrollView;
}


@end
