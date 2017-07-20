//  HLShareBoard.m
//  HLUmengShareDemo
//
//  Created by lizhaojie on 2017/7/20.
//  Copyright © 2017年 lizhaojie. All rights reserved.
//

#import "HLShareBoard.h"

#define ACTIONSHEET_BACKGROUNDCOLOR             [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1]
#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define ANIMATE_DURATION                        0.25f

#define ActionSheetW [[UIScreen mainScreen] bounds].size.width
#define ActionSheetH [[UIScreen mainScreen] bounds].size.height
static CGFloat topSpace = 30;//内上，下边距
static CGFloat btnWidth = 50;//分享平台按钮宽
static CGFloat cancelBtnHeight = 50;//取消按钮宽
static CGFloat btnHeight = 70;//分享平台按钮高
static CGFloat boardMargin = 15;//分享面板距离父试图的边距上下左右一样
static CGFloat columnSpace = 10;//
static CGFloat titleLabelHeight = 45;//

static float sheetCornerReduce = 10;
@interface HLShareBoard ()
@property (nonatomic,strong) NSArray *shareBtnTitleArray;
@property (nonatomic,strong) NSArray *shareBtnImgArray;

@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) UIView *topsheetView;
@property (nonatomic,strong) UIButton *cancelBtn;

//头部提示文字Label
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,copy) NSString *titleText;

@end

@implementation HLShareBoard

- (instancetype)initWithTitle:(NSString *)title subTitles:(NSArray *)titleArray images:(NSArray *)imageArray
{
    self = [super init];
    if (self) {
        self.shareBtnImgArray = imageArray;
        self.shareBtnTitleArray = titleArray;
        _titleText = title;

        self.frame = CGRectMake(0, 0, ActionSheetW, ActionSheetH);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelShare)];
        [self addGestureRecognizer:tapGesture];

        
    }
    return self;
}
#pragma - mark setter
- (void)setBoardStyle:(BoardStyleType)boardStyle{
    _boardStyle = boardStyle;
    [self loadDefaultBoard];
}
- (void)setCancelBtnColor:(UIColor *)cancelBtnColor
{
    [_cancelBtn setTitleColor:cancelBtnColor forState:UIControlStateNormal];
}

-(void)setProFont:(NSInteger)proFont
{
    _titleLabel.font = [UIFont systemFontOfSize:proFont];
}

- (void)setCancelBtnFont:(NSInteger)cancelBtnFont
{
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:cancelBtnFont];
}

- (void)setDuration:(CGFloat)duration
{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:duration];
}
#pragma - mark getter
- (UIView *)backGroundView
{
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] init];
        
        NSInteger count = _shareBtnImgArray.count;
        NSInteger row = count/3+1;//行
        _backGroundView.frame = CGRectMake(boardMargin, ActionSheetH, ActionSheetW-boardMargin*2, topSpace*2+btnHeight*row+btnHeight+boardMargin+columnSpace+(_titleText.length==0?0:titleLabelHeight));
    }
    return _backGroundView;
}

- (UIView *)topsheetView
{
    if (_topsheetView == nil) {
        _topsheetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_backGroundView.frame), CGRectGetHeight(_backGroundView.frame)-columnSpace-boardMargin-cancelBtnHeight)];
        _topsheetView.backgroundColor = [UIColor whiteColor];
        _topsheetView.layer.cornerRadius = sheetCornerReduce;
        _topsheetView.clipsToBounds = YES;
        if (_titleText.length) {
            [_topsheetView addSubview:self.titleLabel];
        }
    }
    return _topsheetView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_backGroundView.frame), titleLabelHeight)];
        _titleLabel.text = _titleText;
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (_boardStyle == defaultBoardStyleType) {
            _cancelBtn.frame = CGRectMake(0, CGRectGetHeight(_backGroundView.frame)-btnWidth-boardMargin, CGRectGetWidth(_backGroundView.frame), btnWidth);
            _cancelBtn.layer.cornerRadius = sheetCornerReduce;
            _cancelBtn.clipsToBounds = YES;
        }
        else
        {
            _cancelBtn.frame = CGRectMake(0, CGRectGetHeight(_backGroundView.frame)-btnWidth, CGRectGetWidth(_backGroundView.frame), btnWidth);
        }
        
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelShare) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}


- (void)loadDefaultBoard
{
    [self addSubview:self.backGroundView];
    [_backGroundView addSubview:self.topsheetView];
    [_backGroundView addSubview:self.cancelBtn];
    
    for (NSInteger i = 0; i<_shareBtnImgArray.count; i++)
    {
        HLShareButton *button = [HLShareButton buttonWithType:UIButtonTypeCustom];
        NSInteger row = i/3;//行
        NSInteger column = i%3;//列
        CGFloat width = ActionSheetW-2*boardMargin;
        CGFloat colMargin = (width-btnWidth*3-topSpace*2)/2;
        button.frame = CGRectMake(topSpace+column*(colMargin+btnWidth), topSpace+_titleText.length==0?0:titleLabelHeight+row*(topSpace+btnHeight), btnWidth, btnHeight);
        
        [button setTitle:_shareBtnTitleArray[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:_shareBtnImgArray[i]] forState:UIControlStateNormal];
        button.tag = 200+i;
        [button addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.topsheetView addSubview:button];
    }
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        _backGroundView.frame = CGRectMake(boardMargin, ActionSheetH-CGRectGetHeight(_backGroundView.frame), ActionSheetW-boardMargin*2, CGRectGetHeight(_backGroundView.frame)+boardMargin);
    }];
    
}

#pragma - mark event
- (void)clicked:(UIButton *)btn
{
    [self cancelShare];
    NSString *title = _shareBtnTitleArray[btn.tag-200];
    _btnClick(title);
    
}

- (void)cancelShare
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, ActionSheetH, ActionSheetW, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}


@end













