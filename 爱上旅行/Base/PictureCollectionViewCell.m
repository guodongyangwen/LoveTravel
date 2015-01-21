//
//  PictureCollectionViewCell.m
//  爱上旅行
//
//  Created by gdy on 14-12-29.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "PictureCollectionViewCell.h"

@interface PictureCollectionViewCell ()
@property(nonatomic,retain)UILongPressGestureRecognizer* longPress;
@end

@implementation PictureCollectionViewCell

//-(void)dealloc
//{
//    self.picture = nil;
//    self.imageView = nil;
//    self.textDescription = nil;
//    [super dealloc];
//}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor blackColor];
        //y坐标和 高度，需要自适应
        //图片
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
        _imageView.userInteractionEnabled = YES;
                //捏合手势
        UIPinchGestureRecognizer* pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchHandle:)];
        [_imageView addGestureRecognizer:pinch];
        [pinch release];
        //长按手势
       self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longHandle:)];
        //_longPress.minimumPressDuration = 1.5;
        _longPress.allowableMovement = 10;
        [_imageView addGestureRecognizer:_longPress];
        [_longPress release];
        
        [self.contentView addSubview:_imageView];
        [_imageView release];
        //描述
        //y坐标和高度，需要自适应
        self.textDescription = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, 300, 0)];
        _textDescription.font = [UIFont fontWithName:nil size:13];
        _textDescription.editable = NO;
        _textDescription.selectable = NO;
        [self.contentView addSubview:_textDescription];
        [_textDescription release];
    }
    return self;
}



//长按手势
-(void)longHandle:(UILongPressGestureRecognizer*)longPress
{
        
     if(longPress.state == UIGestureRecognizerStateBegan)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否保存到相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
        [alert show];
    }
    
   
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        
    }
    else
    {
        UIImageView* imageV = (UIImageView*)_longPress.view;
        UIImageWriteToSavedPhotosAlbum(imageV.image, nil, nil, nil);
    }
}




//捏合手势
-(void)pinchHandle:(UIPinchGestureRecognizer*)pinch
{
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
    pinch.scale = 1.0;//一倍缩放
}



//重写setter方法
-(void)setPicture:(Picture *)picture
{
    if(_picture != picture)
    {
        [_picture release];
        _picture = [picture retain];
        
        //****************************设置图片
        //加载动画
        PlaceholdAnimateView* place = [[PlaceholdAnimateView alloc] initWithFrame:CGRectMake(140, 40, 40, 40)];
        [_imageView addSubview:place];
        [place start];
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:picture.picture] placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [place cancel];
        }];
        
        
        
        //获取图片的高度
        CGFloat height_pic = picture.height.floatValue;
        CGFloat scale = height_pic/([[UIScreen mainScreen] bounds].size.height);
        //设置imageview 的  布局
        //高度
        CGFloat height_imageView =([[UIScreen mainScreen] bounds].size.height)/7 * scale;
        //y坐标
        CGFloat y =(([[UIScreen mainScreen] bounds].size.height) - ([[UIScreen mainScreen] bounds].size.height)/7 * scale)/2;
        
        CGRect frame = _imageView.frame ;
        if(height_imageView < [[UIScreen mainScreen] bounds].size.height/2)//小于屏幕一半
        {
            frame.origin.y = [[UIScreen mainScreen] bounds].size.height/4;
            frame.size.height = [[UIScreen mainScreen] bounds].size.height/2;
        }
        else
        {
            frame.size.height = height_imageView;
             frame.origin.y = y;
        }
        
       
        _imageView.frame = frame;
        
        
        //****************************设置描述
        //获取文本高度
        CGFloat height_text = [NSString getHeightWithText:picture.description ViewWidth:300 fontName:nil fontSize:13];
        
        if(height_text < y)
        {
            CGRect frame = _textDescription.frame;
            frame.origin.y = ([[UIScreen mainScreen] bounds].size.height) - height_text -60;
            frame.size.height = height_text + 20;
            
            _textDescription.frame = frame;
        }
        else
        {
            CGRect frame = _textDescription.frame;
            frame.origin.y = height_imageView + y -20;
            frame.size.height = y + 20;
            _textDescription.frame = frame;
        }
        
        //赋值
        picture.description = [picture.description stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n" options:NSLiteralSearch range:NSMakeRange(0, picture.description.length)];
        _textDescription.text = picture.description;
        _textDescription.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _textDescription.textColor = [UIColor whiteColor];
        
    }
    
}



@end
