//
//  CCirclePublishTopicView.m
//  Circle
//
//  Created by 李保征 on 2017/11/27.
//

#import "CCirclePublishTopicView.h"
#import "CCircleSingleTopicView.h"


#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define VIEWSAFEAREAINSETS(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})

#define KNavHeight          (kDevice_Is_iPhoneX ? 88.0 : 64.0)
#define KtabBarHeight       (kDevice_Is_iPhoneX ? 83.0 : 49.0)
#define KStatusBarHeight    (kDevice_Is_iPhoneX ? 44.0 : 20.0)
#define KBottomMargin    (kDevice_Is_iPhoneX ? 34.0 : 0)

//列数
#define ColCount 3

@interface CCirclePublishTopicView ()
@property(nonatomic,strong) UIVisualEffectView *effectView;
@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,retain) NSMutableArray *topicViews;
@property (nonatomic,retain) NSMutableArray *topicIcons;
@property (nonatomic,retain) NSMutableArray *topicTitles;
@property (nonatomic,retain) NSMutableArray *topicClickBlocks;
@end

@implementation CCirclePublishTopicView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.effectView];
        [self addSubview:self.closeBtn];
        
        [self.topicViews removeAllObjects];
        NSUInteger totalCount = self.topicTitles.count;
        NSUInteger rowCount = (totalCount + ColCount - 1) / ColCount;
        CGFloat itemHeight = (55 + 10 + 20);
        CGFloat itemWidth = 55;
        CGFloat marginLevel = (frame.size.width - itemWidth * ColCount) / (ColCount + 1);
        CGFloat marginVertical = 25;
        CGFloat targetHeight = itemHeight * rowCount + marginVertical * (rowCount - 1);
        CGFloat startY = self.closeBtn.frame.origin.y - 45 - targetHeight;
        
        for (NSInteger i = 0; i < totalCount; i++) {
            CCircleSingleTopicView *singleView = [self creatSingleTopicView:i itemSize:CGSizeMake(itemWidth, itemHeight) marginLevel:marginLevel marginVertical:marginVertical startY:startY iconTitle:self.topicIcons[i] title:self.topicTitles[i] block:self.topicClickBlocks[i]];
            [self.topicViews addObject:singleView];
            [self addSubview:singleView];
        }
    }
    return self;
}

- (CCircleSingleTopicView *)creatSingleTopicView:(NSInteger)idx
                                        itemSize:(CGSize)itemSize
                                     marginLevel:(CGFloat)marginLevel
                                  marginVertical:(CGFloat)marginVertical
                                          startY:(CGFloat)startY
                                       iconTitle:(NSString *)iconTitle
                                           title:(NSString *)title
                                           block:(void (^)())block{
    NSInteger row = idx / ColCount + 1; // 1 2
    NSInteger col = idx % ColCount + 1; // 1 2
    
    CGFloat singleViewW = itemSize.width;
    CGFloat singleViewH = itemSize.height;
    CGFloat singleViewX = marginLevel * col + singleViewW * (col - 1);
    CGFloat singleViewY = (singleViewH + marginVertical) * (row - 1) + startY;
    CCircleSingleTopicView *singleView = [[CCircleSingleTopicView alloc] initWithFrame:CGRectMake(singleViewX, singleViewY, singleViewW, singleViewH)];
    [singleView setupIconTitle:iconTitle title:title];
    singleView.block = block;
    return singleView;
}

#pragma mark - getter

- (NSMutableArray *)topicClickBlocks{
    if (!_topicClickBlocks) {
        __weak __typeof__(self) weakSelf = self;
        void (^textTopicBlock)() = ^(){
            [weakSelf closeBtnClick:nil];
        };
        void (^imageTopicBlock)() = ^(){
            [weakSelf closeBtnClick:nil];
        };
        void (^audioTopicBlock)() = ^(){
            [weakSelf closeBtnClick:nil];
        };
        void (^askTopicBlock)() = ^(){
            [weakSelf closeBtnClick:nil];
        };
        void (^fileTopicBlock)() = ^(){
            [weakSelf closeBtnClick:nil];
        };
        void (^articleTopicBlock)() = ^(){
        };
        _topicClickBlocks = [NSMutableArray arrayWithArray:@[imageTopicBlock,textTopicBlock,audioTopicBlock,askTopicBlock,fileTopicBlock,articleTopicBlock]];
    }
    return _topicClickBlocks;
}

- (NSMutableArray *)topicIcons{
    if (!_topicIcons) {
        _topicIcons = [NSMutableArray arrayWithArray:@[@"publish_image",@"publish_text",@"publish_audio",@"publish_ask",@"publish_file",@"publish_article"]];
    }
    return _topicIcons;
}

- (NSMutableArray *)topicTitles{
    if (!_topicTitles) {
        _topicTitles = [NSMutableArray arrayWithArray:@[@"图片",@"文字",@"语音",@"提问",@"文件",@"长文章"]];
    }
    return _topicTitles;
}

- (NSMutableArray *)topicViews{
    if (!_topicViews) {
        _topicViews = [NSMutableArray array];
    }
    return _topicViews;
}

- (UIVisualEffectView *)effectView{
    if (!_effectView) {
        UIBlurEffect * effrct = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effrct];
        _effectView.frame = self.bounds;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClick:)];
        [_effectView addGestureRecognizer:tapGesture];
    }
    return _effectView;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        CGFloat btnW = 50;
        CGFloat btnH = btnW;
        CGFloat btnX = (self.bounds.size.width - btnW) * 0.5;
        CGFloat btnY = self.bounds.size.height - btnH - 5 - KBottomMargin;
        
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        _closeBtn.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:223.0/255.0 blue:226.0/255.0 alpha:1.0];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _closeBtn.layer.masksToBounds = YES;
        _closeBtn.layer.cornerRadius = btnW * 0.5;
        
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:[UIColor colorWithRed:77.0/255.0 green:77.0/255.0 blue:77.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [_closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

#pragma mark - action
- (void)tapGestureClick:(UITapGestureRecognizer *)tapGesture{
    [self closeBtnClick:nil];
}

- (void)closeBtnClick:(UIButton *)btn{
    

    for (NSInteger index = 0; index < self.topicViews.count; index ++) {
        CCircleSingleTopicView *singleView = self.topicViews[(self.topicViews.count - 1) -index];
        CGRect rect = singleView.frame;
        rect.origin.y = [UIScreen mainScreen].bounds.size.height + 10;
        [UIView animateWithDuration:0.3
                              delay:0.05 * index
             usingSpringWithDamping:0.7
              initialSpringVelocity:12
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             singleView.frame = rect;
                             singleView.alpha = 0.3;
                         } completion:^(BOOL finished) {
                         }];
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - layout

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        //被添加到父视图
        for (NSUInteger index = 0; index < self.topicViews.count; index++) {
            CCircleSingleTopicView *singleView = self.topicViews[index];
            CGAffineTransform topTransform = CGAffineTransformMakeTranslation(0, self.frame.size.height - singleView.frame.origin.y);
            CGAffineTransform reset = CGAffineTransformIdentity;
            singleView.transform = topTransform;
            singleView.alpha = 0.3;
            [UIView animateWithDuration:0.5
                                  delay:index * 0.05
                 usingSpringWithDamping:0.9
                  initialSpringVelocity:19
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 singleView.transform = reset;
                                 singleView.alpha = 1;
                             } completion:NULL];
            
        }
    }else{
        //从父视图移除
    }
}


@end
