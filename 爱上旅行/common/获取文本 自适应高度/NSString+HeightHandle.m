//
//  NSString+HeightHandle.m
//  lessonTest
//
//  Created by gdy on 14-12-17.
//  Copyright (c) 2014年 郭东洋. All rights reserved.
//

#import "NSString+HeightHandle.h"

@implementation NSString (HeightHandle)
//按照系统默认字体，默认大小   //ViewWidth为控件的宽度
+(CGFloat)getHeightWithText:(NSString*)text
                  ViewWidth:(CGFloat)width
{
    NSDictionary* dic = @{NSFontAttributeName:[UIFont fontWithName:nil size:17]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 100000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return  rect.size.height;
}
//按照系统字体，自定义大小
+(CGFloat)getHeightWithText:(NSString*)text
                  ViewWidth:(CGFloat)width
                   fontSize:(CGFloat)size
{
    NSDictionary* dic = @{NSFontAttributeName:[UIFont fontWithName:nil size:size]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 100000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return  rect.size.height;
}
//按照自定义字体，自定义字体大小，自定义控件宽度 获取文本高度
+(CGFloat)getHeightWithText:(NSString*)text
                  ViewWidth:(CGFloat)width
                   fontName:(NSString*)name
                   fontSize:(CGFloat)size
{
    NSDictionary* dic = @{NSFontAttributeName:[UIFont fontWithName:name size:size]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 100000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return  rect.size.height;
}
@end
