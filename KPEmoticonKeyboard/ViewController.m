//
//  ViewController.m
//  KPEmoticonKeyboard
//
//  Created by lkp on 2017/8/16.
//  Copyright © 2017年 leba. All rights reserved.
//

#import "ViewController.h"
#import "KPEmotionManagerView.h"
@interface ViewController ()<KPEmotionManagerViewDelegate,KPEmotionManagerViewDataSource>
@property (nonatomic, strong, readwrite) KPEmotionManagerView *emotionManagerView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, copy) NSString *emotionStr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _emotionStr = @"";
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 150,CGRectGetWidth(self.view.bounds) , 50)];
    [self.view addSubview:_textView];
    _emotionManagerView = [[KPEmotionManagerView alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.bounds), 216)];
    _emotionManagerView.delegate = self;
    _emotionManagerView.dataSource = self;
    _emotionManagerView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    _emotionManagerView.alpha = 1.0;
    _emotionManagerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_emotionManagerView];
    [self.view bringSubviewToFront:_emotionManagerView];
    [self.emotionManagerView reloadData];
}

#pragma mark - KPEmotionManagerView Delegate
/**
 *  表情被点击的回调事件
 *
 *  @param keyString 根据选择的表情，匹配出的显示的 [微笑]
 *  @param imageName 表情图片id ，Expression_1
 *  @param isGifEmotion 是不是gif大表情
 */
- (void)didSelectedEmotionKey:(NSString *)keyString emotionImageName:(NSString *)imageName isGifEmotion:(BOOL)isGifEmotion
{
    _emotionStr = [_emotionStr stringByAppendingString:[NSString stringWithFormat:@"%@,",keyString]];
    self.textView.text = _emotionStr;
}

/**
 * 点击删除按钮
 */
- (void)didSelectedDeleted
{
}

/**
 * 点击发送按钮
 */
- (void)didSelectedSend
{
    
}

- (NSArray *)emotionManagersAtManager {
    NSMutableArray *emotionManagers = [NSMutableArray array];
    KPEmotionManager *emotionManager = [[KPEmotionManager alloc] init];
    emotionManager.emotionBarLogoImageName = @"emotionbar_qq_logo";
    NSMutableArray *emotionImageNames = [NSMutableArray array];
    for (int j = 1; j < 101; j ++) {
        NSString *imageName = [NSString stringWithFormat:@"Expression_%d",j];
        [emotionImageNames addObject:imageName];
    }
    emotionManager.emotionImageNames = emotionImageNames;
    [emotionManagers addObject:emotionManager];
    emotionManager = [[KPEmotionManager alloc] init];
    emotionManager.emotionBarLogoImageName = @"emotionbar_tuzki_logo";
    emotionManager.isGifEmoji =YES;
    emotionImageNames = [NSMutableArray array];
    for (NSInteger j = 0; j < 16; j ++) {
        NSString *imageName = [NSString stringWithFormat:@"tuzki%d_static", (int)j];
        [emotionImageNames addObject:imageName];
    }
    emotionManager.emotionImageNames = emotionImageNames;
    [emotionManagers addObject:emotionManager];
    emotionManager = [[KPEmotionManager alloc] init];
    emotionManager.emotionBarLogoImageName = @"emotionbar_paopaobing_logo";
    emotionManager.isGifEmoji =YES;
    emotionImageNames = [NSMutableArray array];
    for (NSInteger j = 0; j < 16; j ++) {
        NSString *imageName = [NSString stringWithFormat:@"paopaobing%d_static", (int)j];
        [emotionImageNames addObject:imageName];
    }
    emotionManager.emotionImageNames = emotionImageNames;
    [emotionManagers addObject:emotionManager];
    emotionManager = [[KPEmotionManager alloc] init];
    emotionManager.emotionBarLogoImageName = @"emotionbar_baozou_logo";
    emotionManager.isGifEmoji =YES;
    emotionImageNames = [NSMutableArray array];
    for (NSInteger j = 0; j < 16; j ++) {
        NSString *imageName = [NSString stringWithFormat:@"baozou%d_static", (int)j];
        [emotionImageNames addObject:imageName];
    }
    emotionManager.emotionImageNames = emotionImageNames;
    [emotionManagers addObject:emotionManager];
    emotionManager = [[KPEmotionManager alloc] init];
    emotionManager.emotionBarLogoImageName = @"emotionbar_tuzkiworker_logo";
    emotionManager.isGifEmoji =YES;
    emotionImageNames = [NSMutableArray array];
    for (NSInteger j = 0; j < 16; j ++) {
        NSString *imageName = [NSString stringWithFormat:@"work%d_static", (int)j];
        [emotionImageNames addObject:imageName];
    }
    emotionManager.emotionImageNames = emotionImageNames;
    [emotionManagers addObject:emotionManager];
    return [NSArray arrayWithArray:emotionManagers];
}

@end
