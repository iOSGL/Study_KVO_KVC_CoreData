//
//  DrawStarView.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/7/25.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "DrawStarView.h"

@interface DrawStarView ()
    // 根据字体大小来确定星星的大小
@property (nonatomic, assign) CGFloat starSize;
    // 总共的长度
@property (nonatomic, assign) NSInteger maxStar;
    //需要显示的星星的个数
@property (nonatomic, assign) CGFloat showStar;
    //未点亮时候的颜色
@property (nonatomic, retain) UIColor *emptyColor;
    //点亮的星星的颜色
@property (nonatomic, retain) UIColor *fullColor;

@property (nonatomic, strong) UILabel *showValueLab;

@end

@implementation DrawStarView

- (instancetype)initWithFrame:(CGRect)frame starSize:(CGFloat)size {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.starSize = size;
        self.emptyColor = [UIColor orangeColor];
        self.fullColor = [UIColor redColor];
        self.maxStar = 100;
        [self addSubview:self.showValueLab];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSString *stars = @"★★★★★";
    rect = self.bounds;
    UIFont *font = [UIFont boldSystemFontOfSize:self.starSize];
    NSDictionary *emptyDic = @{NSFontAttributeName : font, NSForegroundColorAttributeName : self.emptyColor};
    CGSize starSize = [stars sizeWithAttributes:emptyDic];
    self.showValueLab.frame = CGRectMake(starSize.width + 5, 3, 30, 20);
    rect.size=starSize;
    [stars drawInRect:rect withAttributes:emptyDic];
    CGRect clip = rect;
        // 裁剪的宽度 = 点亮星星宽度 = （显示的星星数/总共星星数）*总星星的宽度
    clip.size.width = clip.size.width * self.showStar / self.maxStar;;
    CGContextClipToRect(context,clip);
    NSDictionary *fullDic = @{NSFontAttributeName : font, NSForegroundColorAttributeName : self.fullColor};
    [stars drawInRect:rect withAttributes:fullDic];
}

#pragma mark - Open Method

- (void)setFloatOfStars:(CGFloat)floatOfStars {
     self.showStar = floatOfStars * 20;
    self.showValueLab.text = [NSString stringWithFormat:@"%.1f",floatOfStars];
}

#pragma mark - Setter Getter 

- (UILabel *)showValueLab {
    if (_showValueLab == nil) {
        _showValueLab = [UILabel new];
        _showValueLab.font = [UIFont systemFontOfSize:15];
        _showValueLab.textColor = [UIColor blackColor];
    }
    return _showValueLab;
}


@end
