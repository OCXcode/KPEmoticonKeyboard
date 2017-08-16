//
//  KPEmotionManager.m
//  KPEmoticonKeyboard
//
//  Created by lkp on 2017/8/16.
//  Copyright © 2017年 leba. All rights reserved.
//

#import "KPEmotionManager.h"

@implementation KPEmotionManager

- (void)dealloc {
    [self.emotions removeAllObjects];
    self.emotions = nil;
}

//当前类型的表情 一页能显示多少个小表情， -1是因为如果不是gif，最后要有个删除按钮
- (int)emotionCountPrePage
{
    return [self isGifEmoji]? (GIFNumPerLine * GIFLines):((NumPerLine * Lines) - 1);
}


//当前类型的表情 一共有几页
- (int)emotionPageCount
{
    return (int)[self.emotionImageNames count] / self.emotionCountPrePage +  ([self.emotionImageNames count] % self.emotionCountPrePage == 0 ? 0:1) ;
}
@end
