//
//  CCircleSingleTopicView.m
//  CCircleFramework
//
//  Created by 李保征 on 2017/11/27.
//  Copyright © 2017年 wallstreetcn. All rights reserved.
//

#import "CCircleSingleTopicView.h"

@interface CCircleSingleTopicView ()

@property (nonatomic,strong) UIButton *iconBtn;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation CCircleSingleTopicView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        
        [self addSubview:self.iconBtn];
        [self addSubview:self.titleLabel];
    }
    return self;
}

#pragma mark - getter

- (UIButton *)iconBtn{
    if (!_iconBtn) {
        CGFloat btnX = 0;
        CGFloat btnY = 0;
        CGFloat btnW = self.bounds.size.width;
        CGFloat btnH = btnW;
        
        _iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
//        _iconBtn.titleLabel.font = [UIFont h_iconFontOfSize:56.f];
        _iconBtn.layer.cornerRadius = btnW * 0.5;
        _iconBtn.layer.masksToBounds = YES;
//        [_iconBtn setTitleColor:[UIColor h_grayColor] forState:UIControlStateNormal];
        _iconBtn.backgroundColor = [UIColor colorWithRed:77.0/255.0 green:77.0/255.0 blue:77.0/255.0 alpha:1.0];
        [_iconBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconBtn;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconBtn.frame) + 10, self.bounds.size.width, 20)];
        _titleLabel.textColor = [UIColor colorWithRed:47.0/255.0 green:47.0/255.0 blue:47.0/255.0 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark - action

- (void)iconBtnClick:(UIButton *)btn{
    if (self.block) {
        self.block();
    }
}

#pragma mark - public

- (void)setupIconTitle:(NSString *)iconTitle title:(NSString *)title{
    [self.iconBtn setImage:[UIImage imageNamed:iconTitle] forState:UIControlStateNormal];
//    [self.iconBtn setTitle:iconTitle forState:UIControlStateNormal];
    self.titleLabel.text = title;
}

@end
