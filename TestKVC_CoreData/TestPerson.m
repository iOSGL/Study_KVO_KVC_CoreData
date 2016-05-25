//
//  TestPerson.m
//  TestKVC_CoreData
//
//  Created by genglei on 16/2/21.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "TestPerson.h"

@implementation TestPerson

- (void)setAnimatableValue:(CGFloat)animatableValue {
    _animatableValue = animatableValue;
    NSLog(@"%zi", animatableValue);
    
}

- (NSString *)showMessageName; {
    return @"runtime";
}



@end
