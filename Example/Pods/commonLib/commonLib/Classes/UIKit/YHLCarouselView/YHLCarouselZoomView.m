//
//  YHLCarouselZoomView.m
//  Pods-commonLib_Example
//
//  Created by che on 2018/1/17.
//

#import "YHLCarouselZoomView.h"
#define DEFAULTTIME 5
#define HORMARGIN 10

@interface YHLCarouselZoomView()<UIScrollViewDelegate>
{
    NSTimer *_timer;
}
//轮播的视图数组
@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, assign) NSInteger originCount;//视图数组的原始数据数。处理两个视图的情况 才有意义
@property (nonatomic, strong) UIScrollView *scrollView;
//分页控件
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIView *currView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *otherView;

//当前视图索引
@property (nonatomic, assign) NSInteger currIndex;
//右边视图索引
@property (nonatomic, assign) NSInteger nextIndex;
//左边视图索引
@property (nonatomic, assign) NSInteger lastIndex;
@end

@implementation YHLCarouselZoomView

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
    
    self.leftRightMargin=30;
    self.topBottomMargin=40;
    
}

- (CGFloat)height {
    return self.scrollView.frame.size.height;
}

- (CGFloat)width {
    return self.scrollView.frame.size.width;
}

-(UIView *)leftView{
    if (!_leftView) {
        _leftView=[[UIView alloc] init]; 
        [self.scrollView addSubview:_leftView];
    }
    return _leftView;
}

-(UIView *)rightView{
    if (!_rightView) {
        _rightView=[[UIView alloc] init];
        [self.scrollView addSubview:_rightView];
    }
    return _rightView;
}

-(UIView *)currView{
    if (!_currView) {
        _currView=[[UIView alloc] init];

        [self.scrollView addSubview:_currView];
    }
    return _currView;
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
        _scrollView.clipsToBounds=NO;
        _scrollView.contentInset = UIEdgeInsetsZero;
        [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)]];
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
    self.pageControl.currentPageIndicatorTintColor = pageControlCurrentColor;
}
-(void)setPageControlOtherColor:(UIColor *)pageControlOtherColor{
    _pageControlOtherColor=pageControlOtherColor;
    self.pageControl.pageIndicatorTintColor = pageControlOtherColor;
}

-(UIView *)viewAtIndex:(NSInteger)index{
    if (index>self.views.count-1) {
        return nil;
    }
    UIView *view=self.views[index];
    if ([view isKindOfClass:[NSNull class]]) {
        if (![self.delegate respondsToSelector:@selector(carouselView:subViewForPageAtIndex:)]) {
            NSAssert(NO, @"必须实现 carouselView:subViewForPageAtIndex: 函数");
        }
        if (self.originCount==2) {
            view = [self.delegate carouselView:self subViewForPageAtIndex:index%2];
        }else{
            view = [self.delegate carouselView:self subViewForPageAtIndex:index];
        }
        if (!view) {
            NSAssert(NO, @"carouselView:subViewForPageAtIndex: 函数不可返回空");
        }
        view.layer.cornerRadius=5;
        view.clipsToBounds=YES;
        [self.views replaceObjectAtIndex:index withObject:view];
    }
    return view;
}

-(void)reloadData{
    //init views---------------------
    if (![self.delegate respondsToSelector:@selector(numberOfcarouselView:)]) {
        NSAssert(NO, @"必须实现 numberOfYHLCarouselView 函数");
    }
    NSInteger number = [self.delegate numberOfcarouselView:self];
    self.originCount=number;
    if (number==2) {
        number=4;
    }
    self.views = [NSMutableArray arrayWithCapacity:number];
    for (int i=0; i<number; i++) {
        [self.views addObject:[NSNull null]];
    }
    
    //init views-----------end----------
    
    self.nextIndex=self.views.count-1;
    self.currIndex=0;
    self.lastIndex=1;
    
    [self.leftView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.leftView addSubview:[self viewAtIndex:self.nextIndex]];
    [self.currView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.currView addSubview:[self viewAtIndex:self.currIndex]];
    [self.rightView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.rightView addSubview:[self viewAtIndex:self.lastIndex]];
    
    self.pageControl.numberOfPages = self.originCount;
    
    [self setNeedsLayout];
}

