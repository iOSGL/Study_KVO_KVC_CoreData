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
#import "PropeScroViewViewController.h"
#import "PropeTableViewViewController.h"
#import "StudyViewController.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

/**
 *
 */
@property (nonatomic, strong) TestKVOViewController *nextController;

@property (nonatomic, copy) NSArray *dataSourceArray;

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
    
   [self func:^(NSString *name) {
       NSLog(@"test block %@",name);
   }];
    
   int number = [self sumBlcok:^int(int a, int b) {
        return a + b;
    }];
    
    NSLog(@"%d",number);
    
    _block = ^(NSInteger a, NSInteger b) {
        
        return a +b;
    };
    
    self.dataSourceArray = @[@"next control", @"study ScrollView", @"study TableView", @"如何正确地写好一个界面"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifiers = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiers];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiers];
    }
    cell.textLabel.text = self.dataSourceArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            //    TestKVOViewController *control = [[TestKVOViewController alloc]init];
            //
            __weak ViewController *wself = self;
            //    control.color = ^(UIColor *color){
            //        wself.view.backgroundColor = color;
            //    };
            //
            //    [self.navigationController pushViewController:control animated:YES];
            //    [self testMethod];
            
            NSMutableArray * dataArray = [wself.nextController testSum:^NSMutableArray *(NSArray *dataArray) {
                NSMutableArray * data = [NSMutableArray new];
                [data addObject:dataArray];
                return data;
            }];
            
            NSLog(@"++++%@",[[dataArray lastObject] lastObject]);
        }
            break;
        case 1:{
            PropeScroViewViewController *control = [[PropeScroViewViewController alloc]init];
            [self.navigationController pushViewController:control animated:YES];
        }
            break;
        case 2:{
            PropeTableViewViewController *control = [[PropeTableViewViewController alloc]init];
            [self.navigationController pushViewController:control animated:YES];
        }
            break;
        case 3:{
            StudyViewController *control = [[StudyViewController alloc]init];
            [self.navigationController pushViewController:control animated:YES];
        }
            break;
            
        default:
            break;
    }
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

- (void)func:(blo)blockPro {
    blockPro(@"耿磊");

}

- (int)sumBlcok:(sum)block {
   __block int sum = 0;
    if (block) {
        
       sum =  block (2,3);
        
    }
    return sum;
}

- (TestKVOViewController *)nextController {
    if (_nextController == nil) {
        _nextController = [[TestKVOViewController alloc]init];
    }
    return _nextController;
}

- (void)setBlock:(NSInteger (^)(NSInteger, NSInteger))block {
    
}

@end
