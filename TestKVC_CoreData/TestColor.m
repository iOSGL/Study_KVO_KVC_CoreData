//
//  TestColor.m
//  TestKVC_CoreData
//
//  Created by genglei on 16/2/21.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "TestColor.h"

@implementation TestColor

+ (instancetype)shareColor {
    static TestColor *onceColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        onceColor = [[TestColor alloc]init];
        
    });
    return onceColor;
}

@end
