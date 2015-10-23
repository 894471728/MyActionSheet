//
//  ViewController.m
//  MyActionSheet
//
//  Created by ypL on 15/10/21.
//  Copyright (c) 2015年 hohistar. All rights reserved.
//

#import "ViewController.h"
#import "MyActionSheet.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)selectActionSheet:(UIButton *)sender {
    
    NSArray *actionArys = @[@"小视频",@"拍照",@"从手机相册选择"];
    MyActionSheet *actionSheet = [[MyActionSheet alloc] initWithTitle:nil itemTitles:actionArys];
    actionSheet.delegate = self;
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSLog(@"index:%ld,title:%@",index,title);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
