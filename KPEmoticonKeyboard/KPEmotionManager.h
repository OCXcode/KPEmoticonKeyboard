//
//  KPEmotionManager.h
//  KPEmoticonKeyboard
//
//  Created by lkp on 2017/8/16.
//  Copyright © 2017年 leba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPEmotion.h"


#define NumPerLine 7
#define Lines    3

#define GIFNumPerLine 4
#define GIFLines    2


//一种表情的实体类，其中包含了一个array，存了他的每个表情
@interface KPEmotionManager : NSObject


@property (nonatomic, assign) BOOL isGifEmoji;
/**
 * 显示在最底部的表情条里的logo图标的imagename
 */
@property (nonatomic, strong) NSString *emotionBarLogoImageName;

/**
 *  某一类 每个小表情的图片imageName<NSString>
 */
@property (nonatomic, strong) NSMutableArray *emotionImageNames;


//当前类型的表情 一页能显示多少个小表情， -1是因为如果不是gif，最后要有个删除按钮
@property (nonatomic, assign, readonly) int emotionCountPrePage;

//当前类型的表情 一共有几页
@property (nonatomic, assign, readonly) int emotionPageCount;

/**
 *  某一类表情的数据源<KPEmotion> debug废弃
 */
@property (nonatomic, strong) NSMutableArray *emotions;

@end

