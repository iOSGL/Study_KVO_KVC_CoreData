//
//  ViewController.m
//  TestKVC_CoreData
//
//  Created by genglei on 16/2/21.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "ViewController.h"
#import "TestPerson.h"
#import "TestKVOViewController.h"
#import "PersonJob.h"
#import "TestColor.h"
#import "PersonObServer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TestPerson *person = [[TestPerson alloc]init];
    [person setValue:@"耿磊" forKey:@"name"];
    [person setValue:[NSNumber numberWithDouble:75] forKey:@"weight"];
    [person setValue:[NSNumber numberWithInteger:23] forKey:@"age"];
    
    PersonJob *job = [[PersonJob alloc]init];
    [job setValue:[NSNumber numberWithInteger:12000] forKey:@"money"];
    [person setValue:job forKey:@"personJob"];
    
    NSLog(@"%@",[person valueForKey:@"name"]);
    NSLog(@"%f",[[person valueForKey:@"weight"] doubleValue]);
    NSLog(@"%zi",[[person valueForKey:@"age"] integerValue]);
    NSLog(@"%zi",[[person valueForKeyPath:@"personJob.money"] integerValue]);
    
    [self loadObserver];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextBtn:(id)sender {
    TestKVOViewController *control = [[TestKVOViewController alloc]init];
    [self.navigationController pushViewController:control animated:YES];
//    [self testMethod];
}

- (void)testMethod {
    
    TestPerson *person = [[TestPerson alloc]init];
    PersonObServer *personObServer = [[PersonObServer alloc]init];
    
    [person addObserver:personObServer forKeyPath:@"name" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:@"this is a context"];
    
    [person setValue:@"耿磊" forKey:@"name"];
    
    [person removeObserver:personObServer forKeyPath:@"name"];
    
}

- (void)loadObserver {
    TestColor *color = [TestColor shareColor];
    [color addObserver:self forKeyPath:@"color" options:NSKeyValueObservingOptionNew context:@"测试KVO"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    NSLog(@"%@",[change objectForKey:NSKeyValueChangeNewKey]);
    self.view.backgroundColor = [change objectForKey:NSKeyValueChangeNewKey];
    NSLog(@"%@",context);
}

@end
