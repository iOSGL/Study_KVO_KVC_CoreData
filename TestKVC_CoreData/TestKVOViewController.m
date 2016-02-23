//
//  TestKVOViewController.m
//  TestKVC_CoreData
//
//  Created by genglei on 16/2/21.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "TestKVOViewController.h"
#import "TestPerson.h"
#import "TestColor.h"

@interface TestKVOViewController ()

@end

@implementation TestKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TestPerson *person = [[TestPerson alloc]init];
    
    NSLog(@"%@",[person valueForKey:@"name"]);
    NSLog(@"%f",[[person valueForKey:@"weight"] doubleValue]);
    NSLog(@"%zi",[[person valueForKey:@"age"] integerValue]);
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)redBtn:(id)sender {
    self.view.backgroundColor = [UIColor redColor];
    [self colorNotifatcion];
//    self.color([UIColor redColor]);
}

- (IBAction)yellowBtn:(id)sender {
    self.view.backgroundColor = [UIColor yellowColor];
    [self colorNotifatcion];
}

- (void)colorNotifatcion {
    
    TestColor *singleColor =  [TestColor shareColor];
    singleColor.color = self.view.backgroundColor;
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
