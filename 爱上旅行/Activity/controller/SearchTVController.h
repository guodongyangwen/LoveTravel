//
//  SearchTVController.h
//  爱上旅行
//
//  Created by 闪 on 14-12-29.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeatchTableViewCell.h"

//Block传值
typedef void (^PassValue) (NSString *text);
@interface SearchTVController : UITableViewController<UITextFieldDelegate>
@property(nonatomic,copy)PassValue passValue;
@end
