//
//  PersonObServer.m
//  TestKVC_CoreData
//
//  Created by genglei on 16/2/21.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "PersonObServer.h"

@implementation PersonObServer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    NSLog(@"old %@",[change objectForKey:NSKeyValueChangeOldKey]);
    NSLog(@"new %@",[change objectForKey:NSKeyValueChangeNewKey]);
    NSLog(@"%@",context);
}

@end
