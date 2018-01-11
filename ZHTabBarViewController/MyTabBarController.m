//
//  CustomTabBarController.m
//  QQ平滑缩放效果 我写
//
//  Created by 李保征 on 16/3/23.
//  Copyright © 2016年 李保征. All rights reserved.
//

#import "MyTabBarController.h"
#import "BZHomeViewController.h"
#import "BZMessageViewController.h"
#import "MyNavigationController.h"
#import "UIBarButtonItem+Extension.h"
#import "MyMiddleViewController.h"

@interface MyTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, weak) BZHomeViewController *home;
@property (nonatomic, weak) BZMessageViewController *message;
@property (nonatomic, weak) MyMiddleViewController *middleVC;

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.delegate = self;
    
    // 添加所有的子控制器
    [self addAllChildVcs];
}


/**
 *  添加所有的子控制器
 */
- (void)addAllChildVcs{
    // 添加子控制器
    BZHomeViewController *home = [[BZHomeViewController alloc] init];
    [self addOneChlildVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    
    MyMiddleViewController *middleVC = [[MyMiddleViewController alloc] init];
    [self addOneChlildVc:middleVC title:nil imageName:@"tab_publish" selectedImageName:@"tab_publish"];
    middleVC.tabBarItem.image = [[UIImage imageNamed:@"tab_publish"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    middleVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_publish"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.middleVC = middleVC;
    
    BZMessageViewController *message = [[BZMessageViewController alloc] init];
    [self addOneChlildVc:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.message = message;
}

- (UIView *)publishTopicView{
    return [[NSClassFromString(@"CCirclePublishTopicView") alloc] initWithFrame:self.view.bounds];
}

- (void)setSelectedViewController:(__kindof UIViewController *)selectedViewController{
    UIViewController *naviRootVC = ((UINavigationController *)selectedViewController).viewControllers.firstObject;
    if (naviRootVC.class == NSClassFromString(@"MyMiddleViewController")) {
        [self.view addSubview:self.publishTopicView];
    }else {
        [super setSelectedViewController:selectedViewController];
    }
}

#pragma mark - 添加一个子控制器
/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    //拿到控制器之后不要访问view 否则会调用viewdidload方法
    //    childVc.view.backgroundColor = BZRandomColor;
    // 设置标题
    // 相当于同时设置了tabBarItem.title和navigationItem.title
    childVc.title = title;
    //    childVc.tabBarItem.title = title; // tabbar标签上
    //    childVc.navigationItem.title  = title; // 导航栏
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    
    // 3.设置左右按钮
    childVc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"top_navigation_menuicon" target:self action:@selector(leftMenuClick)];
    childVc.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"top_navigation_infoicon" target:self action:@selector(rightMenuClick)];
    
    // 添加为tabbar控制器的子控制器
    MyNavigationController *nav = [[MyNavigationController alloc] initWithRootViewController:childVc];
    // 添加为tabbar控制器的子控制器
    [self addChildViewController:nav];
}

#pragma mark - 监听导航栏按钮点击
- (void)leftMenuClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"leftMenuClickNotification" object:nil];
}


- (void)rightMenuClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"rightMenuClickNotification" object:nil];
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

@end
