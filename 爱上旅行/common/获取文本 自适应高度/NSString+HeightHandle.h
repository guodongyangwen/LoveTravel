//
//  NSString+HeightHandle.h
//  lessonTest
//
//  Created by gdy on 14-12-17.
//  Copyright (c) 2014年 郭东洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HeightHandle)
//按照系统默认字体，默认大小
+(CGFloat)getHeightWithText:(NSString*)text
                      ViewWidth:(CGFloat)width;
//按照系统字体，自定义大小
+(CGFloat)getHeightWithText:(NSString*)text
                  ViewWidth:(CGFloat)width
                   fontSize:(CGFloat)size;
//按照自定义字体，自定义大小
+(CGFloat)getHeightWithText:(NSString*)text
                  ViewWidth:(CGFloat)width
                   fontName:(NSString*)name
                   fontSize:(CGFloat)size;
@end