#pragma mark 设置pageControl的位置
- (void)updatePageControlPosition{
   
    _pageControl.hidden = (_pagePosition == PositionHide) || (self.views.count == 1);
    if (_pageControl.hidden) return;
    
    CGSize size = [_pageControl sizeForNumberOfPages:_pageControl.numberOfPages];
    size.height = 8;
    _pageControl.frame = CGRectMake(0, 0, size.width, size.height);
    
    CGSize selfSize = self.frame.size;
    
    if (_pagePosition == PositionBottomCenter)
        _pageControl.frame = CGRectMake((selfSize.width-size.width)*0.5+self.pageControlOffset.horizontal, selfSize.height-size.height+self.pageControlOffset.vertical, size.width, size.height);
    else if (_pagePosition == PositionTopCenter)
        _pageControl.frame = CGRectMake((selfSize.width-size.width)*0.5+self.pageControlOffset.horizontal, self.pageControlOffset.vertical, size.width, size.height);
    else if (_pagePosition == PositionBottomLeft)
        _pageControl.frame = CGRectMake(self.pageControlOffset.horizontal, selfSize.height-size.height+self.pageControlOffset.vertical, size.width, size.height);
    else
        _pageControl.frame = CGRectMake((selfSize.width-size.width)+self.pageControlOffset.horizontal, selfSize.height-size.height+self.pageControlOffset.vertical, size.width, size.height);
}

#pragma mark 设置scrollView的contentSize
- (void)updateScrollViewContentSize {
    if (_views.count > 1) {
        //设置contentSize 为frame的三倍宽
        self.scrollView.contentSize = CGSizeMake(self.width * 3, 0);
        //默认滚动到中间 这样才能支持左右滚动
        self.scrollView.contentOffset = CGPointMake(self.width, 0);
    } else {
        self.scrollView.contentSize = CGSizeZero;
        self.scrollView.contentOffset = CGPointZero;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (CGSizeEqualToSize(CGSizeZero, self.currentViewSize)) {
        self.currentViewSize=CGSizeMake(self.frame.size.width-80, self.frame.size.height-20);
        
    }
    
    CGFloat topBottom= (self.bounds.size.height-self.currentViewSize.height)*0.5;
    CGFloat leftRight= (self.bounds.size.width-self.currentViewSize.width)*0.5;
    self.scrollView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(topBottom, leftRight, topBottom, leftRight));
    
    
    self.leftView.frame=CGRectMake(0, 0, self.width, self.height);
    for (UIView *view in [self.leftView subviews]) {
        view.frame=UIEdgeInsetsInsetRect(self.leftView.bounds, UIEdgeInsetsMake(self.topBottomMargin*0.5, self.leftRightMargin*0.5, self.topBottomMargin*0.5, self.leftRightMargin*0.5));
    }
    
    self.currView.frame=CGRectMake(self.width, 0, self.width, self.height);
    if (self.views.count==1) {
        self.leftView.hidden=YES;
        self.rightView.hidden=YES;
        self.currView.frame=CGRectMake(0, 0, self.width, self.height);
    }
    for (UIView *view in [self.currView subviews]) {
        view.frame=self.currView.bounds;
    }
    
    self.rightView.frame=CGRectMake(self.width*2, 0, self.width, self.height);
    for (UIView *view in [self.rightView subviews]) {
        view.frame=UIEdgeInsetsInsetRect(self.rightView.bounds, UIEdgeInsetsMake(self.topBottomMargin*0.5, self.leftRightMargin*0.5, self.topBottomMargin*0.5, self.leftRightMargin*0.5));
    }
    //重新计算pageControl的位置
    [self updatePageControlPosition];;
    [self updateScrollViewContentSize];
}

#pragma mark 视图点击事件
- (void)viewClick {
    if ([_delegate respondsToSelector:@selector(carouselView:didSelectViewAtIndex:)]){
        NSInteger index = self.currIndex;
        if (self.originCount==2) {
            index=self.currIndex%2;
        }
        [_delegate carouselView:self didSelectViewAtIndex:index];
    }
}

