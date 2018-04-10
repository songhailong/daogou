//
//  YHLCarouselView.m
//
//  Created by 万圣伟业 on 2017/6/22.
//  Copyright © 2017年 万圣伟业. All rights reserved.
//

#import "YHLCarouselView.h"
#import <ImageIO/ImageIO.h>

#define DEFAULTTIME 5
#define HORMARGIN 10
#define VERMARGIN 5

@interface YHLCarouselView()<UIScrollViewDelegate>
{
    NSTimer *_timer;
}
//轮播的视图数组
@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, strong) UIScrollView *scrollView;
//分页控件
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIView *currView;
@property (nonatomic, strong) UIView *otherView;
//当前显示图片的索引
@property (nonatomic, assign) NSInteger currIndex;
//将要显示图片的索引
@property (nonatomic, assign) NSInteger nextIndex;

@end


@implementation YHLCarouselView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSubView];
}

- (void)initSubView {
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}

- (CGFloat)height {
    return self.scrollView.frame.size.height;
}

- (CGFloat)width {
    return self.scrollView.frame.size.width;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.scrollsToTop = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.contentInset = UIEdgeInsetsZero;
        [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)]];
        _currView = [[UIView alloc] init];
        _currView.clipsToBounds = YES;
        [_scrollView addSubview:_currView];
        _otherView = [[UIView alloc] init];
        _otherView.clipsToBounds = YES;
        [_scrollView addSubview:_otherView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.hidden=YES;
    }
    return _pageControl;
}
-(void)setPageControlCurrentColor:(UIColor *)pageControlCurrentColor{
    _pageControlCurrentColor=pageControlCurrentColor;
    _pageControl.currentPageIndicatorTintColor = pageControlCurrentColor;
}
-(void)setPageControlOtherColor:(UIColor *)pageControlOtherColor{
    _pageControlOtherColor=pageControlOtherColor;
    _pageControl.pageIndicatorTintColor = pageControlOtherColor;
}

-(UIView *)viewAtIndex:(NSInteger)index{
    UIView *view=self.views[index];
    if ([view isKindOfClass:[NSNull class]]) {
        if (![self.delegate respondsToSelector:@selector(carouselView:subViewForPageAtIndex:)]) {
            NSAssert(NO, @"必须实现 carouselView:subViewForPageAtIndex: 函数");
        }
        view = [self.delegate carouselView:self subViewForPageAtIndex:index];
        if (!view) {
            NSAssert(NO, @"carouselView:subViewForPageAtIndex: 函数不可返回空");
        }
        [self.views replaceObjectAtIndex:index withObject:view];
    }
    view.frame=self.bounds;
    return view;
}

-(void)reloadData{
    //init views---------------------
    if (![self.delegate respondsToSelector:@selector(numberOfcarouselView:)]) {
        NSAssert(NO, @"必须实现 numberOfYHLCarouselView 函数");
    }
    NSInteger number = [self.delegate numberOfcarouselView:self];
    self.views = [NSMutableArray arrayWithCapacity:number];
    for (int i=0; i<number; i++) {
        [self.views addObject:[NSNull null]];
    }
    //init views-----------end----------
    
    [self.currView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.currView addSubview:[self viewAtIndex:_currIndex]];
    self.pageControl.numberOfPages = number;
    [self setNeedsLayout];
}

#pragma mark 设置pageControl的位置
- (void)updatePageControlPosition{
    _pageControl.hidden = (_pagePosition == CarouselPositionHide) || (self.views.count == 1);
    if (_pageControl.hidden) return;
    
    CGSize size = [_pageControl sizeForNumberOfPages:_pageControl.numberOfPages];
    size.height = 8;
    _pageControl.frame = CGRectMake(0, 0, size.width, size.height);
    
    CGFloat centerY = self.height - size.height * 0.5 - VERMARGIN - 0;
    CGFloat pointY = self.height - size.height - VERMARGIN - 0;
    
    if (_pagePosition == CarouselPositionBottomCenter)
        _pageControl.center = CGPointMake(self.width * 0.5, centerY);
    else if (_pagePosition == CarouselPositionTopCenter)
        _pageControl.center = CGPointMake(self.width * 0.5, size.height * 0.5 + VERMARGIN);
    else if (_pagePosition == CarouselPositionBottomLeft)
        _pageControl.frame = CGRectMake(HORMARGIN, pointY, size.width, size.height);
    else
        _pageControl.frame = CGRectMake(self.width - HORMARGIN - size.width, pointY, size.width, size.height);
}

