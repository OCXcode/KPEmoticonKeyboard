//
//  FacialView.h
//  KPEmoticonKeyboard
//
//  Created by lkp on 2017/8/16.
//  Copyright © 2017年 leba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPEmotionManager.h"
#import "FaceManager.h"

//表情其中一个collent面板
@protocol FacialViewDelegate

@optional

/**
 * 选择了一个面板上的小表情， :
 * indexInManager: 这个表情在KPEmotionManager的位置
 * managerIndex: 这个表情所属的KPEmotionManager 在整个表情managers array的位置
 */
-(void)selectedEmotionAtIndex:(int)indexInManager inManagerSection:(int)managerIndex;

//选择了一个面板上的删除
-(void)selectedDelete;

@end


@interface FacialView : UIView
{
}

@property(nonatomic,weak) id<FacialViewDelegate> delegate;

//加载一页表情
-(void)loadEmotionBoard:(KPEmotionManager *)emotionManager inPage:(int)page;

@end


