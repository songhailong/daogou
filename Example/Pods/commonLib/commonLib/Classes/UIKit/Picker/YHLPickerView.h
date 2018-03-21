//
//  YHLPickerView.h
//  commonLib
//
//  Created by che on 2018/1/24.
//

#import <UIKit/UIKit.h>

typedef void (^YHLDatePickerMainViewBlock)();

@protocol YHLPickerViewDelegate <NSObject>
@optional
- (void)currentPickerViewSelectIndex:(NSArray *)index indexPath:(NSIndexPath *)indexPath;
@end

@interface YHLPickerView : UIView

//必须赋值
@property (nonatomic,assign) NSInteger depth;
//必须赋值 格式如下 @[@{@”id“:“23”,@“name”:@""}]
@property (nonatomic,strong)NSArray *dataSources;

@property (nonatomic, weak) id <YHLPickerViewDelegate> delegate;

@property (nonatomic,strong) NSIndexPath *indexPath;

-(void)showPickerView:(UIWindow *)window;
@end

@interface YHLPickerViewMainView : UIView

@property(nonatomic,copy) YHLDatePickerMainViewBlock block;

@end
