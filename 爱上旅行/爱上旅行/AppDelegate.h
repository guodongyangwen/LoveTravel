//
//  AppDelegate.h
//  爱上旅行
//
//  Created by gdy on 14-12-25.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserGuideViewController.h"
#import "Reachability.h"
#import "TLAlertView.h"
@class Reachability;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    @private
    Reachability *hostReach;
}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(nonatomic,retain)UIView* viewDark;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

-(void)reachabilityChanged:(NSNotification*)note;//网络连接改变

@end
