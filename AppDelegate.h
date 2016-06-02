//
//  AppDelegate.h
//  Points
//
//  Created by Rijul Gupta on 6/8/14.
//  Copyright (c) 2014 Rijul Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RevMobAds/RevMobAds.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;


@end
