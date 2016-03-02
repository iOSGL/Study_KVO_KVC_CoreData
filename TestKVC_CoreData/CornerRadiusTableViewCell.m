//
//  CornerRadiusTableViewCell.m
//  TestKVC_CoreData
//
//  Created by geng lei on 16/3/2.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "CornerRadiusTableViewCell.h"

@implementation CornerRadiusTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"Cell";
    CornerRadiusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CornerRadiusTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell
    ;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadUI];
    }
    return  self;
}

- (void)loadUI {
    [self.contentView addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.contentView addSubview:self.cornerRadiusView];
    [self.cornerRadiusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));

    }];
    
    [self.contentView addSubview:self.cornerRadiusLab];
    [self.cornerRadiusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
}

#pragma mark - Setter Getter 

- (UIImageView *)iconImage {
    if (_iconImage == nil) {
        _iconImage = [UIImageView new];
        _iconImage.image = [UIImage imageNamed:@"Icon-60"];
        _iconImage.layer.cornerRadius = 5.f;
        _iconImage.layer.masksToBounds = YES;

    }
    return _iconImage;
}

- (UIView *)cornerRadiusView {
    if (_cornerRadiusView == nil) {
        _cornerRadiusView = [UIView new];
        _cornerRadiusView.backgroundColor = [UIColor orangeColor];
//        _cornerRadiusView.layer.cornerRadius = 5.f;
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(30, 30), NO, [UIScreen mainScreen].scale);
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(currentContext, 15, 15);
        CGContextAddArcToPoint(currentContext, 0, 0, -15, 15, 15.f);
        CGContextAddArcToPoint(currentContext, -15, 15, 30, 0, 15.f);
        CGContextAddArcToPoint(currentContext, 0, 0, 30, 30, 15.f);
        CGContextAddArcToPoint(currentContext, 0, 0, 30, 30, 15.f);
        UIImage * image =  UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = image;
        [_cornerRadiusView insertSubview:imageView atIndex:0];
        
    }
    return _cornerRadiusView;
}

- (UILabel *)cornerRadiusLab {
    if (_cornerRadiusLab == nil) {
        _cornerRadiusLab = [UILabel new];
        _cornerRadiusLab.text = @"耿磊";
        _cornerRadiusLab.backgroundColor = [UIColor orangeColor];
        _cornerRadiusLab.layer.cornerRadius = 5.f;
        _cornerRadiusLab.layer.masksToBounds = YES;
        
    }
    return _cornerRadiusLab;
}

@end
