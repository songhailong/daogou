///Users/che/Desktop/dome/commonLib
//  YHLCarouselView.h
//
//  Created by 万圣伟业 on 2017/6/22.
//  Copyright © 2017年 万圣伟业. All rights reserved.
//


#import <UIKit/UIKit.h>
@class YHLCarouselView;

typedef enum {
    CarouselPositionHide,           //隐藏
    CarouselPositionTopCenter,      //中上
    CarouselPositionBottomLeft,     //左下
    CarouselPositionBottomCenter,   //中下
    CarouselPositionBottomRight     //右下
} YHLCarouselPageControlPosition;

@protocol YHLCarouselViewDelegate <NSObject>
- (NSInteger)numberOfcarouselView:(YHLCarouselView *)carouselView;
- (UIView *)carouselView:(YHLCarouselView *)carouselView subViewForPageAtIndex:(NSInteger)index;

@optional
- (void)carouselView:(YHLCarouselView *)carouselView didSelectViewAtIndex:(NSInteger)index;
- (void)carouselView:(YHLCarouselView *)carouselView didScrollViewAtIndex:(NSInteger)index;


@end


@interface YHLCarouselView : UIView

@property (nonatomic, weak) id<YHLCarouselViewDelegate> delegate;

@property (nonatomic, assign) YHLCarouselPageControlPosition pagePosition;
@property (nonatomic,strong) UIColor *pageControlCurrentColor;
@property (nonatomic,strong) UIColor *pageControlOtherColor;
/**
 *  自动轮播间隔时间
 */
@property (nonatomic, assign) NSTimeInterval time;

-(void)reloadData;
@end

@interface NSTimer (YHLCarouselView)
+ (NSTimer*)yhl_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)())block repeats:(BOOL)repeats;
@end
