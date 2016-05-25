//
//  POPViewController.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/5/20.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <pop/POP.h>
#import <objc/message.h>
#import "TestPerson.h"

#import "POPViewController.h"

#define MAIN_BOUNDS_WIDTH [UIScreen mainScreen].bounds.size.width

#define MAIN_BOUNDS_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface POPViewController ()

@property (nonatomic, strong) UIView *springView;

@property (nonatomic, strong) UIButton *popButton;

@property (nonatomic, strong) UILabel *timeLable;

@property (nonatomic, strong) UILabel *firstLabel;

@property (nonatomic, strong) UILabel *secondLabel;

@property (nonatomic, strong) UILabel *thirdLabel;

@property (nonatomic, strong) CAShapeLayer *shapLayer;

@property (nonatomic, assign) BOOL isTouch ;

@end

@implementation POPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"POP";
//    [self.view addSubview:self.springView];
//    [self.view addSubview:self.timeLable];
//    [self.view addSubview:self.popButton];
//    [self.view addSubview:self.firstLabel];
//    [self.view addSubview:self.secondLabel];
//    [self.view addSubview:self.thirdLabel];
//    [self.view.layer addSublayer:self.shapLayer];

    TestPerson *test = [[TestPerson alloc]init];

    NSString *name = ((NSString *(*) (id,SEL)) objc_msgSend) (test, sel_registerName("showMessageName"));

    NSLog(@"%@",name);



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

#pragma mark - Button Events 

- (void)popAnimation:(UIButton *)sender {
    [self scrollViewLabel];
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
}

#pragma mark - POP Spring 

- (void)popSpring {
    if (!self.isTouch) {
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.springBounciness = 5;
        anim.toValue = [NSValue valueWithCGRect:CGRectMake((MAIN_BOUNDS_WIDTH / 2) - 50, 400, 100, 100)];
        [self.springView pop_addAnimation:anim forKey:@"springKey"];

    }else {

        POPDecayAnimation *decayAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"com.genju" initializer:^(POPMutableAnimatableProperty *prop) {

            prop.readBlock = ^(id object, CGFloat values[]) {
                values[0] = [object center].y;
            };

            prop.writeBlock = ^(id object, const CGFloat values[]) {
                CGPoint center = [object center];
                center.y = values[0];
                NSLog(@"%f",center.y);
                [object setCenter:center];
            };
            prop.threshold = 0.01;

        }];
        decayAnimation.property = prop;
        decayAnimation.velocity = @(1000);
        [self.springView.layer pop_addAnimation:decayAnimation forKey:@"decayAnimation"];
        
    }
    
    self.isTouch = !self.isTouch;
}

#pragma mark - Custorm POP

- (void)custormPOPAnimation {
    if (!self.isTouch) {
        POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"com.genju" initializer:^(POPMutableAnimatableProperty *prop) {
            prop.readBlock = ^(id object, CGFloat values[]) {

            };

            prop.writeBlock = ^(id object, const CGFloat values[]) {
                UILabel *label = (UILabel *)object;
                label.text = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)%100];

            };
            prop.threshold = 0.01;
        }];

        POPBasicAnimation *baseAnimation = [POPBasicAnimation animation];
        baseAnimation.property = prop;
        baseAnimation.fromValue = @(0);
        baseAnimation.toValue = @(3 * 60);
        baseAnimation.duration = 3 * 60;
        baseAnimation.beginTime = CACurrentMediaTime();
        [self.timeLable pop_addAnimation:baseAnimation forKey:@"countdown"];
    } else {
        [self.timeLable pop_removeAnimationForKey:@"countdown"];
    }
    self.isTouch = !self.isTouch;


}

- (void)scrollViewLabel {

    POPBasicAnimation *baseAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
//    baseAnimation.toValue = [NSValue valueWithCGRect:CGRectMake((MAIN_BOUNDS_WIDTH / 2) - 50, 200 - 50, 100, 50)];
    baseAnimation.toValue = @(self.firstLabel.center.y - 50);
    baseAnimation.duration = 1;
    baseAnimation.beginTime = CACurrentMediaTime();
    [self.firstLabel pop_addAnimation:baseAnimation forKey:@"firstScroll"];

    POPBasicAnimation *secondAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    secondAnimation.toValue = @(self.secondLabel.center.y - 50);
    secondAnimation.duration = 1;
    secondAnimation.beginTime = CACurrentMediaTime();
    [self.secondLabel pop_addAnimation:secondAnimation forKey:@"secondScroll"];



}

#pragma mark - Setter Getter

- (UIView *)springView {
    if (_springView == nil) {
        _springView = [UIView new];
        _springView.backgroundColor = [UIColor orangeColor];
        _springView.frame = CGRectMake((MAIN_BOUNDS_WIDTH / 2) - 50, 100, 100, 100);
    }
    return _springView;
}

- (UIButton *)popButton {
    if (_popButton == nil) {
        _popButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_popButton setTitle:@"POP" forState:UIControlStateNormal];
        _popButton.backgroundColor = [UIColor orangeColor];
        [_popButton addTarget:self action:@selector(popAnimation:) forControlEvents:UIControlEventTouchUpInside];
        _popButton.frame = CGRectMake((MAIN_BOUNDS_WIDTH / 2) - 50, MAIN_BOUNDS_HEIGHT - 50, 100, 50);
    }
    return _popButton;
}

- (UILabel *)timeLable {
    if (_timeLable == nil) {
        _timeLable = [UILabel new];
        _timeLable.textColor = [UIColor blackColor];
        _timeLable.frame = CGRectMake((MAIN_BOUNDS_WIDTH / 2) - 25, 300, 100, 50);
    }
    return _timeLable;
}

- (UILabel *)firstLabel {
    if (_firstLabel == nil) {
        _firstLabel = [UILabel new];
        _firstLabel.text = @"first text";
        _firstLabel.textColor = [UIColor blackColor];
        _firstLabel.frame = CGRectMake((MAIN_BOUNDS_WIDTH / 2) - 50, 200, 100, 50);
        _firstLabel.backgroundColor = [UIColor orangeColor];
    }
    return _firstLabel;
}

- (UILabel *)secondLabel {
    if (_secondLabel == nil) {
        _secondLabel = [UILabel new];
        _secondLabel.text = @"second text";
        _secondLabel.textColor = [UIColor blackColor];
        _secondLabel.backgroundColor = [UIColor orangeColor];
        _secondLabel.frame = CGRectMake((MAIN_BOUNDS_WIDTH / 2) - 50, 251, 100, 50);

    }
    return _secondLabel;
}

- (UILabel *)thirdLabel {
    if (_thirdLabel == nil) {
        _thirdLabel = [UILabel new];
        _thirdLabel.text = @"third text";
        _thirdLabel.textColor = [UIColor blackColor];
        _thirdLabel.backgroundColor = [UIColor orangeColor];
        _thirdLabel.frame = CGRectMake((MAIN_BOUNDS_WIDTH / 2) - 50, 302, 100, 50);
    }
    return _thirdLabel;
}

- (CAShapeLayer *)shapLayer {
    if (_shapLayer == nil) {
        _shapLayer = [CAShapeLayer layer];
        _shapLayer.frame = CGRectMake((MAIN_BOUNDS_WIDTH / 2) - 50, 150, 100, 50);
        _shapLayer.opacity = 1;
        _shapLayer.backgroundColor = [UIColor whiteColor].CGColor;
    }
    return _shapLayer;
}



@end
