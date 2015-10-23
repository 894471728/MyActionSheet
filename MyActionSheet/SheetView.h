//
//  SheetView.h
//  MyActionSheet
//
//  Created by ypL on 15/10/21.
//  Copyright (c) 2015年 hohistar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SheetViewDelegate <NSObject>

- (void)sheetViewDidSelectIndex:(NSInteger)index selectTitle:(NSString *)title;

@end

@interface SheetView : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <SheetViewDelegate> delegate;
@property (assign, nonatomic) CGFloat cellHeight;
@property (strong, nonatomic) NSArray *dataSource;

@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (nonatomic, weak) IBOutlet UIView *sheetView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *divLineHeight;

@end
