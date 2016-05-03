//
//  GJFiltersViewController.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/5/3.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <Masonry.h>
#import <CoreImage/CoreImage.h>
#import <GPUImage/GPUImage.h>

#import "GJFiltersViewController.h"

@interface GJFiltersViewController ()

@property (nonatomic, strong) UIImageView *filterImage;

@property (nonatomic, strong) UIImageView *GPUinage;

@end

@implementation GJFiltersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Filters";

    
    [self.view addSubview:self.filterImage];
    [self.view addSubview:self.GPUinage];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       UIImage *image = [self filterFromCoreImage:[UIImage imageNamed:@"girl"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.filterImage.image = image;
        });
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [self filterFromGPUImage:[UIImage imageNamed:@"girl"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.GPUinage.image = image;
        });
    });
    
}

- (void)viewWillLayoutSubviews {
    [self.filterImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(110, 110));
    }];
    
    [self.GPUinage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).with.offset(100);
        make.size.mas_equalTo(CGSizeMake(110, 110));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method

- (UIImage *)filterFromCoreImage:(UIImage *)image {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *originImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:originImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:1] forKey:kCIInputRadiusKey];
    CIImage *outPutImage = filter.outputImage;
    CGImageRef cgImage = [context createCGImage:outPutImage fromRect:[outPutImage extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}

- (UIImage *)filterFromGPUImage:(UIImage *)image {
    UIImage *resultImage = nil;
//    GPUImageSepiaFilter *filter = [[GPUImageSepiaFilter alloc]init];
//    resultImage = [filter imageByFilteringImage:image];
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:image];
    
    GPUImageFilterGroup *groupFilter = [[GPUImageFilterGroup alloc]init];
    
    GPUImageSepiaFilter *stillImageFilter = [[GPUImageSepiaFilter alloc] init];
    GPUImageSketchFilter *SketchFilter = [[GPUImageSketchFilter alloc]init];
    GPUImageSaturationFilter *SaturationFilter = [[GPUImageSaturationFilter alloc]init];
    SaturationFilter.saturation = 2.f;
    GPUImagePixellateFilter *mosaicFilter = [[GPUImagePixellateFilter alloc]init];
    
    
    [groupFilter addTarget:stillImageFilter];
    [groupFilter addTarget:stillImageFilter];
    [groupFilter addTarget:SaturationFilter];
    [groupFilter addTarget:mosaicFilter];
    
    [stillImageFilter addTarget:SketchFilter];
    [SketchFilter addTarget:SaturationFilter];
    [SaturationFilter addTarget:mosaicFilter];
    
    [(GPUImageFilterGroup *) groupFilter setInitialFilters:[NSArray arrayWithObject:stillImageFilter]];
    [(GPUImageFilterGroup *) groupFilter setTerminalFilter:mosaicFilter];

    [stillImageSource addTarget:groupFilter];
    [stillImageSource processImage];
    [groupFilter useNextFrameForImageCapture];
    
    resultImage = [groupFilter imageFromCurrentFramebuffer];
    return resultImage;
}

#pragma mark - Setter Getter 

- (UIImageView *)filterImage {
    if (_filterImage == nil) {
        _filterImage = [UIImageView new];
    }
    return _filterImage;
}

- (UIImageView *)GPUinage {
    if (_GPUinage == nil) {
        _GPUinage = [UIImageView new];
    }
    return _GPUinage;
}

@end
