//
//  MyActionSheet.h
//  MyActionSheet
//
//  Created by ypL on 15/10/21.
//  Copyright (c) 2015年 hohistar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectIndexBlock)(NSInteger index, NSString *title);

@protocol ActionSheetDelegate <NSObject>
- (void)sheetViewDidSelectIndex:(NSInteger)index title:(NSString *)title sender:(id)sender;
@end

@interface MyActionSheet : UIView

@property (weak, nonatomic) id delegate;

//itemsTitles 大于6 可以滑动
- (id)initWithTitle:(NSString *)title itemTitles:(NSArray *)itemTitles;

- (void)didFinishSelectIndex:(SelectIndexBlock)block;

@end
