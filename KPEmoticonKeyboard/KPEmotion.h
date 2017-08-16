//
//  KPEmotion.h
//  KPEmoticonKeyboard
//
//  Created by lkp on 2017/8/16.
//  Copyright © 2017年 leba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kKPEmotionImageViewSize 40
#define kKPEmotionMinimumLineSpacing 12

@interface KPEmotion : NSObject

/**
 *  gif表情的封面图
 */
@property (nonatomic, strong) UIImage *emotionConverPhoto;

/**
 *  gif表情的路径
 */
@property (nonatomic, copy) NSString *emotionPath;

@end
