//
//  TrailSearchViewController.h
//  爱上旅行
//
//  Created by gdy on 15-1-5.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReusableView.h"
#import "SearchCell.h"

//定义一个 block进行传值
typedef void(^PassValue)(NSString*);

@interface TrailSearchViewController : UIViewController<UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  >
@property(nonatomic,retain)UITextField* searchTF;
@property(nonatomic,copy)PassValue passValue;//传值变量

-(void)dealloc;
@end
