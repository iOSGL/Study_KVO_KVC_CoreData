//
//  CornerRadiusTableViewCell.h
//  TestKVC_CoreData
//
//  Created by geng lei on 16/3/2.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CornerRadiusTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) UIImageView *iconImage;

@property (nonatomic, strong) UIView *cornerRadiusView;

@property (nonatomic, strong) UILabel *cornerRadiusLab;

@end
