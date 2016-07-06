//
//  PictureEditorViewController.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/7/1.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "PictureEditorViewController.h"
#import "EditorView.h"
#import "ClipImageViewController.h"

@interface PictureEditorViewController ()

@property (nonatomic, strong) EditorView *editorView;

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@property (nonatomic, strong) UIImageView *bgImgaeView;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UIView *topBarView;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UIView *tabBarView;

@property (nonatomic, strong) UIButton *clipBtn;


@end

@implementation PictureEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.editorView];
    [self.view addSubview:self.topBarView];
    [self.topBarView addSubview:self.backBtn];
    [self.topBarView addSubview:self.titleLab];
    [self.view addSubview:self.tabBarView];
    [self.tabBarView addSubview:self.clipBtn];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillLayoutSubviews {
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBarView.mas_top).offset(20);
        make.left.equalTo(self.topBarView.mas_left).offset(5);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    [self.topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(64);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBarView.mas_top).offset(32);
        make.centerX.equalTo(self.topBarView.mas_centerX);
    }];
    [self.tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(44);
    }];
    [self.clipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tabBarView.mas_right).offset(-10);
        make.centerY.equalTo(self.tabBarView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Button Event

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clopAction:(UIButton *)sender {
    ClipImageViewController *control = [[ClipImageViewController alloc]initWithImgae:[self.editorView circularClipImage]];
    [self.navigationController pushViewController:control animated:YES];
}

- (void)hideImageViewAction:(UIButton *)seder {
}

#pragma mark - Setter Getter 

- (EditorView *)editorView {
    if (_editorView == nil) {
        _editorView = [[EditorView alloc]initWithFrame:self.view.bounds clipType:ClipTypeRect zoomImage:[UIImage imageNamed:@"pure_girl"]];
    }
    return _editorView;
}

- (UIImageView *)bgImgaeView {
    if (_bgImgaeView == nil) {
        _bgImgaeView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _bgImgaeView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImgaeView.image = [UIImage imageNamed:@"pure_girl"];
    }
    return _bgImgaeView;
}

- (UIButton *)backBtn {
    if (_backBtn == nil) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIView *)topBarView {
    if (_topBarView == nil) {
        _topBarView = [UIView new];
        _topBarView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75f];
    }
    return _topBarView;
}

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [UILabel new];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.text = @"移动和缩放";
        _titleLab.font = [UIFont boldSystemFontOfSize:17];
    }
    return _titleLab;
}

- (UIView *)tabBarView {
    if (_tabBarView == nil) {
        _tabBarView = [UIView new];
        _tabBarView.backgroundColor = [UIColor colorWithWhite:1.f alpha:0.9f];
    }
    return _tabBarView;
}

- (UIButton *)clipBtn {
    if (_clipBtn == nil) {
        _clipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clipBtn.backgroundColor = [UIColor orangeColor];
        [_clipBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_clipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_clipBtn addTarget:self action:@selector(clopAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clipBtn;
}


@end
