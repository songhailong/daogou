//
//  YHLCarouselZoomView.h
//  Pods-commonLib_Example
//
//  Created by che on 2018/1/17.
//

#import <UIKit/UIKit.h>
@class YHLCarouselZoomView;

typedef enum {
    PositionHide,           //隐藏
    PositionTopCenter,      //中上
    PositionBottomLeft,     //左下
    PositionBottomCenter,   //中下
    PositionBottomRight     //右下
} YHLPageControlPosition;

@protocol YHLCarouselZoomViewDelegate <NSObject>
- (NSInteger)numberOfcarouselView:(YHLCarouselZoomView *)carouselView;
- (UIView *)carouselView:(YHLCarouselZoomView *)carouselView subViewForPageAtIndex:(NSInteger)index;

@optional
- (void)carouselView:(YHLCarouselZoomView *)carouselView didSelectViewAtIndex:(NSInteger)index;
- (void)carouselView:(YHLCarouselZoomView *)carouselView didScrollViewAtIndex:(NSInteger)index;


@end

@interface YHLCarouselZoomView : UIView

@property (nonatomic, weak) id<YHLCarouselZoomViewDelegate> delegate;

@property (nonatomic, assign) YHLPageControlPosition pagePosition;
@property (nonatomic,strong) UIColor *pageControlCurrentColor;
@property (nonatomic,strong) UIColor *pageControlOtherColor;
@property (nonatomic,assign) CGSize currentViewSize;
@property (nonatomic,assign) NSInteger topBottomMargin;//上下间距
@property (nonatomic,assign) NSInteger leftRightMargin;//左右间距
@property (nonatomic,assign) UIOffset pageControlOffset;//控件偏移量
/**
 *  自动轮播间隔时间
 */
@property (nonatomic, assign) NSTimeInterval time;
/**
 *  是否开启无限轮播,默认为开启 如果开启无限轮播 time 设置无效
 */
@property (nonatomic, assign) BOOL isCarousel;
-(void)reloadData;

@end

@interface NSTimer (YHLCarouselZoomView)
+ (NSTimer*)yhl_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)())block repeats:(BOOL)repeats;
@end

