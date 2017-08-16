//
//  KPEmotionManagerView.m
//  KPEmoticonKeyboard
//
//  Created by lkp on 2017/8/16.
//  Copyright © 2017年 leba. All rights reserved.
//

#import "KPEmotionManagerView.h"

#import "KPEmotionSectionBar.h"
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define COLOR_BACKGROUND_RGB RGBCOLOR(241,241,241)
#import "FacialView.h"

@interface KPEmotionManagerView () <UIScrollViewDelegate, KPEmotionSectionBarDelegate, FacialViewDelegate>

/**
 *  最大的UIScrollView
 */
@property (nonatomic, weak) UIScrollView *emotionScrollView;

/**
 *  显示页码的控件
 */
@property (nonatomic, weak) UIPageControl *emotionPageControl;

/**
 *  管理多种类别gif表情的滚动试图
 */
@property (nonatomic, weak) KPEmotionSectionBar *emotionSectionBar;

/**
 *  当前选择了哪类gif表情标识
 */
@property (nonatomic, assign) NSInteger selectedIndex;

/**
 *  配置默认控件
 */
- (void)setup;

/**
 *  表情数据源，从dataSource获取
 */
@property (nonatomic, strong)  NSArray *emotionManagers;

@end

@implementation KPEmotionManagerView

- (void)reloadData {
    
    self.emotionManagers = [self.dataSource emotionManagersAtManager];
    if (!self.emotionManagers) {
        return ;
    }
    self.emotionSectionBar.emotionManagers = _emotionManagers;
    self.emotionSectionBar.hideSendButton = self.hideSendButton;
    [self.emotionSectionBar reloadData];
    
    
    //reloadData 最外层的表情ScrollView
    [self.emotionScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //最外层的表情ScrollView一共有几页
    int totalPageCount = 0;
    
    
    for (int i = 0; i<[_emotionManagers count]; i++) {
        KPEmotionManager *emotionManager = _emotionManagers[i];
        
        //当前类型的表情 一共有几页
        int emotionPageCount = emotionManager.emotionPageCount;
        
        if (i == 0) {
            self.emotionPageControl.numberOfPages = emotionPageCount;
        }
        
        for (int j = 0; j < emotionPageCount; j++) {
            FacialView *_facialView = [[FacialView alloc]initWithFrame:CGRectMake((totalPageCount + j) * CGRectGetWidth(self.bounds),0.0f,CGRectGetWidth(self.bounds),CGRectGetHeight(self.emotionScrollView.bounds))];
            
            [_facialView loadEmotionBoard:emotionManager inPage:j];
            _facialView.tag = i;
            _facialView.delegate = self;
            _facialView.backgroundColor = [UIColor whiteColor];
            [self.emotionScrollView addSubview:_facialView];
        }
        
        totalPageCount += emotionPageCount;
        
    }
    
    [self.emotionScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.emotionScrollView.frame)*totalPageCount,CGRectGetHeight(self.emotionScrollView.frame))];
    
}

#pragma mark - Life cycle

- (void)setup {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    if (!_emotionScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f,kKPEmotionSrollViewMarginTop,CGRectGetWidth(self.bounds),CGRectGetHeight(self.bounds)-kKPEmotionPageControlHeight - kKPEmotionSectionBarHeight - kKPEmotionSrollViewMarginTop)];
        scrollView.delegate = self;
        [self addSubview:scrollView];
        [scrollView setPagingEnabled:YES];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        self.emotionScrollView = scrollView;
    }
    
    if (!_emotionPageControl) {
        UIPageControl *emotionPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.emotionScrollView.frame), CGRectGetWidth(self.bounds), kKPEmotionPageControlHeight)];
        emotionPageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:0.471 alpha:1.000];
        emotionPageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.678 alpha:1.000];
        emotionPageControl.backgroundColor = self.backgroundColor;
        emotionPageControl.hidesForSinglePage = YES;
        emotionPageControl.defersCurrentPageDisplay = YES;
        [self addSubview:emotionPageControl];
        self.emotionPageControl = emotionPageControl;
    }
    
    if (!_emotionSectionBar) {
        KPEmotionSectionBar *emotionSectionBar = [[KPEmotionSectionBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.emotionPageControl.frame), CGRectGetWidth(self.bounds), kKPEmotionSectionBarHeight) hideSendButton:self.hideSendButton];
        emotionSectionBar.delegate = self;
        emotionSectionBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        emotionSectionBar.backgroundColor = COLOR_BACKGROUND_RGB;
        emotionSectionBar.currentIndex = 0;
        [self addSubview:emotionSectionBar];
        self.emotionSectionBar = emotionSectionBar;
    }
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.emotionPageControl.frame), CGRectGetWidth(self.bounds), 0.5)];
    lineView.backgroundColor = RGBCOLOR(220, 220, 220);
    [self addSubview:lineView];
}