#pragma mark 设置scrollView的contentSize
- (void)updateScrollViewContentSize {
    if (_views.count > 1) {
        //设置contentSize 为frame的三倍宽
        self.scrollView.contentSize = CGSizeMake(self.width * 3, 0);
        //默认滚动到中间 这样才能支持左右滚动
        self.scrollView.contentOffset = CGPointMake(self.width * 1, 0);
        self.currView.frame = CGRectMake(self.width * 1, 0, self.width, self.height);
    } else {
        self.scrollView.contentSize = CGSizeZero;
        self.scrollView.contentOffset = CGPointZero;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.currView.frame=self.bounds;
    self.otherView.frame=self.bounds;
    
    for (UIView *view in [self.currView subviews]) {
        view.frame=self.bounds;
    }
    for (UIView *view in [self.otherView subviews]) {
        view.frame=self.bounds;
    }
    //重新计算pageControl的位置
    [self updatePageControlPosition];;
    [self updateScrollViewContentSize];
}

#pragma mark 视图点击事件
- (void)viewClick {
    if ([_delegate respondsToSelector:@selector(carouselView:didSelectViewAtIndex:)]){
        [_delegate carouselView:self didSelectViewAtIndex:self.currIndex];
    }
}

#pragma mark 当视图滚动过半时就修改当前页码
- (void)changeCurrentPageWithOffset:(CGFloat)offsetX {
    if (offsetX < self.width * 0.5) {
        NSInteger index = self.currIndex - 1;
        if (index < 0) index = self.views.count - 1;
        _pageControl.currentPage = index;
    } else if (offsetX > self.width * 1.5){
        _pageControl.currentPage = (self.currIndex + 1) % self.views.count;
    } else {
        _pageControl.currentPage = self.currIndex;
    }
}

#pragma mark- --------UIScrollViewDelegate--------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (CGSizeEqualToSize(CGSizeZero, scrollView.contentSize)) return;
    CGFloat offsetX = scrollView.contentOffset.x;
    //滚动过程中改变pageControl的当前页码
    [self changeCurrentPageWithOffset:offsetX];
    //向右滚动
    if (offsetX < self.width) {
        self.otherView.frame = CGRectMake(0, 0, self.width, self.height);
        self.nextIndex = self.currIndex - 1;
        if (self.nextIndex < 0) self.nextIndex = _views.count - 1;

        [self.otherView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.otherView addSubview:[self viewAtIndex:self.nextIndex]];
        if (offsetX <= 0) {
            [self changeToNext];
        }
    //向左滚动
    } else if (offsetX > self.width){
        self.otherView.frame = CGRectMake(CGRectGetMaxX(_currView.frame), 0, self.width, self.height);
        self.nextIndex = (self.currIndex + 1) % _views.count;
        [self.otherView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.otherView addSubview:[self viewAtIndex:self.nextIndex]];
        if (offsetX >= self.width * 2){
            [self changeToNext];
        }
    }
}
//该方法用来修复滚动过快导致分页异常的bug
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint currPointInSelf = [_scrollView convertPoint:_currView.frame.origin toView:self];
    if (currPointInSelf.x >= -self.width / 2 && currPointInSelf.x <= self.width / 2)
        [self.scrollView setContentOffset:CGPointMake(self.width * 1, 0) animated:YES];
    else {
        [self changeToNext];
    }
}

//滚动一页完成 修改contentOffset 回到中间
- (void)changeToNext {
    
    
    
    [self.currView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.currView addSubview:self.otherView.subviews[0]];
    self.scrollView.contentOffset = CGPointMake(self.width, 0);
    self.currIndex = self.nextIndex;
    self.pageControl.currentPage = self.currIndex;
    if ([_delegate respondsToSelector:@selector(carouselView:didScrollViewAtIndex:)]){
         [_delegate carouselView:self didScrollViewAtIndex:self.currIndex];
    }
}

#pragma mark- --------定时器相关--------
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}
- (void)setTime:(NSTimeInterval)time {
    _time = time;
    [self reloadData];
    [self startTimer];
}

- (void)startTimer {
    //如果只有一张视图，或者没有设置time，则直接返回，不开启定时器
    if (_views.count <= 1 ||_time==0) return;
    if (_timer) [self stopTimer];
    __weak YHLCarouselView *weakSelf = self;
    _timer = [NSTimer yhl_scheduledTimerWithTimeInterval:_time < 2? DEFAULTTIME: _time block:^{
        YHLCarouselView *strongSelf = weakSelf;
        [strongSelf.scrollView setContentOffset:CGPointMake(0,0) animated:YES];//向右
//         [strongSelf.scrollView setContentOffset:CGPointMake(strongSelf.width * 0, 0) animated:YES];//向左
    } repeats:YES];
}

- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}

-(void)dealloc{
    [self stopTimer];
}
@end


@implementation NSTimer (YHLCarouselView)

+ (NSTimer*)yhl_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(eoc_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
    
}
+ (void)eoc_blockInvoke:(NSTimer*)timer {
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}
@end








