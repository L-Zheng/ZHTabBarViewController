//
//  CCircleSingleTopicView.h
//  CCircleFramework
//
//  Created by 李保征 on 2017/11/27.
//  Copyright © 2017年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCircleSingleTopicView : UIView

@property (nonatomic,copy) void (^block) ();

- (void)setupIconTitle:(NSString *)iconTitle title:(NSString *)title;

@end