- (void)awakeFromNib {
    [self setup];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)dealloc {
    self.emotionPageControl = nil;
    self.emotionSectionBar = nil;
    self.emotionScrollView.delegate = nil;
    //    self.emotionScrollView.dataSource = nil;
    self.emotionScrollView = nil;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        [self reloadData];
    }
}


#pragma mark - FacialViewDelegate
/**
 * 选择了一个面板上的小表情， :
 * indexInManager: 这个表情在KPEmotionManager的位置
 * managerIndex: 这个表情所属的KPEmotionManager 在整个表情managers array的位置
 */
-(void)selectedEmotionAtIndex:(int)indexInManager inManagerSection:(int)managerIndex
{
    KPEmotionManager *emotionManager = _emotionManagers[managerIndex];
    
    NSString *emotionImageName = emotionManager.emotionImageNames[indexInManager];
    
    if (emotionManager.isGifEmoji) {
        
        NSString *gifImageName = [[FACEMANAGER gifDictionary]objectForKey:emotionImageName];
        
        //点击的是gif表情，那么发出去的是动态图gif的名字，比如tuzki8，cell显示的时候直接显示gif
        [_delegate didSelectedEmotionKey:gifImageName emotionImageName:emotionImageName isGifEmotion:emotionManager.isGifEmoji];
        
        
    }else{
        //点击的是小表情，那么发出去的是匹配出的汉字key，比如[微笑]，cell显示时候，再匹配出图片
        
        NSDictionary *plistDic = [FACEMANAGER emojiDictionary] ;
        
        for (int j = 0; j<[[plistDic allKeys]count]; j++)
        {
            if ([[plistDic objectForKey:[[plistDic allKeys]objectAtIndex:j]]
                 isEqualToString:emotionImageName])
            {
                NSString *faceKey = [[plistDic allKeys]objectAtIndex:j];
                [_delegate didSelectedEmotionKey:faceKey emotionImageName:emotionImageName isGifEmotion:emotionManager.isGifEmoji];
                return ;
            }
        }
    }
    
    
}

//选择了一个面板上的删除
-(void)selectedDelete
{
    [_delegate didSelectedDeleted];
}


#pragma mark - KPEmotionSectionBar Delegate
//选择了底部表情bar
- (void)didSelectedEmotionManager:(KPEmotionManager *)emotionManager atSection:(NSInteger)section {
    
    self.emotionSectionBar.currentIndex = (int)section;
    self.emotionPageControl.currentPage = 0;
    
    //最外层的表情ScrollView一共有几页
    int totalPageCount = 0;
    
    for (int i = 0; i<[_emotionManagers count]; i++) {
        KPEmotionManager *emotionManager = _emotionManagers[i];
        
        //当前类型的表情 一共有几页
        int emotionPageCount = emotionManager.emotionPageCount;
        
        if (self.emotionSectionBar.currentIndex == i) {
            //找到了这个表情所在的位置
            [self.emotionScrollView setContentOffset:CGPointMake(totalPageCount* CGRectGetWidth(self.bounds), 0) animated:NO];
            
            self.emotionPageControl.numberOfPages = emotionPageCount;
            
            break;
        }
        
        totalPageCount += emotionPageCount;
    }
}

