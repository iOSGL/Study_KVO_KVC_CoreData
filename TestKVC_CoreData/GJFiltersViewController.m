//
//  GJFiltersViewController.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/5/3.
//  Copyright © 2016年 genglei. All rights reserved.
// 发动机号 153540363 车架号 LSGGA53E7GH079392

#import <Masonry.h>
#import <CoreImage/CoreImage.h>
#import <GPUImage/GPUImage.h>

#import "IFImageFilter.h"
#import "GJFiltersViewController.h"

@interface GJFiltersViewController () {
    NSArray<Class>* instagramFilters;
    NSInteger _filterIndex;
    GPUImagePicture *stillImageSource;
}

@property (nonatomic, strong) UIImageView *filterImage;

@property (nonatomic, strong) UIImageView *GPUinage;

@property (nonatomic, strong) UIImageView *shaderImage;

@property (nonatomic, strong) UILabel *effectLab;

@end

@implementation GJFiltersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Filters";

    _filterIndex = 0;
    instagramFilters = [IFImageFilter allFilterClasses];
    stillImageSource = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:@"girl"]];


    
    [self.view addSubview:self.filterImage];
    [self.view addSubview:self.GPUinage];
    [self.view addSubview:self.shaderImage];
    [self.view addSubview:self.effectLab];

//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        UIImage *image = [self filterFromGPUImage:[UIImage imageNamed:@"girl"]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.GPUinage.image = image;
//        });
//    });

    [self touchChange];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [self filterFromGPUImageShader:[UIImage imageNamed:@"girl"]];
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
    
    [self.shaderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view).with.offset(-100);
        make.size.mas_equalTo(CGSizeMake(110, 110));
    }];

    [self.effectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view).with.offset(-50);
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
    GPUImagePicture *stillImageSource1 = [[GPUImagePicture alloc]initWithImage:image];
    GPUImageFilterGroup *groupFilter = [[GPUImageFilterGroup alloc]init];
    GPUImageBrightnessFilter *brightnessFilter = [[GPUImageBrightnessFilter alloc]init];
    GPUImageHighlightShadowFilter *overlayBlendFilter = [[GPUImageHighlightShadowFilter alloc]init];
    overlayBlendFilter.shadows = 0.5;
    overlayBlendFilter.highlights = 0.5;
    GPUImageContrastFilter *contrastFilter = [[GPUImageContrastFilter alloc]init];
    GPUImageSaturationFilter *saturationFilter = [[GPUImageSaturationFilter alloc]init];
    saturationFilter.saturation =  - 0.04f;
    GPUImageHueFilter *hueFilter = [[GPUImageHueFilter alloc]init];
    hueFilter.hue = 1.0f;
    GPUImageFilter *filter = [[GPUImageFilter alloc]initWithFragmentShaderFromFile:@"Shader1"];
    
    [groupFilter addTarget:brightnessFilter];
    [groupFilter addTarget:overlayBlendFilter];
    [groupFilter addTarget:contrastFilter];
    [groupFilter addTarget:saturationFilter];
    [groupFilter addTarget:hueFilter];
    [groupFilter addTarget:filter];
    
    [brightnessFilter addTarget:overlayBlendFilter];
    [overlayBlendFilter addTarget:contrastFilter];
    [contrastFilter addTarget:saturationFilter];
    [saturationFilter addTarget:hueFilter];
    [hueFilter addTarget:filter];

    
    [(GPUImageFilterGroup *) groupFilter setInitialFilters:[NSArray arrayWithObject:brightnessFilter]];
    [(GPUImageFilterGroup *) groupFilter setTerminalFilter:filter];

    [stillImageSource1 addTarget:groupFilter];
    [stillImageSource1 processImage];
    [groupFilter useNextFrameForImageCapture];
    
    resultImage = [groupFilter imageFromCurrentFramebuffer];
    return resultImage;
}

