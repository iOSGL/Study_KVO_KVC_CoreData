//
//  TestColor.h
//  TestKVC_CoreData
//
//  Created by genglei on 16/2/21.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TestColor : NSObject

+ (instancetype)shareColor;

@property (nonatomic, strong) UIColor *color;


@end
