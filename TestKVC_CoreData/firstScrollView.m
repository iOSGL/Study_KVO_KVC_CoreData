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

#define CONTENT_OFF_SET @"contentOffset"
#define CONTENT_OFF_SIZE @"contentSize"

@interface firstScrollView () <UIScrollViewDelegate>{
    CGFloat _lastOffsetY;
    CGFloat _appendHeight;
}

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) UIScrollView *commentScrollView;

@property (nonatomic, assign) BOOL fireMove;

@property (nonatomic, weak) UIScrollView *currentScrollView;

@end

@implementation firstScrollView

#pragma mark - View Life Cycle

+ (instancetype)linkAgeWithScrollView:(UIScrollView *)contentScrollView commentScrollView:(UIScrollView *)commentScrollView {
    firstScrollView *linkAgeView = [[firstScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds linkAgeWithScrollView:contentScrollView commentScrollView:commentScrollView];
    return linkAgeView;
}

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

- (instancetype)initWithFrame:(CGRect)frame linkAgeWithScrollView:(UIScrollView *)contentScrollView commentScrollView:(UIScrollView *)commentScrollView {
    self = [super initWithFrame:frame];
    if (self) {

//        contentScrollView.contentSize = CGSizeMake(contentScrollView.contentSize.width, 500);

        self.contentScrollView = contentScrollView;
//        self.contentScrollView.delegate = self;
        self.commentScrollView = commentScrollView;
        [self.contentScrollView addObserver:self forKeyPath:CONTENT_OFF_SET options:NSKeyValueObservingOptionNew context:@"content"];
        [self.commentScrollView addObserver:self forKeyPath:CONTENT_OFF_SET options:NSKeyValueObservingOptionNew context:@"comment"];
//        [self.commentScrollView addObserver:self forKeyPath:CONTENT_OFF_SIZE options:NSKeyValueObservingOptionNew context:nil];

        CGRect contentRect = _contentScrollView.frame;
        contentRect.size.height = MIN(self.frame.size.height, MAX(_contentScrollView.contentSize.height, contentRect.size.height));
        self.contentScrollView.frame = contentRect;
        _appendHeight = MIN(self.frame.size.height, self.contentScrollView.frame.size.height);
        CGSize contentSize = _contentScrollView.contentSize;

        contentSize.height = MAX(_contentScrollView.contentSize.height, _contentScrollView.frame.size.height) + _appendHeight;

        _contentScrollView.contentSize = contentSize;
        self.commentScrollView.contentInset = UIEdgeInsetsMake(_appendHeight, 0, 0, 0);

        [self addSubview:self.commentScrollView];
        [self addSubview:self.contentScrollView];


    }
    return self;
}

#pragma mark - SysTem Method 

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    [self setStopDeceleration];
    CGFloat pointY = point.y;
    CGFloat commentOffsetY = self.commentScrollView.contentOffset.y;
    self.currentScrollView = self.contentScrollView;
        if (commentOffsetY > 0 ||fabs(commentOffsetY) > _appendHeight) {
            self.currentScrollView = self.commentScrollView;
            return self.currentScrollView;
        } else {
        if (pointY >=  fabs(commentOffsetY)) {
            self.currentScrollView = self.commentScrollView;
            return self.currentScrollView;
        } else {
            self.currentScrollView = self.contentScrollView;
            return self.currentScrollView;
        }

        }
    return self.currentScrollView;
}

- (void)setStopDeceleration {
     [self.contentScrollView setContentOffset:self.contentScrollView.contentOffset animated:NO];
     [self.currentScrollView setContentOffset:self.currentScrollView.contentOffset animated:NO];
}

- (void)dealloc {
    if (self.contentScrollView) {
        [self.contentScrollView removeObserver:self forKeyPath:CONTENT_OFF_SET];
    }
    if (self.commentScrollView) {
        [self.commentScrollView removeObserver:self forKeyPath:CONTENT_OFF_SET];
//        [self.commentScrollView removeObserver:self forKeyPath:CONTENT_OFF_SIZE];
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.currentScrollView != scrollView) {
        return;
    }
    if (scrollView == self.contentScrollView) {
        if (self.contentScrollView.contentOffset.y > (self.contentScrollView.contentSize.height - (_appendHeight * 2)) || self.contentScrollView.contentOffset.y < 0) {

            CGPoint firstOffset = self.contentScrollView.contentOffset;
            CGPoint secondOffset = self.commentScrollView.contentOffset;
            CGFloat y = firstOffset.y - (self.contentScrollView.contentSize.height - _contentScrollView.frame.size.height);
            [self.commentScrollView setContentOffset:CGPointMake(secondOffset.x, y)];
        }else {
            CGPoint secondOffset = self.commentScrollView.contentOffset;
            [self.commentScrollView setContentOffset:CGPointMake(secondOffset.x, -_commentScrollView.frame.size.height)];
        }
    } else if (scrollView == self.commentScrollView) {
        if (self.commentScrollView.contentOffset.y >=0 || self.commentScrollView.contentOffset.y < -self.commentScrollView.frame.size.height) {

            CGPoint firstOffset = self.contentScrollView.contentOffset;
            if (self.commentScrollView.contentOffset.y < -self.commentScrollView.frame.size.height) {
                firstOffset.y = self.contentScrollView.contentSize.height - _contentScrollView.frame.size.height*2;
            }else {
                firstOffset.y = self.contentScrollView.contentSize.height - _contentScrollView.frame.size.height;
            }

            [self.contentScrollView setContentOffset:firstOffset];

        } else {
            CGPoint firstOffset = self.contentScrollView.contentOffset;
            CGPoint secondOffset = self.commentScrollView.contentOffset;
            CGFloat y = self.contentScrollView.contentSize.height - _contentScrollView.frame.size.height + secondOffset.y ;
            NSLog(@"+++%f  inserty=%f",y, _commentScrollView.contentInset.top);
            [self.contentScrollView setContentOffset:CGPointMake(firstOffset.x, y)];
        }
    }


}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

}

//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//    [scrollView setContentOffset:scrollView.contentOffset animated:false];
//}

#pragma mark - KVO Method

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (![keyPath isEqualToString:CONTENT_OFF_SET]) {
        return;
    }
    NSString *identifier = (__bridge NSString *)(context);
    if ([identifier isEqualToString:@"content"]) {
        [self scrollViewDidScroll:self.contentScrollView];
    } else if ([identifier isEqualToString:@"comment"]) {
        [self scrollViewDidScroll:self.commentScrollView];
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

//- (ContentScrollView *)contentScrollView {
//    if (_contentScrollView == nil) {
//        _contentScrollView = [[ContentScrollView alloc]initWithFrame:CGRectZero];
//        _contentScrollView.backgroundColor = [UIColor clearColor];
//        _contentScrollView.delegate = self;
//        _contentScrollView.tag = FIRST_TAG;
//        _contentScrollView.showsVerticalScrollIndicator = NO;
//    }
//    return _contentScrollView;
//}

@end
