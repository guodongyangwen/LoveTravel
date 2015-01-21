//
//  ReusableView.h
//  爱上旅行
//
//  Created by gdy on 15-1-5.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReusableView : UICollectionReusableView
@property(nonatomic,retain)UILabel* textLabel;
@property(nonatomic,retain)UILabel* lineLabel;
-(void)dealloc;
@end
