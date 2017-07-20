//  HLShareBoard.h
//  HLUmengShareDemo
//
//  Created by lizhaojie on 2017/7/20.
//  Copyright © 2017年 lizhaojie. All rights reserved.
//

#import "VerButton.h"
#import "HLShareButton.h"
#import <UIKit/UIKit.h>

typedef enum {
    defaultBoardStyleType = 0,  //九宫格布局风格
    actionSheetBoardStyleType,  //actionsheet布局风格
} BoardStyleType;

@interface HLShareBoard : UIView

//点击按钮block回调
@property (nonatomic,copy) void(^btnClick)(NSString *platform);

//头部提示文字的字体大小
@property (nonatomic,assign) NSInteger titleFont;

//取消按钮的颜色
@property (nonatomic,strong) UIColor *cancelBtnColor;

//取消按钮的字体大小
@property (nonatomic,assign) NSInteger cancelBtnFont;

//设置弹窗背景蒙板灰度(0~1)
@property (nonatomic,assign) CGFloat duration;
//风格样式
@property (nonatomic,assign) BoardStyleType boardStyle;


/**
 *  初始化actionView
 *
 *  @param titleArray 标题数组
 *  @param imageArray   图片数组(如果不需要的话传空数组(@[])进来)
 *  @param title        最顶部的标题  不需要的话传@""
 *
 *  @return wu
 */

- (instancetype)initWithTitle:(NSString *)title subTitles:(NSArray *)titleArray images:(NSArray *)imageArray;

@end








