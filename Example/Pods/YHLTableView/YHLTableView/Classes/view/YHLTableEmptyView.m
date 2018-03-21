//
//  YHLTableEmptyView.m
//  Pods
//
//  Created by yanghonglei on 16/7/12.
//
//

#import "YHLTableEmptyView.h"
//#import "<#header#>"
@implementation YHLTableEmptyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor lightGrayColor];
        label.text = @"";
        label.numberOfLines=0;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        _textlabel = label;
        
        NSString *imageName = [@"YHLTableView.bundle" stringByAppendingPathComponent:@"message_tips_nodata"];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imgv = [[UIImageView alloc] init];
//        UIImageView *imgv = [[UIImageView alloc] initWithImage:image];
        imgv.contentMode=UIViewContentModeBottom;
        imgv.frame=CGRectMake(0, 0, 200, 200);
        [label addSubview:imgv];
        imgv.center = CGPointMake(CGRectGetMidX(label.frame), CGRectGetMidY(label.frame) - 20 - imgv.frame.size.height/2-10);
        [self addSubview:imgv];
        _iconImageView = imgv;
        
        
        self.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _textlabel.frame = self.bounds;
    _iconImageView.center = CGPointMake(CGRectGetMidX(_textlabel.frame), CGRectGetMidY(_textlabel.frame) - 20 - _iconImageView.frame.size.height/2-10);
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    _textlabel.backgroundColor = backgroundColor;
}


@end