#pragma mark 当视图滚动过半时就修改当前页码
- (void)changeCurrentPageWithOffset:(CGFloat)offsetX {
    
    NSInteger currentPage = 0;
    
    if (offsetX < self.width * 0.5) {
        NSInteger index = self.currIndex - 1;
        if (index < 0) index = self.views.count - 1;
        currentPage = index;
    } else if (offsetX > self.width * 1.5){
        currentPage = (self.currIndex + 1) % self.views.count;
    } else {
        currentPage = self.currIndex;
    }
    if (self.originCount==2) {
        _pageControl.currentPage=currentPage%2;
    }else{
        _pageControl.currentPage=currentPage;
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
        [self updateSubViewFrame:offsetX view:self.leftView];
        
        CGFloat scrollWidth = fabs(offsetX-self.width);
        CGFloat leftX = self.scrollView.frame.origin.x;
        if (scrollWidth>=leftX) {
            if (self.rightView.frame.origin.x==self.width*2) {
                NSInteger otherInder = self.nextIndex;
                otherInder--;
                otherInder=otherInder >= 0?otherInder:_views.count - 1;
                UIView *otherSubView = [self viewAtIndex:otherInder];
                otherSubView.frame=UIEdgeInsetsInsetRect(self.rightView.bounds, UIEdgeInsetsMake(self.topBottomMargin*0.5, self.leftRightMargin*0.5, self.topBottomMargin*0.5, self.leftRightMargin*0.5));
                UIView *oldRightView = self.rightView.subviews.firstObject;
                [self.rightView addSubview:otherSubView];
                [oldRightView removeFromSuperview];
                
                self.rightView.frame=CGRectMake(self.leftView.frame.origin.x-self.width, 0, self.width, self.height);
            }
        }else{
            if (self.rightView.frame.origin.x==-self.width) {
                UIView *otherSubView = [self viewAtIndex:self.lastIndex];
                otherSubView.frame=UIEdgeInsetsInsetRect(self.rightView.bounds, UIEdgeInsetsMake(self.topBottomMargin*0.5, self.leftRightMargin*0.5, self.topBottomMargin*0.5, self.leftRightMargin*0.5));
                UIView *oldRightView = self.rightView.subviews.firstObject;
                [self.rightView addSubview:otherSubView];
                [oldRightView removeFromSuperview];
                
                self.rightView.frame=CGRectMake(self.width*2, 0, self.width, self.height);
            }
        }
        
        if (offsetX <= 0) {
            self.nextIndex--;
            self.currIndex--;
            self.lastIndex--;
            self.nextIndex=self.nextIndex >= 0?self.nextIndex:_views.count - 1;
            self.currIndex=self.currIndex >= 0?self.currIndex:_views.count - 1;
            self.lastIndex=self.lastIndex >= 0?self.lastIndex:_views.count - 1;
            
            [self changeToNext];
        }
        
    //向左滚动
    } else if (offsetX > self.width){
        [self updateSubViewFrame:offsetX view:self.rightView];
        
        CGFloat scrollWidth = fabs(offsetX-self.width);
        CGFloat leftX = self.scrollView.frame.origin.x;
        if (scrollWidth>=leftX) {
            if (self.leftView.frame.origin.x==0) {
                NSInteger otherInder = self.lastIndex;
                otherInder++;
                otherInder=otherInder==self.views.count?0:otherInder;
                UIView *otherSubView = [self viewAtIndex:otherInder];
                otherSubView.frame=UIEdgeInsetsInsetRect(self.leftView.bounds, UIEdgeInsetsMake(self.topBottomMargin*0.5, self.leftRightMargin*0.5, self.topBottomMargin*0.5, self.leftRightMargin*0.5));
                UIView *oldLeftView = self.leftView.subviews.firstObject;
                [self.leftView addSubview:otherSubView];
                [oldLeftView removeFromSuperview];
                
                self.leftView.frame=CGRectMake(self.rightView.frame.origin.x+self.width, 0, self.width, self.height);
            }
        }else{
            if (self.leftView.frame.origin.x==self.width*3) {
                UIView *otherSubView = [self viewAtIndex:self.nextIndex];
                otherSubView.frame=UIEdgeInsetsInsetRect(self.leftView.bounds, UIEdgeInsetsMake(self.topBottomMargin*0.5, self.leftRightMargin*0.5, self.topBottomMargin*0.5, self.leftRightMargin*0.5));
                UIView *oldLeftView = self.leftView.subviews.firstObject;
                [self.leftView addSubview:otherSubView];
                [oldLeftView removeFromSuperview];
                
                self.leftView.frame=CGRectMake(0, 0, self.width, self.height);
            }
        }
        
        
        if (offsetX >= self.width * 2){
            self.nextIndex++;
            self.currIndex++;
            self.lastIndex++;
            self.nextIndex=self.nextIndex==self.views.count?0:self.nextIndex;
            self.currIndex=self.currIndex==self.views.count?0:self.currIndex;
            self.lastIndex=self.lastIndex==self.views.count?0:self.lastIndex;
            
            [self changeToNext];
        }
        
    }
}
//滚动过程动态修改frame
-(void)updateSubViewFrame:(CGFloat)offsetX view:(UIView *)view{
    
    CGFloat height = (self.topBottomMargin/self.width)*(offsetX-self.width);
    CGFloat width =(self.leftRightMargin/self.width)*(offsetX-self.width);
    
    CGFloat edgeHeight=(self.topBottomMargin-fabs(height))*0.5;
    CGFloat edgeWidth =(self.leftRightMargin-fabs(width))*0.5;
    UIView *subView = view.subviews.firstObject;
    subView.frame=UIEdgeInsetsInsetRect(view.bounds, UIEdgeInsetsMake(edgeHeight, edgeWidth, edgeHeight, edgeWidth));
    
    UIView *currSubView = self.currView.subviews.firstObject;
    currSubView.frame=UIEdgeInsetsInsetRect(self.currView.bounds, UIEdgeInsetsMake(fabs(height)*0.5, fabs(width)*0.5, fabs(height)*0.5, fabs(width)*0.5));
//    NSLog(@"%.0f",)
    
    
    
}

