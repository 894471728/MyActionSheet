//
//  MyActionSheet.m
//  MyActionSheet
//
//  Created by ypL on 15/10/21.
//  Copyright (c) 2015年 hohistar. All rights reserved.
//

#import "MyActionSheet.h"
#import "SheetView.h"

#define kDeviceWidth ([[UIScreen mainScreen] bounds].size.width)
#define kDeviceHeight ([[UIScreen mainScreen] bounds].size.height)
#define kCellHeight 46

@interface MyActionSheet()<SheetViewDelegate>

@property (strong, nonatomic) UIView *view;
@property (strong ,nonatomic) UIControl *bgControl;

@property (strong, nonatomic) UIButton *myTitleBtn;
@property (strong, nonatomic) SheetView *sheetView;

@property (strong, nonatomic) NSIndexPath *selectIndex;
@property (strong, nonatomic) SelectIndexBlock selectBlock;

@property (strong, nonatomic) NSArray *dataSource;
@property (assign, nonatomic) CGFloat sheetHeight;
@end

@implementation MyActionSheet

- (instancetype)initWithTitle:(NSString *)title itemTitles:(NSArray *)itemTitles
{
    if (self = [super init]) {
        
        _dataSource = itemTitles;
        int cellCount = (int)itemTitles.count;  //items 大于6 可滑动
        if (cellCount > 6) {
            cellCount = 6;
        }
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        _view = [UIApplication sharedApplication].keyWindow;
        
        //半透明背景按钮
        _bgControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        [_bgControl addTarget:self action:@selector(dismissSheetView) forControlEvents:UIControlEventTouchUpInside];
        _bgControl.backgroundColor = [UIColor blackColor];
        _bgControl.alpha = 0.2;
        [_view addSubview:_bgControl];
        //标题
        if (title.length > 0) {
            _myTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _myTitleBtn.backgroundColor = [UIColor whiteColor];
            _myTitleBtn.frame = CGRectMake(0, kDeviceHeight, kDeviceWidth, kCellHeight);
            [_myTitleBtn setTitle:title forState:UIControlStateNormal];
            [_myTitleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            if (kDeviceHeight == 667) {
                _myTitleBtn.titleLabel.font = [UIFont systemFontOfSize:20];
            } else if (kDeviceHeight > 667) {
                _myTitleBtn.titleLabel.font = [UIFont systemFontOfSize:21];
            }else {
                _myTitleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
            }
            [_view addSubview:_myTitleBtn];
        }
        
        // actionsheet tableView
        _sheetView = [[NSBundle mainBundle] loadNibNamed:@"SheetView" owner:self options:nil].lastObject;
        _sheetView.delegate = self;
        _sheetView.dataSource = _dataSource;
        [_view addSubview:_sheetView];
        
        _sheetHeight = kCellHeight * (cellCount + 1) + 5;
        _sheetView.frame = CGRectMake(0, kDeviceHeight + kCellHeight, kDeviceWidth, _sheetHeight);
        [_sheetView.cancleButton addTarget:self action:@selector(dismissSheetView) forControlEvents:UIControlEventTouchUpInside];
        [self pushSheetView];
    }
    return self;
}


- (void)didFinishSelectIndex:(SelectIndexBlock)block
{
    if (block!=_selectBlock) {
        _selectBlock = block;
    }
}

//点击了哪行
- (void)sheetViewDidSelectIndex:(NSInteger)Index selectTitle:(NSString *)title
{
    if (_selectBlock) {
        _selectBlock(Index,title);
    }
    if ([self.delegate respondsToSelector:@selector(sheetViewDidSelectIndex:title:sender:)]) {
        [self.delegate sheetViewDidSelectIndex:Index title:title sender:self];
    }
    [self dismissSheetView];
}

//出现
- (void)pushSheetView {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.myTitleBtn.frame = CGRectMake(0, kDeviceHeight - weakSelf.sheetHeight - kCellHeight, kDeviceWidth, kCellHeight);
        weakSelf.sheetView.frame = CGRectMake(0, kDeviceHeight - weakSelf.sheetHeight, kDeviceWidth, weakSelf.sheetHeight);
        weakSelf.bgControl.alpha = 0.2;
    }];
}

//消失
- (void)dismissSheetView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.myTitleBtn.frame = CGRectMake(0, kDeviceHeight, kDeviceWidth, kCellHeight);
        weakSelf.sheetView.frame = CGRectMake(0, kDeviceHeight + kCellHeight, kDeviceWidth, weakSelf.sheetHeight);
        weakSelf.bgControl.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakSelf.sheetView removeFromSuperview];
        [weakSelf.bgControl removeFromSuperview];
        [weakSelf.myTitleBtn removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}

@end
