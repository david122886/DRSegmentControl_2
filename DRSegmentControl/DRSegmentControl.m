//
//  DRSegmentControl.m
//  DRSegmentControl
//
//  Created by xxsy-ima001 on 14-6-4.
//  Copyright (c) 2014年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "DRSegmentControl.h"
#define kFlagViewHeight 2
#define kFlagViewSpace 1
#define kControlStartIndex 4512
#define kSeparateViewHeight 20
#pragma mark - DRSegmentControlItem
@interface DRSegmentControlItem:UIView
@property (nonatomic,strong) UIButton *button;
@end

@implementation DRSegmentControlItem
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.button = [[UIButton alloc] initWithFrame:(CGRect){0,0,frame.size.width,frame.size.height-kFlagViewHeight}];
        self.button.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.button];
    }
    return self;
}
@end
#pragma mark - DRSegmentControl

@interface DRSegmentControl()
///中间底部view，高度和字体一样高
@property (nonatomic,strong) UIView *separateBackView;
///底部提示view
@property (nonatomic,strong) UIView *tipLineView;

@property (nonatomic,strong) NSArray *itemsTitleArray;
@end
@implementation DRSegmentControl

///设置分段控件每个选项的名称
-(id)initWithFrame:(CGRect)frame withItemTitles:(NSArray*)itemTitles{

    self = [super initWithFrame:frame];
    if (self) {
        self.itemsTitleArray = itemTitles;
        if (itemTitles.count > 0) {
            int separateY = frame.size.height/2 - kSeparateViewHeight/2;
            self.separateBackView = [[UIView alloc] initWithFrame:(CGRect){0,separateY,frame.size.width,kSeparateViewHeight}];
            self.separateBackView.autoresizingMask = UIViewAutoresizingNone;
            self.separateBackView.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:self.separateBackView];
            
            int itemWidth = (frame.size.width - (itemTitles.count - 1)*kFlagViewSpace)/itemTitles.count;
            for (int index = 0; index < itemTitles.count; index++) {
                DRSegmentControlItem *item = [self createItemWithIndex:index];
                if (index == itemTitles.count - 1) {
                    item.frame = (CGRect){(itemWidth+kFlagViewSpace)*index,0,itemWidth+kFlagViewSpace,frame.size.height};
                }else{
                item.frame = (CGRect){(itemWidth+kFlagViewSpace)*index,0,itemWidth,frame.size.height};
                }
                
                item.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
                [item.button setTitle:itemTitles[index] forState:UIControlStateNormal];
                [self addSubview:item];
            }
            
            self.tipLineView = [[UIView alloc] initWithFrame:(CGRect){0,frame.size.height - kFlagViewHeight,itemWidth,kFlagViewHeight}];
            self.tipLineView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            self.tipLineView.backgroundColor = [UIColor greenColor];
            [self addSubview:self.tipLineView];
        }
    }
    return self;
}

-(void)itemButtonClicked:(UIButton*)itemButton{
    int index = itemButton.superview.tag - kControlStartIndex;
    [self selectAtIndex:index];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(drSegmentControl:didSelectedAtIndex:)]) {
        [self.delegate drSegmentControl:self didSelectedAtIndex:index];
    }
}

-(DRSegmentControlItem*)createItemWithIndex:(int)index{
    DRSegmentControlItem *item = [[DRSegmentControlItem alloc] initWithFrame:(CGRect){0,0,100,100}];
    item.tag = kControlStartIndex+index;
    [item.button addTarget:self action:@selector(itemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    item.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.9];
    [item.button setBackgroundColor:[UIColor whiteColor]];
    [item.button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    return item;
}

///设置选中位置
-(void)selectAtIndex:(int)seletedIndex{
    if (seletedIndex >= self.itemsTitleArray.count) {
        return;
    }
    DRSegmentControlItem *item = (DRSegmentControlItem*)[self viewWithTag:kControlStartIndex+seletedIndex];
    if (item) {
        [self setAllItemsUserAble:YES];
        [item setUserInteractionEnabled:NO];
        [UIView animateWithDuration:0.2 animations:^{
            self.tipLineView.frame = (CGRect){(CGRectGetWidth(self.tipLineView.frame)+kFlagViewSpace)*seletedIndex,self.frame.size.height - kFlagViewHeight,CGRectGetWidth(self.tipLineView.frame),kFlagViewHeight};
        }];
    }
}

///设置所有子view touch 事件是否可用
-(void)setAllItemsUserAble:(BOOL)able{
    for (UIView *subView in self.subviews) {
        [subView setUserInteractionEnabled:able];
    }
}
@end
