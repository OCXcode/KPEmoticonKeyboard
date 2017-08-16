//
//  FaceManager.m
//  KPEmoticonKeyboard
//
//  Created by lkp on 2017/8/16.
//  Copyright © 2017年 leba. All rights reserved.
//

#import "FaceManager.h"

@implementation FaceManager

+ (id)sharedFaceManager{
    static FaceManager *_sharedFaceManager=nil;
    static dispatch_once_t predUser;
    dispatch_once(&predUser, ^{
        _sharedFaceManager=[[FaceManager alloc] init];
        NSString *plistStr = [[NSBundle mainBundle]pathForResource:@"expressionImage_custom" ofType:@"plist"];
        _sharedFaceManager.emojiDictionary = [[NSDictionary  alloc]initWithContentsOfFile:plistStr];
        plistStr = [[NSBundle mainBundle]pathForResource:@"expressiongif" ofType:@"plist"];
        _sharedFaceManager.gifDictionary = [[NSDictionary  alloc]initWithContentsOfFile:plistStr];
        
        _sharedFaceManager.gifsExisted = [_sharedFaceManager.gifDictionary allValues];
    });
    return _sharedFaceManager;
}
@end
