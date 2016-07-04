//
//  PictureEditorViewController.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/7/1.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "PictureEditorViewController.h"
#import "EditorView.h"

@interface PictureEditorViewController ()

@property (nonatomic, strong) EditorView *editorView;

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@property (nonatomic, strong) UIImageView *bgImgaeView;

@property (nonatomic, strong) UIButton *backBtn;

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
    [self.view addSubview:self.backBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillLayoutSubviews {
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.left.equalTo(self.view.mas_left).offset(5);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Button Event

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Setter Getter 

- (EditorView *)editorView {
    if (_editorView == nil) {
        _editorView = [[EditorView alloc]initWithFrame:self.view.bounds clipType:ClipTypeCycle zoomImage:[UIImage imageNamed:@"pure_girl"]];
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

@end
