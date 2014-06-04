//
//  ViewController.m
//  DRSegmentControl
//
//  Created by xxsy-ima001 on 14-6-4.
//  Copyright (c) 2014年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DRSegmentControl *control = [[DRSegmentControl alloc] initWithFrame:(CGRect){10,50,300,44} withItemTitles:@[@"你好",@"不好",@"好的"]];
    control.delegate = self;
    [self.view addSubview:control];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark DRSegmentControlDelegate
-(void)drSegmentControl:(DRSegmentControl *)control didSelectedAtIndex:(int)index{
    NSLog(@"drSegmentControl:%d",index);
}

@end
