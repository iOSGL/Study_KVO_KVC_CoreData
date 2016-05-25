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

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) ContentScrollView *contentScrollView;

@property (nonatomic, strong) CommentScrollView *commentScrollView;

@property (nonatomic, assign) BOOL fireMove;

@end
