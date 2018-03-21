//
//  baseCellModel.h
//  Pods
//
//  Created by yang on 16/6/3.
//
//

#import <Foundation/Foundation.h>


/**
 *  cell的viewmodel, 一个cell对应一个cellModel
 */

@protocol baseCellModelProtocal <NSObject>
//cell的高度。
//item内容改变时 应该情况该值-----------
@property (nonatomic, assign) CGFloat cacheHeight;
//cellmodel对应的cell的类
@property (nonatomic, strong) Class Class;
//cell的重用名
@property (nonatomic, strong) NSString *reuseIdentify;

//cell是否通过class注册, 默认是NO, 建议使用Xib创建, 效率高, 且不用设置这个参数
@property (nonatomic, assign) BOOL isRegisterByClass;

@optional

/**
 *  计算cell的高度
 *  @return 高度
 */
- (CGFloat)calculateHeight;

/**
 *  处理成cell model
 *  @param item 数据
 */
- (void)parseItem:(id)item;

@end

@interface baseCellModel : NSObject <baseCellModelProtocal>

@end
