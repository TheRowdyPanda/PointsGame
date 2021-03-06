//
//  MyScene.h
//  Points
//

//  Copyright (c) 2014 Rijul Gupta. All rights reserved.
//


#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import <GameKit/GameKit.h>
#import <Social/Social.h>
#import <FacebookSDK/FacebookSDK.h>
#import "GADInterstitial.h"
#import <RevMobAds/RevMobAds.h>
#include "Reachability.h"
#import <CoreData/CoreData.h>

//#import "GAIDictionaryBuilder.h"


@interface MyScene : SKScene <GKGameCenterControllerDelegate, GADInterstitialDelegate>{
    
    GADInterstitial *adMobinterstitial_;
    GADRequest *request;
    
}


@end
