//
//  SBUploadImageView.m
//  SBChe
//
//  Created by 万圣伟业 on 2017/3/7.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "SBUploadImageView.h"
#import <commonLib/MSActiveControllerFinder.h>
@interface SBUploadImageView ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation SBUploadImageView


-(instancetype)init{
    self = [super init];
    if (self) {
        //
        [self uploadImageView];
    }
    return  self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder: aDecoder];
    if (self) {
        //
        [self uploadImageView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self uploadImageView];
    }
    return self;
}
-(instancetype)initWithImage:(UIImage *)image{
    self = [super initWithImage:image];
    if (self) {
        //
        [self uploadImageView];
    }
    return self;
}

-(void)uploadImageView{
    self.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadImage)];
    [self addGestureRecognizer:tap];
}





-(void)uploadImage{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        
    }];
    __weak __typeof(self) weakSelf = self;
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = weakSelf;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        
        UIViewController *currentVC = [MSActiveControllerFinder finder].activeTopController();
        [currentVC presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            
        }
        pickerImage.delegate = weakSelf;
        pickerImage.allowsEditing = NO;
        UIViewController *currentVC = [MSActiveControllerFinder finder].activeTopController();
        [currentVC presentViewController:pickerImage animated:YES completion:nil];
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:picture];
    UIViewController *currentVC = [MSActiveControllerFinder finder].activeTopController();
    [currentVC presentViewController:alertVc animated:YES completion:nil];
}


// 选择图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) ==nil)
        {
            data = UIImageJPEGRepresentation(image,1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //把刚刚图片转换的data对象拷贝至沙盒中并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/userHeader.png"] contents:data attributes:nil];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        //加在视图中
        self.image=image;
        
        if ([self.delegate respondsToSelector:@selector(currentImage:)]) {
            [self.delegate currentImage:image];
            
        }
        
    }
}
// 取消选取图片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
   // NSLog(@"SBUploadImageView");
}

@end
