//
//  KPEmotionSectionBar.h
//  KPEmoticonKeyboard
//
//  Created by lkp on 2017/8/16.
//  Copyright © 2017年 leba. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import "KPEmotionManager.h"

@protocol KPEmotionSectionBarDelegate <NSObject>

/**
 *  点击某一类gif表情的回调方法
 *
 *  @param emotionManager 被点击的管理表情Model对象
 *  @param section        被点击的位置
 */
- (void)didSelectedEmotionManager:(KPEmotionManager *)emotionManager atSection:(NSInteger)section;

/**
 * 点击发送按钮
 */
- (void)didSelectedSend;

@end

@interface KPEmotionSectionBar : UIView

@property (nonatomic, weak) id <KPEmotionSectionBarDelegate> delegate;

/**
 *  数据源
 */
@property (nonatomic, weak) NSArray *emotionManagers;

/**
 * 当前选中的表情栏目index
 */
@property (nonatomic, assign) int currentIndex;


/**
 *  是否显示发送的按钮
 */
@property (nonatomic, assign) BOOL hideSendButton; // default is NO


- (instancetype)initWithFrame:(CGRect)frame hideSendButton:(BOOL)hideSendButton;


/**
 *  根据数据源刷新UI布局和数据
 */
- (void)reloadData;

@end

