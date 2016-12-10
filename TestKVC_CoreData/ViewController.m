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
#import "TestThreadViewController.h"
#import "CornerRadiusViewController.h"
#import "CoreAnimationViewController.h"
#import "TransitionsViewController.h"
#import "GJ_AnimationViewController.h"
#import "POPViewController.h"
#import "LocalNotificationViewController.h"
#import "ScrollVIewViewController.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

/**
 *
 */
@property (nonatomic, strong) TestKVOViewController *nextController;

@property (nonatomic, copy) NSArray *dataSourceArray;

@property (nonatomic, copy) NSArray *classNmaeArray;

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

    self.classNmaeArray = @[@"TestKVOViewController", @"PropeScroViewViewController", @"PropeTableViewViewController", @"StudyViewController", @"TestThreadViewController", @"CornerRadiusViewController", @"CoreAnimationViewController", @"TransitionsViewController", @"GJ_AnimationViewController", @"GJFiltersViewController", @"InstagramViewController", @"POPViewController", @"LocalNotificationViewController", @"ScrollVIewViewController", @"WelcormeViewController", @"PictureEditorViewController", @"StarViewController", @"FirstViewController"];
    
    self.dataSourceArray = @[@"next control", @"study ScrollView", @"study TableView", @"如何正确地写好一个界面", @"Test Thread", @"高效添加圆角", @"Core Animation", @"Transitions", @"66_Transition", @"Filters", @"Instagram", @"POP", @"LocalNotification", @"ScrollVIewViewController", @"guideAnimation", @"image Editor", @"star",@"FirstViewController"];
    
    dispatch_queue_t queue = dispatch_queue_create("com.fengche.com", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    __block NSString *str = @"";
    
   dispatch_group_async(group, queue, ^{
//       double afterTime = 2.f;
//       dispatch_time_t tiem = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterTime * NSEC_PER_MSEC));
//       dispatch_after(tiem, dispatch_get_main_queue(), ^{
           str = @"123";
           NSLog(@"1result === %@",str);
//       });
   });
    
    dispatch_group_async(group, queue, ^{
//        double afterTime = 2.f;
//        dispatch_time_t tiem = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterTime * NSEC_PER_MSEC));
//        dispatch_after(tiem, dispatch_get_main_queue(), ^{
            str = [str stringByAppendingString:@"456"];
            NSLog(@"2result === %@",str);
//        });
    });
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
   dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"3result === %@",str);
   });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"4result === %@",str);
    });


    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(200, 70, 50, 50);
    [btn addTarget:self action:@selector(screenShot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    
}


- (void)screenShot {
    CGPoint contentSet = self.tableView.contentOffset;
//    self.tableView.height = self.tableView.contentSize.height;
    CGRect rect = self.tableView.bounds;
    rect.size.height = self.tableView.contentSize.height;
    self.tableView.frame =rect;
    NSLog(@"++++++++%@",self.tableView);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.tableView.contentSize.width,self.tableView.contentSize.height), false, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    UIGraphicsPopContext();
    [self.tableView.layer renderInContext:context];
    UIImage *shortImage = UIGraphicsGetImageFromCurrentImageContext();
    NSLog(@"  ------>>>>%@  %f",shortImage,self.tableView.contentSize.height);
    UIGraphicsEndImageContext();
    self.tableView.bounds = self.view.bounds;
    self.tableView.contentOffset = contentSet;
    UIImageWriteToSavedPhotosAlbum(shortImage, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
}

-  (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error == nil) {
        NSLog(@"保存成功");
    } else {
        NSLog(@"失败");
    }
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
    NSString *className = self.classNmaeArray[indexPath.row];
    Class targetClass = NSClassFromString(className);
    if (targetClass) {
        UIViewController *conteol = targetClass.new;
        conteol.title = className;
        [self.navigationController pushViewController:conteol animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