/**
 * 点击发送按钮
 */
- (void)didSelectedSend
{
    if (_delegate) {
        [_delegate didSelectedSend];
    }
}

#pragma mark - UIScrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //每页宽度
    CGFloat pageWidth = scrollView.frame.size.width;
    //根据当前的坐标与页宽计算当前页码
    NSInteger currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
    
    NSArray *emotionManagers = _emotionManagers;
    
    //最外层的表情ScrollView一共有几页
    int totalPageCount = 0;
    
    for (int i = 0; i<[emotionManagers count]; i++) {
        KPEmotionManager *emotionManager = emotionManagers[i];
        
        //当前类型的表情 一共有几页
        int emotionPageCount = emotionManager.emotionPageCount;
        
        for (int j = 0; j < emotionPageCount; j++) {
            
            if (currentPage == totalPageCount + j) {
                self.emotionSectionBar.currentIndex = i;
                
                self.emotionPageControl.numberOfPages = emotionPageCount;
                
                self.emotionPageControl.currentPage = j;
                
                return;
            }
        }
        totalPageCount += emotionPageCount;
    }
}


+ (void)selectedFaceView:(NSString *)str isDelete:(BOOL)isDelete withTextView:(UITextView *)textView
{
    NSString *content = textView.text;
    
    if (!isDelete && str.length > 0) {
        
        // 获得光标所在的位置
        int location = (int)textView.selectedRange.location;
        // 先拼接前半段，为了给下面重新定制光标位置
        NSString *headresult = [NSString stringWithFormat:@"%@%@",[content substringToIndex:location],str];
        
        // 将UITextView中的内容进行调整（主要是在光标所在的位置进行字符串截取，再拼接你需要插入的文字即可）
        NSString *result = [NSString stringWithFormat:@"%@%@",headresult,[content substringFromIndex:location]];
        // 将调整后的字符串添加到UITextView上面
        textView.text = result;
        //重新设置光标位置
        NSRange range;
        
        range.location = [headresult length];
        
        range.length = 0;
        
        textView.selectedRange = range;
        
        
    } else {
        //点的是删除按钮
        // 获得光标所在的位置
        int location = (int)textView.selectedRange.location;
        if( location == 0 ){
            return;
        }
        // 先获取前半段
        NSString *headresult = [content substringToIndex:location];
        
        if ([headresult hasSuffix:@"]"]) {
            //最后一位是]
            for (int i = (int)[headresult length]; i>=0 ; i--) {
                //往前找，找到"["
                NSString *tempString = [[headresult substringToIndex:i]substringFromIndex:(i-1)];
                if ([tempString isEqualToString:@"["] ) {
                    //砍掉[XXX]，重新赋值前半段
                    headresult = [headresult substringToIndex:i - 1];
                    
                    // 将UITextView中的内容进行调整（主要是在光标所在的位置进行字符串截取，再拼接你需要插入的文字即可）
                    NSString *result = [NSString stringWithFormat:@"%@%@",headresult,[content substringFromIndex:location]];
                    // 将调整后的字符串添加到UITextView上面
                    textView.text = result;
                    //重新设置光标位置
                    NSRange range;
                    
                    range.location = [headresult length];
                    
                    range.length = 0;
                    
                    textView.selectedRange = range;
                    return ;
                }
            }
        }
        //删除文字
        if (content.length > 0) {
            headresult = [headresult substringToIndex:headresult.length-1];
            // 将UITextView中的内容进行调整（主要是在光标所在的位置进行字符串截取，再拼接你需要插入的文字即可）
            NSString *result = [NSString stringWithFormat:@"%@%@",headresult,[content substringFromIndex:location]];
            // 将调整后的字符串添加到UITextView上面
            textView.text = result;
            //重新设置光标位置
            NSRange range;
            
            range.location = [headresult length];
            
            range.length = 0;
            
            textView.selectedRange = range;
            return ;
        }
    }
}

@end
