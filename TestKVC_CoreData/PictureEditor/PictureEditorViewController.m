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

@end

@implementation PictureEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgImgaeView];
    [self.view addSubview:self.editorView];
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

#pragma mark - Setter Getter 

- (EditorView *)editorView {
    if (_editorView == nil) {
        _editorView = [[EditorView alloc]initWithFrame:self.view.bounds clipType:ClipTypeRect];
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

@end
