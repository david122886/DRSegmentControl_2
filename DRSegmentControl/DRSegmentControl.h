//
//  DRSegmentControl.h
//  DRSegmentControl
//
//  Created by xxsy-ima001 on 14-6-4.
//  Copyright (c) 2014年 ___xiaoxiangwenxue___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DRSegmentControl;
@protocol DRSegmentControlDelegate<NSObject>
-(void)drSegmentControl:(DRSegmentControl*)control didSelectedAtIndex:(int)index;
@end
@interface DRSegmentControl : UIView
@property (weak,nonatomic) id<DRSegmentControlDelegate> delegate;
///设置分段控件每个选项的名称
-(id)initWithFrame:(CGRect)frame withItemTitles:(NSArray*)itemTitles;

///设置选中位置
-(void)selectAtIndex:(int)seletedIndex;
@end
