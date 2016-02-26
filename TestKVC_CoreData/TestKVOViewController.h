//
//  TestKVOViewController.h
//  TestKVC_CoreData
//
//  Created by genglei on 16/2/21.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^changColor)(UIColor *color);

typedef NSMutableArray *(^testSum)(NSArray *dataArray);

@interface TestKVOViewController : UIViewController

@property (nonatomic, copy) changColor color;

- (NSMutableArray *)testSum:(testSum)sum;

@end
