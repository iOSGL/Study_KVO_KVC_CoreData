//
//  ViewController.h
//  TestKVC_CoreData
//
//  Created by genglei on 16/2/21.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blo)(NSString *name);

typedef int(^sum)(int a, int b);

@interface ViewController : UIViewController

- (void)func:(blo)blockPro;

- (int)sumBlcok:(sum)block;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 *  navigation View
 */
@property (nonatomic, copy) NSInteger(^block)(NSInteger a, NSInteger b);

@end

