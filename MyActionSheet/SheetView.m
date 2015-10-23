//
//  SheetView.m
//  MyActionSheet
//
//  Created by ypL on 15/10/21.
//  Copyright (c) 2015年 hohistar. All rights reserved.
//

#import "SheetView.h"
#import "SheetCell.h"

#define kDeviceWidth ([[UIScreen mainScreen]bounds].size.width)
#define kDeviceHeight ([[UIScreen mainScreen]bounds].size.height)

@implementation SheetView

- (id) initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupSheet];
    }
    return self;
}

- (void) setupSheet {
    self.sheetView = [[NSBundle mainBundle]loadNibNamed:@"SheetView" owner:self options:nil].lastObject;
    [self addSubview:self.sheetView];
}


- (void)awakeFromNib {
    
    if (kDeviceHeight == 667) {
        _cancleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    } else if (kDeviceHeight > 667) {
        _cancleButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    }else {
        _cancleButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    _divLineHeight.constant = 0.5;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
}


- (void)didMoveToSuperview
{
    if (_dataSource.count > 6) {
        _tableView.scrollEnabled = YES;
    }
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SheetCell *cell = (SheetCell *)[[NSBundle mainBundle]loadNibNamed:@"SheetCell" owner:self options:nil].lastObject;
    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SheetCell";
    SheetCell *cell= [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = (SheetCell *)[[NSBundle mainBundle] loadNibNamed:@"SheetCell" owner:self options:nil].lastObject;
    }
    cell.myLabel.text = _dataSource[indexPath.row];
    if (kDeviceHeight == 667) {
        cell.myLabel.font = [UIFont systemFontOfSize:17];
    } else if (kDeviceHeight > 667) {
        cell.myLabel.font = [UIFont systemFontOfSize:18];
    }else {
        cell.myLabel.font = [UIFont systemFontOfSize:15];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger index = indexPath.row;
    SheetCell *cell = (SheetCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSString *cellTitle = cell.myLabel.text;
    if ([self.delegate respondsToSelector:@selector(sheetViewDidSelectIndex:selectTitle:)]) {
        [self.delegate sheetViewDidSelectIndex:index selectTitle:cellTitle];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
