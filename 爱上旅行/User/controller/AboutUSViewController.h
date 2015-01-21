//
//  AboutUSViewController.h
//  爱上旅行
//
//  Created by gdy on 15-1-6.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface AboutUSViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *ImageV;
- (IBAction)phoneHandle:(id)sender;
- (IBAction)emailHandle:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *btnPhone;
@property (retain, nonatomic) IBOutlet UIButton *btnEmail;

@end