//该方法用来修复滚动过快导致分页异常的bug
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint currPointInSelf = [_scrollView convertPoint:_currView.frame.origin toView:self];
    if (currPointInSelf.x >= -self.width / 2 && currPointInSelf.x <= self.width / 2)
        [self.scrollView setContentOffset:CGPointMake(self.width, 0) animated:YES];
    else {
        [self changeToNext];
    }
}

//滚动一页完成 修改contentOffset 回到中间
- (void)changeToNext {

    self.leftView.frame=CGRectMake(0, 0, self.width, self.height);
    self.currView.frame=CGRectMake(self.width, 0, self.width, self.height);
    self.rightView.frame=CGRectMake(self.width*2, 0, self.width, self.height);

    UIView *leftSubView = [self viewAtIndex:self.nextIndex];
    leftSubView.frame=UIEdgeInsetsInsetRect(self.leftView.bounds, UIEdgeInsetsMake(self.topBottomMargin*0.5, self.leftRightMargin*0.5, self.topBottomMargin*0.5, self.leftRightMargin*0.5));
    UIView *oldLeftView = self.leftView.subviews.firstObject;
    [self.leftView addSubview:leftSubView];
    [oldLeftView removeFromSuperview];
    //[self.leftView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    UIView *currSubView = [self viewAtIndex:self.currIndex];
    currSubView.frame=self.currView.bounds;
    [self.currView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.currView addSubview:currSubView];
    
    
    UIView *rightSubView = [self viewAtIndex:self.lastIndex];
    rightSubView.frame=UIEdgeInsetsInsetRect(self.rightView.bounds, UIEdgeInsetsMake(self.topBottomMargin*0.5, self.leftRightMargin*0.5, self.topBottomMargin*0.5, self.leftRightMargin*0.5));
    UIView *oldRightView = self.rightView.subviews.firstObject;
//    [self.rightView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.rightView addSubview:rightSubView];
    [oldRightView removeFromSuperview];
    
    if (self.originCount==2) {
        self.pageControl.currentPage = self.currIndex%2;
    }else{
        self.pageControl.currentPage = self.currIndex;
    }
    
    
    self.scrollView.contentOffset = CGPointMake(self.width, 0);
    
    if ([_delegate respondsToSelector:@selector(carouselView:didScrollViewAtIndex:)]){
        NSInteger index  = self.currIndex;
        if (self.originCount==2) {
            index = self.currIndex%2;
        }
        [_delegate carouselView:self didScrollViewAtIndex:index];
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
    __weak YHLCarouselZoomView *weakSelf = self;
    _timer = [NSTimer yhl_scheduledTimerWithTimeInterval:_time < 2? DEFAULTTIME: _time block:^{
        YHLCarouselZoomView *strongSelf = weakSelf;
        if (strongSelf.isCarousel) {
            [strongSelf stopTimer];
        }else{
            [strongSelf.scrollView setContentOffset:CGPointMake(0,0) animated:YES];//向右
            //                 [strongSelf.scrollView setContentOffset:CGPointMake(strongSelf.width * 0, 0) animated:YES];//向左
        }
        
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

@implementation NSTimer (YHLCarouselZoomView)

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
