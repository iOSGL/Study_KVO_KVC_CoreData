//
//  InstagramViewController.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/5/5.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <Masonry.h>
#import <GPUImage.h>

#import "InstaFilters.h"
#import "InstagramViewController.h"

#define Filter_Count 18

@interface InstagramViewController () <UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NSArray<Class>* instagramFilters;
    GPUImagePicture *stillImageSource;

    NSArray <Class>* pureGirlInstagramFilters;
    GPUImagePicture *pureGirlStillImageSource;


}

@property (nonatomic, strong) UIImageView *pureImageView;

@property (nonatomic, strong) UIScrollView *filterScrollview;

@property (nonatomic, strong) UILabel *indexLab;

@end

@implementation InstagramViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Instagram";
    [self.view addSubview:self.pureImageView];
    [self.view addSubview:self.filterScrollview];
    [self.view addSubview:self.indexLab];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPhoto)];


    instagramFilters = [IFImageFilter allFilterClasses];
    stillImageSource = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:@"girl"]];

    pureGirlInstagramFilters = [IFImageFilter allFilterClasses];
    pureGirlStillImageSource = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:@"pure_girl"]];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *array = [self filterWithImage:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addFilterImage:array];
        });
    });

    [self changFilter:0];
}

- (void)viewWillLayoutSubviews {

    [self.filterScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view).with.offset(0);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width, 110));

    }];
    [self.pureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(174);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(0);
    }];

    [self.indexLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view).with.offset(-20);



    }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageSize = 110;
    NSInteger page = roundf(scrollView.contentOffset.x / pageSize);
    IFImageFilter *imageFilter = [[[instagramFilters objectAtIndex:page] alloc] init];
    self.title = [NSString stringWithFormat:@"%@ (%ld/%ld)", imageFilter.name, page+1, instagramFilters.count];
    [self changFilter:page];

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    CGFloat pageSize = 110;
    NSInteger page = roundf(scrollView.contentOffset.x / pageSize);
    IFImageFilter *imageFilter = [[[instagramFilters objectAtIndex:page] alloc] init];

    self.title = [NSString stringWithFormat:@"%@ (%ld/%ld)", imageFilter.name, page+1, instagramFilters.count];
    [self changFilter:page];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    pureGirlStillImageSource = [[GPUImagePicture alloc]initWithImage:image];
    CGFloat pageSize = 110;
    NSInteger page = roundf(self.filterScrollview.contentOffset.x / pageSize);
    [self changFilter:page];
    picker.delegate = self;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    picker.delegate = nil;
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Private Method 

- (void)addFilterImage:(NSMutableArray *)array; {

    for (NSInteger i = 0; i < Filter_Count; i ++) {
        UIImageView *fileterImage = [UIImageView new];
        fileterImage.image = array[i];
        fileterImage.frame = CGRectMake((i * 110), 0, 110, 110);
        [self.filterScrollview addSubview:fileterImage];
        fileterImage.userInteractionEnabled = YES;
        fileterImage.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchMovie:)];

        [fileterImage addGestureRecognizer:tap];
    }
    [self.filterScrollview setContentSize:CGSizeMake(Filter_Count * 110, 0)];

}

- (NSMutableArray *)filterWithImage:(NSInteger)index {

    NSMutableArray *array = [NSMutableArray new];
    for (NSInteger i = 0; i < Filter_Count; i ++) {
        NSInteger filterIndex = i;
        [stillImageSource removeAllTargets];
        IFImageFilter *imageFilter = [[[instagramFilters objectAtIndex:filterIndex] alloc] init];
        [stillImageSource addTarget:imageFilter];
        [imageFilter useNextFrameForImageCapture];
        [stillImageSource processImage];
        [array addObject: [imageFilter imageFromCurrentFramebuffer]];

    }

    return array;
}

- (void)changFilter:(NSInteger)index {

    NSInteger filterIndex = index;
    [pureGirlStillImageSource removeAllTargets];
    IFImageFilter *imageFilter = [[[instagramFilters objectAtIndex:filterIndex] alloc] init];
    [pureGirlStillImageSource addTarget:imageFilter];
    [imageFilter useNextFrameForImageCapture];
    [pureGirlStillImageSource processImage];

    self.pureImageView.image = [imageFilter imageFromCurrentFramebuffer];

    [self.indexLab setText:[NSString stringWithFormat:@"索引对照 %ld",filterIndex+1]];
    
}

- (void)takePicFromAlbum {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
        //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - Tap Method 

- (void)touchMovie:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    [self.filterScrollview setContentOffset:CGPointMake(imageView.tag * 110, 0) animated:YES];
}

#pragma mark - Button Event 

- (void)addPhoto {
    [self takePicFromAlbum];
}

#pragma  mark - Setter - Getter 

- (UIImageView *)pureImageView {
    if (_pureImageView == nil) {
        _pureImageView = [UIImageView new];
        _pureImageView.contentMode = UIViewContentModeScaleAspectFill;
        _pureImageView.clipsToBounds = YES;
    }
    return _pureImageView;
}

- (UIScrollView *)filterScrollview {
    if (_filterScrollview == nil) {
        _filterScrollview = [UIScrollView new];
        _filterScrollview.bounces = NO;
        _filterScrollview.delegate = self;
    }
    return _filterScrollview;
}

- (UILabel *)indexLab {
    if (_indexLab == nil) {
        _indexLab = [UILabel new];
        _indexLab.font = [UIFont systemFontOfSize:15.f];
        _indexLab.textColor = [UIColor whiteColor];
    }
    return _indexLab;
}

@end
