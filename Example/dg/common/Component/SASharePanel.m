//
//  SASharePanel.m
//  SAChe
//
//  Created by 万圣伟业 on 2017/8/2.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "SASharePanel.h"
#import "CCWXShare.h"

@interface SASharePanel ()

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *imageName;

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;

- (IBAction)leftClick:(id)sender;
- (IBAction)rightClick:(id)sender;
- (IBAction)closeClick:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property (weak, nonatomic) IBOutlet UIView *footerView;


@end

@implementation SASharePanel

+(void)showShare: (NSString *)title content:(NSString *)content url:(NSString *)url imageName:(NSString *)imageName{
    SASharePanel *panel =[[[NSBundle mainBundle] loadNibNamed:@"SASharePanel" owner:nil options:nil] firstObject];
    
    panel.title=title;
    panel.content=content;
    panel.url=url;
    panel.imageName=imageName;
    
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:panel action:@selector(closePane)];
    [panel.maskView addGestureRecognizer:tap];
    
    [panel buttonLayout:panel.leftButton];
    [panel buttonLayout:panel.rightButton];
    
    panel.frame=[UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:panel];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3f animations:^{
            panel.bottom.constant=0;
            [panel layoutIfNeeded];
        }];
    });
    
    
}

-(void)buttonLayout:(UIButton *)btn{
    
    CGFloat imageW = btn.imageView.frame.size.width;
    CGFloat imageH = btn.imageView.frame.size.height;
    
    CGFloat titleW = btn.titleLabel.frame.size.width;
    CGFloat titleH = btn.titleLabel.frame.size.height;
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageW, -imageH+10, 0.f)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-titleH-5, 0.f, 0.f,-titleW)];
}


- (IBAction)leftClick:(id)sender {
    //UIImage *image =[UIImage imageNamed:@"https://ss3.bdstatic.com/lPoZeXSm1A5BphGlnYG/icon/9483.png"];
    [CCWXShare sendLinkContent:1 title:self.title content:self.content imageName:self.imageName url:self.url];
    
    //    if ([self.delegate respondsToSelector:@selector(SASharePanelSelectItem:)]) {
//        [self.delegate SASharePanelSelectItem:0];
//    }
}

- (IBAction)rightClick:(id)sender {
    //UIImage *image =[UIImage imageNamed:@"https://ss3.bdstatic.com/lPoZeXSm1A5BphGlnYG/icon/9483.png"];
    [CCWXShare sendLinkContent:0 title:self.title content:self.content imageName:self.imageName url:self.url];
//    if ([self.delegate respondsToSelector:@selector(SASharePanelSelectItem:)]) {
//        [self.delegate SASharePanelSelectItem:1];
//    }
}

- (IBAction)closeClick:(id)sender {
    
    [UIView animateWithDuration:0.3f animations:^{
        self.bottom.constant=-200;;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
}

-(void)closePane{
    [self closeClick:nil];
}




//-(void)dealloc{
//    NSLog(@"aa");
//}
@end
