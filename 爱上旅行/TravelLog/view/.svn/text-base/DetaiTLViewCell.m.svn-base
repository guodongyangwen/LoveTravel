//
//  DetaiTLViewCell.m
//  爱上旅行
//
//  Created by 齐浩 on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "DetaiTLViewCell.h"
#import "UIImageView+WebCache.h"
@implementation DetaiTLViewCell

-(void)dealloc
{
    self.descriptionLable = nil;
    self.detailTL = nil;
    self.pictures = nil;
    [super dealloc];


}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        //image
        self.bg_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 310, 200)];
        self.bg_imageView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.bg_imageView];
        [self.bg_imageView release];
       
        //description
        _descriptionLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 205, 300, 20)];
        _descriptionLable.font = [UIFont systemFontOfSize:12];
        _descriptionLable.numberOfLines = 0;
        [self.contentView addSubview:_descriptionLable];
        [_descriptionLable release];
        
        
    }

    return self;
}





-(void)setPictures:(Picture *)pictures
{
    //调用方法 获取传入数据的需要高度
    self.hight = [DetaiTLViewCell getHighWithString:pictures.description];
    
    //给lable 重设 frame
    CGRect frame = self.descriptionLable.frame;
    frame.size.height = _hight;
    self.descriptionLable.frame = frame;
//    NSLog(@"图片描述:%@",self.pictures.description);
    //图片描述
    self.descriptionLable.text = pictures.description;
    
    
    //图片缓冲视图
    PlaceholdAnimateView *place =[[PlaceholdAnimateView alloc]initWithFrame:CGRectMake(140, 70, 40, 40)];
    [self.bg_imageView addSubview:place];
    [place start];

    
    //图片
    NSURL *url = [NSURL URLWithString:pictures.picture];
    [self.bg_imageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [place cancel];
    }];
    


}

//计算描述文字的高度
+(CGFloat)getHighWithString:(NSString *)string
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(320, 100000) options:NSStringDrawingUsesLineFragmentOrigin
                   | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    

    if ([string length] == 0) {
        
        return 0;
    }
    return rect.size.height;

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
