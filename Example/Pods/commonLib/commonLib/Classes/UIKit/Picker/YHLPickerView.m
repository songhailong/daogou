//
//  YHLPickerView.m
//  commonLib
//
//  Created by che on 2018/1/24.
//

#import "YHLPickerView.h"
#import <Masonry/Masonry.h>
#import "MSActiveControllerFinder.h"
#import "UIColor+HexString.h"
@interface YHLPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString *_firstIndex,*_twoIndex,*_threeIndex;
}

@property(nonatomic,strong) NSArray *twoDataSource;
@property(nonatomic,strong) NSArray *threeDataSource;

@property (nonatomic,strong) UIView *maskView;//蒙版
@property (nonatomic,strong) YHLPickerViewMainView *mainView;//底部弹出面板
@property (nonatomic, strong) UIPickerView *pickerView;//
@property (nonatomic, strong) UIButton *customButton;//确认按钮
@property (nonatomic, strong) UIButton *cancleButton;//取消按钮


@end
@implementation YHLPickerView


- (UIView *)maskView{
    if (_maskView==nil) {
        _maskView=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor=[UIColor blackColor];
        _maskView.alpha=0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeMaskView)];
        [_maskView addGestureRecognizer:tap];
        
    }
    return _maskView;
}

- (YHLPickerViewMainView *)mainView{
    if (_mainView==nil) {
        CGSize size =[UIScreen mainScreen].bounds.size;
        _mainView=[[YHLPickerViewMainView alloc] initWithFrame:CGRectMake(0, size.height, size.width, 252)];
        _mainView.backgroundColor=[UIColor whiteColor];
        _mainView.block=^(){
            UIView *v =self;//这里不做任何事。仅仅为了 保留self 不被销毁
            
        };
        [_mainView addSubview:self.customButton];
        [_mainView addSubview:self.cancleButton];
        
        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 42, size.width, 0.5)];
        lineView.backgroundColor=[UIColor colorWithHexString:@"e6e6e6"];
        [_mainView addSubview:lineView];
        
        [_mainView addSubview:self.pickerView];
    }
    return _mainView;
}
- (UIButton *)customButton{
    if (!_customButton) {
        _customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGSize size =[UIScreen mainScreen].bounds.size;
        _customButton.frame = CGRectMake(size.width - 100, 0, 100, 42);
        [_customButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 35, 0, 0)];
        [_customButton setTitleColor:[UIColor colorWithHexString:@"e6e6e6"] forState:UIControlStateNormal];
        [_customButton setTitle:@"确认" forState:UIControlStateNormal];
        _customButton.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        [_customButton addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customButton;
}

- (UIButton *)cancleButton{
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.frame = CGRectMake(0, 0, 100, 42);
        [_cancleButton setTitleColor:[UIColor colorWithHexString:@"e6e6e6"] forState:UIControlStateNormal];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 35)];
        _cancleButton.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        [_cancleButton addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        CGSize size =[UIScreen mainScreen].bounds.size;
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.customButton.frame), size.width, 210)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

-(void)showPickerView:(UIWindow *)window{
    //最多支持三级
    if (self.depth<1||self.depth>3) {
       // [MBProgressHUD showError:@"数据源不正确"];
        return;
    }
    
    if(self.dataSources==nil||self.dataSources.count==0){
       // [MBProgressHUD showError:@"没有可选数据"];
        return;
    }
    
    if (window==nil) {
        return;
    }
    [window addSubview:self.maskView];
    [window addSubview:self.mainView];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.mainView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 252, [[UIScreen mainScreen] bounds].size.width, 252);
    }];
}

-(void)removeMaskView{
    [self.maskView removeFromSuperview];
    [UIView animateWithDuration:0.4 animations:^{
        self.mainView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, 252);
    } completion:^(BOOL finished) {
        [self.mainView removeFromSuperview];
        
    }];
}

-(void)commitClick{
    if (_firstIndex==nil) {
        _firstIndex=@"";
    }
    if (_twoIndex==nil) {
        _twoIndex=@"";
    }
    if (_threeIndex==nil) {
        _threeIndex=@"";
    }
    
   
    if ([self.delegate respondsToSelector:@selector(currentPickerViewSelectIndex:indexPath:)]) {
        [self.delegate currentPickerViewSelectIndex:@[_firstIndex,_twoIndex,_threeIndex] indexPath:self.indexPath];
    }
    [self removeMaskView];
    
}
-(void)cancleClick{
    [self removeMaskView];
}

-(void)setDataSources:(NSArray *)dataSources{
    _dataSources=dataSources;
    _firstIndex=dataSources[0][@"id"];
    if (self.depth==1) {
        _twoIndex=@"0";
        _threeIndex=@"0";
    }
    if(self.depth==2){
        self.twoDataSource=dataSources[0][@"child"];
        _twoIndex=self.twoDataSource[0][@"id"];
        _threeIndex=@"0";
    }
    if (self.depth==3) {
        self.twoDataSource=dataSources[0][@"child"];
        self.threeDataSource=self.twoDataSource[0][@"child"];
        _twoIndex=self.twoDataSource[0][@"id"];
        _threeIndex=self.threeDataSource[0][@"id"];
    }
}



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 42;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.depth;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return self.dataSources.count;
    }
    if (component==1) {
        return self.twoDataSource.count;
    }else if(component ==2){
        return self.threeDataSource.count;
    }
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return CGRectGetWidth([UIScreen mainScreen].bounds)*1.0/self.depth;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==0) {
        _firstIndex = self.dataSources[row][@"id"];
        _twoIndex=@"0";
        _threeIndex=@"0";
        if (self.depth==2) {
            self.twoDataSource=self.dataSources[row][@"child"];
            
            [pickerView selectedRowInComponent:1];
            [pickerView reloadComponent:1];
        }
        if (self.depth==3) {
            self.twoDataSource=self.dataSources[row][@"child"];
            self.threeDataSource=self.twoDataSource[0][@"child"];
            //[pickerView selectedRowInComponent:1];
            [pickerView reloadComponent:1];
            //[pickerView selectedRowInComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
        
    }else if(component == 1){
        _twoIndex=self.twoDataSource[row][@"id"];
        _threeIndex=@"0";
        if (self.depth==3) {
            
            self.threeDataSource=self.twoDataSource[row][@"child"];
            // [pickerView selectedRowInComponent:2];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
        //暂未实现
    }else if(component == 2){
        _threeIndex=self.threeDataSource[row][@"id"];
    }
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSDictionary *dict;
    if (component==0) {
        dict= self.dataSources[row];
    }else if(component==1){
        dict=  self.twoDataSource[row];
    }else{
        dict=  self.threeDataSource[row];
    }
    
    NSString *name=dict[@"name"];
    NSString *content =dict[@"content"];
    if (content==nil) {
        content=@"";
    }else{
        content=[NSString stringWithFormat:@"(%@)",content];
    }
    
    NSString *titles = [NSString stringWithFormat:@"%@%@",name,content];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:titles];
    NSRange range1 = [titles rangeOfString:name];
    NSRange range2 = [titles rangeOfString:content];
    
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"1a1a1a"] range:range1];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range1];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"666666"] range:range2];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:range2];
    
    return att;
}

@end

@implementation YHLPickerViewMainView



@end
