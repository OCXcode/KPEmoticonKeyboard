//
//  FaceManager.h
//  KPEmoticonKeyboard
//
//  Created by lkp on 2017/8/16.
//  Copyright © 2017年 leba. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FACEMANAGER [FaceManager sharedFaceManager]
@interface FaceManager : NSObject
{
}

+ (id)sharedFaceManager;
@property (strong, nonatomic)NSDictionary *emojiDictionary;

@property (strong, nonatomic)NSDictionary *gifDictionary;

//当前版本已收录的全部gif的名字，通过[gifDictionary allValues]获取，在这里设置成全局变量来增快运行速度
@property (strong, nonatomic)NSArray *gifsExisted;

@end

