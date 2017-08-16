//
//  KPEmotionManagerView.h
//  KPEmoticonKeyboard
//
//  Created by lkp on 2017/8/16.
//  Copyright © 2017年 leba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPEmotionManager.h"

#define kKPEmotionPerRowItemCount  4

#define kKPEmotionSrollViewMarginTop 6
#define kKPEmotionPageControlHeight 22
#define kKPEmotionSectionBarHeight 40

@protocol KPEmotionManagerViewDelegate <NSObject>

@optional
/**
 *  表情被点击的回调事件
 *
 *  @param keyString 根据选择的表情，匹配出的显示的 [微笑]
 *  @param imageName 表情图片id ，Expression_1
 *  @param isGifEmotion 是不是gif大表情
 */
- (void)didSelectedEmotionKey:(NSString *)keyString emotionImageName:(NSString *)imageName isGifEmotion:(BOOL)isGifEmotion;

/**
 * 点击删除按钮
 */
- (void)didSelectedDeleted;

/**
 * 点击发送按钮
 */
- (void)didSelectedSend;

@end

@protocol KPEmotionManagerViewDataSource <NSObject>

@required

/**
 *  通过数据源获取一系列的统一管理表情的Model数组
 *
 *  @return 返回包含统一管理表情Model元素的数组
 */
- (NSArray *)emotionManagersAtManager;


@end

@interface KPEmotionManagerView : UIView

@property (nonatomic, weak) id <KPEmotionManagerViewDelegate> delegate;

@property (nonatomic, weak) id <KPEmotionManagerViewDataSource> dataSource;

/**
 *  是否显示发送的按钮
 */
@property (nonatomic, assign) BOOL hideSendButton; // default is NO (显示)

/**
 *  根据数据源刷新UI布局和数据
 */
- (void)reloadData;

// 根据小表情设置textView的value
+ (void)selectedFaceView:(NSString *)str isDelete:(BOOL)isDelete withTextView:(UITextView *)textView;
@end

