//
//  DrawStarView.h
//  TestKVC_CoreData
//
//  Created by 66 on 16/7/25.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawStarView : UIView

- (instancetype)initWithFrame:(CGRect)frame starSize:(CGFloat)size;

@property (nonatomic, assign) CGFloat floatOfStars;

@end
