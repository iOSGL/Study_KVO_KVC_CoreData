//
//  CommentScrollView.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/5/25.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "CommentScrollView.h"

@implementation CommentScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return self;
}

@end
