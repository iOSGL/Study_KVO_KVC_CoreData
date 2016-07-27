//
//  firstScrollView.h
//  TestKVC_CoreData
//
//  Created by 66 on 16/5/24.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentScrollView.h"
#import "CommentScrollView.h"

@interface firstScrollView : UIView



+ (instancetype)linkAgeWithScrollView:(UIScrollView *)contentScrollView commentScrollView:(UIScrollView *)commentScrollView;


- (instancetype)initWithFrame:(CGRect)frame linkAgeWithScrollView:(UIScrollView *)contentScrollView commentScrollView:(UIScrollView *)commentScrollView;



@end