- (UIImage *)filterFromGPUImageShader:(UIImage *)image {
    
    NSString *vertexStringPath = [[NSBundle mainBundle]pathForResource:@"shader" ofType:@"vsh"];
    NSString *vertexShaderString = [NSString stringWithContentsOfFile:vertexStringPath encoding:NSUTF8StringEncoding error:nil];

    NSString *fragmentStringPath = [[NSBundle mainBundle]pathForResource:@"shader" ofType:@"fsh"];
    NSString *fragmentShaderString = [NSString stringWithContentsOfFile:fragmentStringPath encoding:NSUTF8StringEncoding error:nil];
    
    UIImage *reslutImage = nil;
    GPUImagePicture *imageSource = [[GPUImagePicture alloc]initWithImage:image];

//    GPUImageFilter *filter = [[GPUImageFilter alloc]initWithFragmentShaderFromString:fragmentShaderString];




//    GPUImageFilter *filter = [[GPUImageTwoInputFilter alloc]initWithVertexShaderFromString:vertexShaderString fragmentShaderFromString:fragmentShaderString];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc]init];

     GPUImageFilter *filter = [[GPUImageFourInputFilter alloc]initWithFragmentShaderFromString:fragmentShaderString];



    [group setInitialFilters:@[filter]];
    [group setTerminalFilter:filter];

     GPUImagePicture *source = [self filterImageNamed:@"sierraVignette"];
     GPUImagePicture *source1 = [self filterImageNamed:@"softLight"];
    GPUImagePicture *source2 = [self filterImageNamed:@"valenciaGradientMap"];

    [source addTarget:filter atTextureLocation:1];
    [source processImage];

    [source1 addTarget:filter atTextureLocation:2];
    [source1 processImage];

    [source2 addTarget:filter atTextureLocation:3];
    [source2 processImage];

    [imageSource addTarget:group];
    [imageSource processImage];
    [group useNextFrameForImageCapture];
    reslutImage = [group imageFromCurrentFramebuffer];
    return reslutImage;;
}

- (GPUImagePicture*)filterImageNamed:(NSString*)name {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"GPUImage.InstagramFilter" ofType:@"bundle"];
    NSBundle* filterImageBundle = [NSBundle bundleWithPath:bundlePath];

    UIImage* image = [UIImage imageWithContentsOfFile:[filterImageBundle pathForResource:name ofType:@"png"]];

    return [[GPUImagePicture alloc] initWithImage:image];
}


#pragma  mark - Tap Method

- (void)touchChange {

    NSInteger filterIndex = (_filterIndex++ % instagramFilters.count);
    NSLog(@"索引  %zi", filterIndex);
    [stillImageSource removeAllTargets];
    IFImageFilter *imageFilter = [[[instagramFilters objectAtIndex:filterIndex] alloc] init];
    [stillImageSource addTarget:imageFilter];
    [imageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];

    self.shaderImage.image = [imageFilter imageFromCurrentFramebuffer];
    [self.effectLab setText:[NSString stringWithFormat:@"%@ (%ld/%ld)", imageFilter.name, filterIndex+1, instagramFilters.count]];
    self.effectLab.textColor = [UIColor colorWithPatternImage:self.shaderImage.image];


}

#pragma mark - Setter Getter 

- (UIImageView *)filterImage {
    if (_filterImage == nil) {
        _filterImage = [UIImageView new];
        _filterImage.image = [UIImage imageNamed:@"girl"];
    }
    return _filterImage;
}

- (UIImageView *)GPUinage {
    if (_GPUinage == nil) {
        _GPUinage = [UIImageView new];
    }
    return _GPUinage;
}

- (UIImageView *)shaderImage {
    if (_shaderImage == nil) {
        _shaderImage = [UIImageView new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchChange)];
        _shaderImage.userInteractionEnabled = YES;
        [_shaderImage addGestureRecognizer:tap];
    }
    return _shaderImage;
}

- (UILabel *)effectLab {
    if (_effectLab == nil) {
        _effectLab = [UILabel new];
        _effectLab.font = [UIFont boldSystemFontOfSize:15.f];
    }
    return _effectLab;
}

@end
