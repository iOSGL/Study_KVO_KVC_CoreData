//
//  PropeScroViewViewController.m
//  TestKVC_CoreData
//
//  Created by geng lei on 16/2/26.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "PropeScroViewViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface PropeScroViewViewController () <UIScrollViewDelegate>
/**
 *
 */
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *scrollBackGroundView;

@end

@implementation PropeScroViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.scrollBackGroundView];
    [self addUI];
    
   
}

- (void)viewWillLayoutSubviews {
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
//    [self.scrollBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"contentOffset y = %f",scrollView.contentOffset.y);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"开始拖动了");
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"velocity y = %f ",velocity.y);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"decelerate = %zi",decelerate);
    if (!decelerate) {
        [self snapToNearestItem];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    NSLog(@"————————将要减速");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"————————完成减速");
    NSLog(@"contentOffset x = %f",scrollView.contentOffset.x);
    [self snapToNearestItem];
}

#pragma mark - Private Method

- (void)addUI {
    NSArray *colorArray = @[[UIColor redColor], [UIColor orangeColor], [UIColor grayColor]];
    for (NSInteger i = 0; i < 3; i ++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH *i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        view.backgroundColor = colorArray[i];
        [self.scrollBackGroundView addSubview:view];
    }
}

- (CGPoint)nearestTargetOffsetForOffset:(CGPoint)offset {
    
    CGFloat distance = fmod(offset.x, SCREEN_WIDTH);
    
    NSInteger sanp = offset.x / SCREEN_WIDTH;
    
    CGFloat intermediate = SCREEN_WIDTH / 2;
    
    CGFloat contentOffset;
    
    if (distance > intermediate) {
        contentOffset = (sanp + 1) * SCREEN_WIDTH;
    }else {
        contentOffset = sanp * SCREEN_WIDTH;
    }
    
    return CGPointMake(contentOffset, offset.y);
}

- (void)snapToNearestItem
{
    CGPoint targetOffset = [self nearestTargetOffsetForOffset:self.scrollView.contentOffset];
    [self.scrollView setContentOffset:targetOffset animated:YES];
}

#pragma mark - Setter Getter 

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, 0);
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

- (UIView *)scrollBackGroundView {
    if (_scrollBackGroundView == nil) {
        _scrollBackGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        _scrollBackGroundView = [UIView new];
        _scrollBackGroundView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollBackGroundView;
}


@end
