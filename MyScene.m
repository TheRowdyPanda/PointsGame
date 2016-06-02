//
//  MyScene.m
//  Points
//
//  Created by Rijul Gupta on 6/8/14.
//  Copyright (c) 2014 Rijul Gupta. All rights reserved.
//
//https://www.youtube.com/watch?v=2GdQTf3CDCY - chris hardwick saying points
#import "MyScene.h"
@interface MyScene () <SKPhysicsContactDelegate>
@property double screenChanger;
@property unsigned long long score;
@property (nonatomic) SKNode *redHolder;
@property int touchPlusCostLevel;
@property (nonatomic) NSArray *touchPlusCostArray;
@property (nonatomic) NSArray *touchPlusValueArray;

@property (nonatomic) SKNode *red_2_Holder;
@property int touchMultiCostLevel;
@property (nonatomic) NSArray *touchMultiCostArray;
@property (nonatomic) NSArray *touchMultiValueArray;

@property (nonatomic) SKNode *blue_1_Holder;
@property int timeCostLevel;
@property (nonatomic) NSArray *timeCostArray;
@property (nonatomic) NSArray *timeValueArray;


@property (nonatomic) SKNode *blue_2_Holder;
@property int timePlusCostLevel;
@property (nonatomic) NSArray *timePlusCostArray;
@property (nonatomic) NSArray *timePlusValueArray;

@property (nonatomic) SKNode *facebook_ballHolder;

@property (nonatomic) SKNode *twitter_ballHolder;


@property (nonatomic) NSMutableArray *ballHolder;

@property double hueValue;

@property BOOL isClicking;
@property BOOL gameHasStarted;

@property CGPoint previousTouchesMovedPoint;
@property(nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property(nonatomic) NSTimeInterval lastBoundaryCheckTimeInterval;
@property(nonatomic) NSTimeInterval lastTimePointTimeInterval;

@property int numberOfClicksSinceAd;
@end

@implementation MyScene



-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        _screenChanger = self.size.width/320;
        _touchMultiCostLevel = 0;
        _touchPlusCostLevel = 0;
        _timeCostLevel = 0;
        _timePlusCostLevel = 0;
        _hueValue = 0;
        _isClicking = false;
        _gameHasStarted = false;
        _previousTouchesMovedPoint = CGPointMake(0, 0);
        _numberOfClicksSinceAd = 100;
        
        
        NSInteger savedTouchMultiLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"savedTouchMultiLevel"];
     NSInteger savedTouchPlusLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"savedTouchPlusLevel"];
        
        NSInteger savedTimeMultiLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"savedTimeMultiLevel"];
        NSInteger savedTimePlusLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"savedTimePlusLevel"];
             //   NSInteger savedScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"savedScore"];
        unsigned long long savedScore = [[[NSUserDefaults standardUserDefaults] objectForKey:@"savedScore"] unsignedLongLongValue];
        
        if(savedTouchMultiLevel != nil)_touchMultiCostLevel = savedTouchMultiLevel;
            if(savedTouchPlusLevel != nil) _touchPlusCostLevel = savedTouchPlusLevel;
        if(savedTimeMultiLevel != nil) _timeCostLevel = savedTimeMultiLevel;
        if(savedTimePlusLevel != nil) _timePlusCostLevel = savedTimePlusLevel;
        if(savedScore != nil) _score = savedScore;

//        _timeCostLevel = 0;
//        _touchPlusCostLevel = 0;
//        _touchMultiCostLevel = 0;
//        _touchPlusCostLevel = 0;
//        _timeCostLevel = 0;
//        _timePlusCostLevel = 0;
//        _score = 50;
//        _touchMultiCostLevel = 0;
        
        _touchMultiCostArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:2*pow(10, 2)],
                               [NSNumber numberWithInt:2*pow(10, 3)],
                               [NSNumber numberWithInt:5*pow(10, 3)],
                               [NSNumber numberWithInt:2.5*pow(10, 4)],
                               [NSNumber numberWithInt:1*pow(10, 5)],
                               [NSNumber numberWithInt:5*pow(10, 5)],
                               [NSNumber numberWithInt:2*pow(10, 6)],
                               [NSNumber numberWithInt:1*pow(10, 7)],
                               [NSNumber numberWithInt:2.5*pow(10, 7)],
                               [NSNumber numberWithInt:5*pow(10, 7)],
                                [NSNumber numberWithInt:1*pow(10, 8)],
                                [NSNumber numberWithInt:2*pow(10, 8)],
                                [NSNumber numberWithInt:5*pow(10, 8)],//13
                                [NSNumber numberWithInt:1*pow(10, 9)],//14
                                [NSNumber numberWithInt:2*pow(10, 9)],//15
                                [NSNumber numberWithInt:0],//16

                               
                               nil];
        _touchMultiValueArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],
                                [NSNumber numberWithInt:2],
                                [NSNumber numberWithInt:3],
                                [NSNumber numberWithInt:4],
                                [NSNumber numberWithInt:5],
                                [NSNumber numberWithInt:7],
                                [NSNumber numberWithInt:10],
                                 [NSNumber numberWithInt:12],
                                 [NSNumber numberWithInt:15],
                                 [NSNumber numberWithInt:20],
                                 [NSNumber numberWithInt:25],
                                 [NSNumber numberWithInt:30],
                                 [NSNumber numberWithInt:35],//13
                                 [NSNumber numberWithInt:40],//14
                                 [NSNumber numberWithInt:45],//15
                                 [NSNumber numberWithInt:50],//16




                                
                                nil];
        
        _touchPlusCostArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:5*pow(10, 2)],
                               [NSNumber numberWithInt:4*pow(10, 3)],
                               [NSNumber numberWithInt:1*pow(10, 4)],
                               [NSNumber numberWithInt:5*pow(10, 4)],
                               [NSNumber numberWithInt:1.5*pow(10, 5)],
                               [NSNumber numberWithInt:5*pow(10, 5)],
                               [NSNumber numberWithInt:2*pow(10, 6)],
                               [NSNumber numberWithInt:5*pow(10, 6)],
                               [NSNumber numberWithInt:2*pow(10, 7)],
                               [NSNumber numberWithInt:5*pow(10, 7)],
                               [NSNumber numberWithInt:1*pow(10, 8)],
                               [NSNumber numberWithInt:5*pow(10, 8)],
                               [NSNumber numberWithLongLong:2.5*pow(10, 9)],//13
                               [NSNumber numberWithLongLong:5*pow(10, 9)],//14
                               [NSNumber numberWithLongLong:1*pow(10, 10)],//15
                              // [NSNumber numberWithLongLong:3*pow(10, 10)],//16

                               [NSNumber numberWithInt:0],//16


                               
                                nil];
        _touchPlusValueArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],//last multi*plus =~300K
                               [NSNumber numberWithInt:5],
                               [NSNumber numberWithInt:10],
                               [NSNumber numberWithInt:25],
                               [NSNumber numberWithInt:50],
                               [NSNumber numberWithInt:75],
                               [NSNumber numberWithInt:150],
                               [NSNumber numberWithInt:500],
                               [NSNumber numberWithInt:1.5*pow(10, 3)],
                               [NSNumber numberWithInt:5*pow(10, 3)],
                               [NSNumber numberWithInt:1*pow(10, 4)],
                                [NSNumber numberWithInt:1.5*pow(10, 4)],
                                [NSNumber numberWithInt:2*pow(10, 4)],//13
                                [NSNumber numberWithInt:2.5*pow(10, 4)],//14
                                [NSNumber numberWithInt:5*pow(10, 4)],//15
                                [NSNumber numberWithInt:1*pow(10, 5)],//16

                              //  [NSNumber numberWithInt:1000000],


                               
                               nil];
        
                               
                               
        _timeValueArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],//multi
                           [NSNumber numberWithInt:2],
                           [NSNumber numberWithInt:3],
                           [NSNumber numberWithInt:5],
                           [NSNumber numberWithInt:7],
                           [NSNumber numberWithInt:10],
                           [NSNumber numberWithInt:15],
                           [NSNumber numberWithInt:20],
                           [NSNumber numberWithInt:25],
                           [NSNumber numberWithInt:35],
                           [NSNumber numberWithInt:50],
                           [NSNumber numberWithInt:75],
                           [NSNumber numberWithInt:100],//13
                           [NSNumber numberWithInt:125],//14
                           [NSNumber numberWithInt:150],//15

                           
                           nil];
        
        _timeCostArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:5*pow(10, 2)],
                          [NSNumber numberWithInt:4*pow(10, 3)],
                          [NSNumber numberWithInt:1*pow(10, 4)],
                          [NSNumber numberWithInt:5*pow(10, 4)],
                          [NSNumber numberWithInt:1.5*pow(10, 5)],
                          [NSNumber numberWithInt:5*pow(10, 5)],
                          [NSNumber numberWithInt:2*pow(10, 6)],
                          [NSNumber numberWithInt:5*pow(10, 6)],
                          [NSNumber numberWithInt:2*pow(10, 7)],
                          [NSNumber numberWithInt:5*pow(10, 7)],
                          [NSNumber numberWithInt:1*pow(10, 8)],
                          [NSNumber numberWithInt:5*pow(10, 8)],
                          [NSNumber numberWithInt:1*pow(10, 9)],//13
                          [NSNumber numberWithLongLong:2*pow(10, 9)],//14
                          [NSNumber numberWithInt:0],//15

                          
                           nil];
        
        
        _timePlusValueArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],
                               [NSNumber numberWithInt:5],
                               [NSNumber numberWithInt:10],
                               [NSNumber numberWithInt:25],
                               [NSNumber numberWithInt:50],
                               [NSNumber numberWithInt:75],
                               [NSNumber numberWithInt:150],
                               [NSNumber numberWithInt:500],
                               [NSNumber numberWithInt:1.5*pow(10, 3)],
                               [NSNumber numberWithInt:5*pow(10, 3)],
                               [NSNumber numberWithInt:1*pow(10, 4)],
                               [NSNumber numberWithInt:1.5*pow(10, 4)],
                               [NSNumber numberWithInt:2*pow(10, 4)],//13
                               [NSNumber numberWithInt:2.5*pow(10, 4)],//14
                               [NSNumber numberWithInt:5*pow(10, 4)],//15
                               [NSNumber numberWithInt:1*pow(10, 5)],//16

                           nil];
        
        _timePlusCostArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:5*pow(10, 2)],
                              [NSNumber numberWithInt:4*pow(10, 3)],
                              [NSNumber numberWithInt:1*pow(10, 4)],
                              [NSNumber numberWithInt:5*pow(10, 4)],
                              [NSNumber numberWithInt:1.5*pow(10, 5)],
                              [NSNumber numberWithInt:5*pow(10, 5)],
                              [NSNumber numberWithInt:2*pow(10, 6)],
                              [NSNumber numberWithInt:5*pow(10, 6)],
                              [NSNumber numberWithInt:2*pow(10, 7)],
                              [NSNumber numberWithInt:5*pow(10, 7)],
                              [NSNumber numberWithInt:1*pow(10, 8)],
                              [NSNumber numberWithInt:5*pow(10, 8)],
                              [NSNumber numberWithLongLong:1*pow(10, 9)],//13
                              [NSNumber numberWithLongLong:2.5*pow(10, 9)],//14
                              [NSNumber numberWithLongLong:5*pow(10, 9)],//15

                              [NSNumber numberWithInt:0],//16
                              
                          
                          
                          nil];
        
        
        self.backgroundColor = [SKColor colorWithRed:(236.0/255) green:(240.0/255) blue:(241.0/255) alpha:1.0];
        self.physicsWorld.gravity = CGVectorMake(0, 0);

        

    
        
        SKSpriteNode *instructions = [SKSpriteNode spriteNodeWithImageNamed:@"instructions.png"];
        instructions.size = self.size;
        instructions.position = CGPointMake(self.size.width/2, self.size.height/2);
        instructions.zPosition = 1000;
        instructions.name = @"instructionsNode";
        [self addChild:instructions];
        
        
       // [self addChild:myLabel];
      //  [self updatePointLabel:1000000];
        [self updatePointLabel:50];//shows label before game starts
       // [self updatePointLabel:1.5*pow(10, 11)];


        [self addBalls];
        
        
        
        
        
        
        adMobinterstitial_ = [[GADInterstitial alloc] init];
        
        adMobinterstitial_.adUnitID = @"ca-app-pub-4658531991803126/9744176090";
        [adMobinterstitial_ setDelegate:self];
    
        
        
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        if(_gameHasStarted == false) [self removeInstructions];

        
      //  int rando = arc4random()%10;
       // if(rando == 1)_touchPlusCostLevel++;
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
       // [self addParticlesWithValue:[[_touchPlusValueArray objectAtIndex:_touchPlusCostLevel] intValue] multiplyer:[[_touchMultiValueArray objectAtIndex:_touchMultiCostLevel] intValue] position:location];
        [self addParticlesTouchwithPosition:location];

      //  SKNode *testNode = [self nodeAtPoint:location];
        
        int differenceRed = sqrt(pow((location.x - _redHolder.position.x), 2)
 + pow((location.y - _redHolder.position.y), 2));

        int differenceRed_2 = sqrt(pow((location.x - _red_2_Holder.position.x), 2)
                                 + pow((location.y - _red_2_Holder.position.y), 2));
        
        int differenceBlue_1 = sqrt(pow((location.x - _blue_1_Holder.position.x), 2)
                                   + pow((location.y - _blue_1_Holder.position.y), 2));
        
        int differenceBlue_2 = sqrt(pow((location.x - _blue_2_Holder.position.x), 2)
                                    + pow((location.y - _blue_2_Holder.position.y), 2));
        
        int differenceFacebook_ball = sqrt(pow((location.x - _facebook_ballHolder.position.x), 2)
                                    + pow((location.y - _facebook_ballHolder.position.y), 2));
        
        int differenceTwitter_ball = sqrt(pow((location.x - _twitter_ballHolder.position.x), 2)
                                           + pow((location.y - _twitter_ballHolder.position.y), 2));
        
        
        NSLog(@"DIFFERENCE = %d", differenceRed);

        SKSpriteNode *showNodeRed1 = (SKSpriteNode *)[_redHolder childNodeWithName:@"redBackName"];
        if(differenceRed <= 30*_screenChanger){
            //NSLog(@"CLICKED SPRITE");

            if(showNodeRed1.alpha == 0.0){
                showNodeRed1.alpha = 0.8;
                _redHolder.physicsBody.velocity = CGVectorMake(0, 0);
            }
            else{
                showNodeRed1.alpha = 0.0;
                int xRand = (arc4random()%12 - 6)*20;
                if(xRand == 0) xRand = 20;
                int yRand = (arc4random()%12 - 6)*20;
                if(yRand == 0) yRand = 20;
                _redHolder.physicsBody.velocity = CGVectorMake(xRand, yRand);
                [self runAction:[SKAction playSoundFileNamed:@"ballClickedOut.wav" waitForCompletion:NO]];

            }
            

            
        }
        else if(differenceRed <= 50*_screenChanger && showNodeRed1.alpha != 0.0){
            int localDifferenceY = showNodeRed1.position.y - location.y;
           // NSLog(@"SLDKFJSLKDF");

            if(localDifferenceY <= 0){
                NSLog(@"SLDKFJSLKDF");
                [self checkTouchMulti];
            }
        }

        
        SKSpriteNode *showNodeRed2 = (SKSpriteNode *)[_red_2_Holder childNodeWithName:@"red_2_BackName"];
        if(differenceRed_2 <= 30*_screenChanger){
            NSLog(@"CLICKED SPRITE");
            
            if(showNodeRed2.alpha == 0.0){
                showNodeRed2.alpha = 0.8;
                _red_2_Holder.physicsBody.velocity = CGVectorMake(0, 0);
            }
            else{
                showNodeRed2.alpha = 0.0;
                int xRand = (arc4random()%12 - 6)*20;
                if(xRand == 0) xRand = 20;
                int yRand = (arc4random()%12 - 6)*20;
                if(yRand == 0) yRand = 20;
                _red_2_Holder.physicsBody.velocity = CGVectorMake(xRand, yRand);
                [self runAction:[SKAction playSoundFileNamed:@"ballClickedOut.wav" waitForCompletion:NO]];
                
            }
        }
        else if(differenceRed_2 <= 50*_screenChanger && showNodeRed2.alpha != 0.0){
            int localDifferenceY = showNodeRed1.position.y - location.y;
            // NSLog(@"SLDKFJSLKDF");
            
            if(localDifferenceY <= 0){
                NSLog(@"SLDKFJSLKDF");
                [self checkTouchPlus];
            }
        }

        
        
        
        SKSpriteNode *showNodeBlue1 = (SKSpriteNode *)[_blue_1_Holder childNodeWithName:@"blue_1_BackName"];
        if(differenceBlue_1 <= 30*_screenChanger){
            NSLog(@"CLICKED SPRITE");
            
            if(showNodeBlue1.alpha == 0.0){
                showNodeBlue1.alpha = 0.8;
                _blue_1_Holder.physicsBody.velocity = CGVectorMake(0, 0);
            }
            else{
                showNodeBlue1.alpha = 0.0;
                int xRand = (arc4random()%12 - 6)*20;
                if(xRand == 0) xRand = 20;
                int yRand = (arc4random()%12 - 6)*20;
                if(yRand == 0) yRand = 20;
                _blue_1_Holder.physicsBody.velocity = CGVectorMake(xRand, yRand);
                [self runAction:[SKAction playSoundFileNamed:@"ballClickedOut.wav" waitForCompletion:NO]];
                
            }
        }
        else if(differenceBlue_1 <= 50*_screenChanger && showNodeBlue1.alpha != 0.0){
            int localDifferenceY = showNodeBlue1.position.y - location.y;
            // NSLog(@"SLDKFJSLKDF");
            
            if(localDifferenceY <= 0){
                NSLog(@"SLDKFJSLKDF");
                [self checkTimeMulti];
            }
        }
        
        
        
        
        SKSpriteNode *showNodeBlue2 = (SKSpriteNode *)[_blue_2_Holder childNodeWithName:@"blue_2_BackName"];
        if(differenceBlue_2 <= 30*_screenChanger){
            NSLog(@"CLICKED SPRITE");
            
            if(showNodeBlue2.alpha == 0.0){
                showNodeBlue2.alpha = 0.8;
                _blue_2_Holder.physicsBody.velocity = CGVectorMake(0, 0);
            }
            else{
                showNodeBlue2.alpha = 0.0;
                int xRand = (arc4random()%12 - 6)*20;
                if(xRand == 0) xRand = 20;
                int yRand = (arc4random()%12 - 6)*20;
                if(yRand == 0) yRand = 20;
                _blue_2_Holder.physicsBody.velocity = CGVectorMake(xRand, yRand);
                [self runAction:[SKAction playSoundFileNamed:@"ballClickedOut.wav" waitForCompletion:NO]];
                
            }
        }
        else if(differenceBlue_2 <= 50*_screenChanger && showNodeBlue2.alpha != 0.0){
            int localDifferenceY = showNodeBlue2.position.y - location.y;
            // NSLog(@"SLDKFJSLKDF");
            
            if(localDifferenceY <= 0){
                NSLog(@"SLDKFJSLKDF");
                [self checkTimePlus];
            }
        }
        
        
        
        
        
        SKSpriteNode *showNodeFacebook = (SKSpriteNode *)[_facebook_ballHolder childNodeWithName:@"facebook_ballBackName"];
        if(differenceFacebook_ball <= 30*_screenChanger){
            NSLog(@"CLICKED SPRITE");
            
            if(showNodeFacebook.alpha == 0.0){
                showNodeFacebook.alpha = 0.8;
                _facebook_ballHolder.physicsBody.velocity = CGVectorMake(0, 0);
            }
            else{
                showNodeFacebook.alpha = 0.0;
                int xRand = (arc4random()%12 - 6)*20;
                if(xRand == 0) xRand = 20;
                int yRand = (arc4random()%12 - 6)*20;
                if(yRand == 0) yRand = 20;
                _facebook_ballHolder.physicsBody.velocity = CGVectorMake(xRand, yRand);
                [self runAction:[SKAction playSoundFileNamed:@"ballClickedOut.wav" waitForCompletion:NO]];
                
            }
        }
        else if(differenceFacebook_ball <= 50*_screenChanger && showNodeFacebook.alpha != 0.0){
            int localDifferenceY = showNodeFacebook.position.y - location.y;
            // NSLog(@"SLDKFJSLKDF");
            
            if(localDifferenceY <= 0){
                NSLog(@"SLDKFJSLKDF");
                [self checkFacebook];
            }
        }
        
        
        
        SKSpriteNode *showNodeTwitter = (SKSpriteNode *)[_twitter_ballHolder childNodeWithName:@"twitter_ballBackName"];
        if(differenceTwitter_ball <= 30*_screenChanger){
            NSLog(@"CLICKED SPRITE");
            
            if(showNodeTwitter.alpha == 0.0){
                showNodeTwitter.alpha = 0.8;
                _twitter_ballHolder.physicsBody.velocity = CGVectorMake(0, 0);
            }
            else{
                showNodeTwitter.alpha = 0.0;
                int xRand = (arc4random()%12 - 6)*20;
                if(xRand == 0) xRand = 20;
                int yRand = (arc4random()%12 - 6)*20;
                if(yRand == 0) yRand = 20;
                _twitter_ballHolder.physicsBody.velocity = CGVectorMake(xRand, yRand);
                [self runAction:[SKAction playSoundFileNamed:@"ballClickedOut.wav" waitForCompletion:NO]];
                
            }
        }
        else if(differenceTwitter_ball <= 50*_screenChanger && showNodeTwitter.alpha != 0.0){
            int localDifferenceY = showNodeTwitter.position.y - location.y;
            // NSLog(@"SLDKFJSLKDF");
            
            if(localDifferenceY <= 0){
                NSLog(@"SLDKFJSLKDF");
                [self checkTwitter];
            }
        }
        
     //   [self addChild:sprite];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        if(_previousTouchesMovedPoint.x == 0 && _previousTouchesMovedPoint.y == 0){//starting
            _previousTouchesMovedPoint = location;
        }
        int num = arc4random()%9;
        
        float xVel = location.x - _previousTouchesMovedPoint.x;
        float yVel = location.y - _previousTouchesMovedPoint.y;
        
        for(int i = 0; i < _ballHolder.count; i ++){
            SKNode *testHolder = [_ballHolder objectAtIndex:i];
            int difference = sqrt(pow((location.x - testHolder.position.x), 2)
                                     + pow((location.y - testHolder.position.y), 2));
            
            if(difference <= 50){
                testHolder.physicsBody.velocity = CGVectorMake(xVel, yVel);
                [self runAction:[SKAction playSoundFileNamed:@"ballHitWall3.wav" waitForCompletion:NO]];
            }
        }
        
        if(num == 1){
        
     //   [self addParticlesWithValue:[[_touchPlusValueArray objectAtIndex:_touchPlusCostLevel] intValue] multiplyer:[[_touchMultiValueArray objectAtIndex:_touchMultiCostLevel] intValue] position:location];
            

            
        }
        [self addParticlesTouchwithPosition:location];

        //   [self addChild:sprite];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        double duration = 0.1;
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (duration) * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            ///  [self dismissNode:emitterSprite];
            _isClicking = false;
            
        });
        
    }
}
-(void)addBalls{
    
    _ballHolder = [NSMutableArray array];
    
    
    
    
    
    
    
    _redHolder = [SKNode node];
    _redHolder.position = CGPointMake(280*_screenChanger, 50*_screenChanger);
    
    SKSpriteNode *redBack = [SKSpriteNode spriteNodeWithImageNamed:@"ballBack.png"];
    redBack.size = CGSizeMake(120*_screenChanger, 140*_screenChanger);
    redBack.position = CGPointMake(0, 0);
    redBack.name = @"redBackName";
    [_redHolder addChild:redBack];

    
    SKSpriteNode *redBall = [SKSpriteNode spriteNodeWithImageNamed:@"redBall.png"];
    redBall.size =CGSizeMake(50*_screenChanger, 50*_screenChanger);
    redBall.position = CGPointMake(0, 0);
    [_redHolder addChild:redBall];
    
    NSString *redPic = [NSString stringWithFormat:@"touchMulti_%d", _touchMultiCostLevel + 1];
    SKSpriteNode *redLabel = [SKSpriteNode spriteNodeWithImageNamed:redPic];
    redLabel.name = @"redLabelNode";
    redLabel.size = CGSizeMake(30*_screenChanger, 30*_screenChanger);
    redLabel.position = CGPointMake(0, 0);
    [_redHolder addChild:redLabel];
    
    SKLabelNode *redDescription = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
    redDescription.fontColor = [UIColor whiteColor];
    redDescription.fontSize = 12*_screenChanger;
    redDescription.text = @"Points Per Touch";
    redDescription.position = CGPointMake(0, 45*_screenChanger);
    [redBack addChild:redDescription];
    
    
    SKLabelNode *redCost = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
    redCost.fontColor = [UIColor whiteColor];
    redCost.fontSize = 12*_screenChanger;
    redCost.name = @"redCostNode";
    NSString *redCostString = [NSString stringWithFormat:@"Cost:%@", [self convertNumberToString:[[_touchMultiCostArray objectAtIndex:_touchMultiCostLevel] longLongValue]]];
    redCost.text = redCostString;
    redCost.position = CGPointMake(0, 30*_screenChanger);
    [redBack addChild:redCost];
    
    SKSpriteNode *redbuyBox = [SKSpriteNode spriteNodeWithImageNamed:@"buyBox.png"];
    redbuyBox.size = CGSizeMake(redBack.size.width*0.6, 30*_screenChanger);
    redbuyBox.position = CGPointMake(0, -42*_screenChanger);
    redbuyBox.name = @"redbuyBoxNode";
    [redBack addChild:redbuyBox];
    

    [self addChild:_redHolder];
    
    /*
    _redHolder.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:redBall.size.width/2];
    _redHolder.physicsBody.velocity = CGVectorMake(80*_screenChanger, 80*_screenChanger);
    _redHolder.physicsBody.linearDamping = 0;
    _redHolder.physicsBody.friction = 0;
    */
    redBack.alpha = 0.0;
    [_ballHolder addObject:_redHolder];
    
    
    
    
    
    
    
    
    
    
    
    
    _red_2_Holder = [SKNode node];
    _red_2_Holder.position = CGPointMake(220*_screenChanger, 50*_screenChanger);
    
    SKSpriteNode *red_2_Back = [SKSpriteNode spriteNodeWithImageNamed:@"ballBack.png"];
    red_2_Back.size = CGSizeMake(120*_screenChanger, 140*_screenChanger);
    red_2_Back.position = CGPointMake(0, 0);
    red_2_Back.name = @"red_2_BackName";
    [_red_2_Holder addChild:red_2_Back];
    
    SKSpriteNode *red_2_Ball = [SKSpriteNode spriteNodeWithImageNamed:@"redBall.png"];
    red_2_Ball.size = CGSizeMake(50*_screenChanger, 50*_screenChanger);
    red_2_Ball.position = CGPointMake(0, 0);
    [_red_2_Holder addChild:red_2_Ball];

    
    NSString *redPic_2 = [NSString stringWithFormat:@"touchPlus_%d", _touchPlusCostLevel + 1];
    SKSpriteNode *red_2_Label = [SKSpriteNode spriteNodeWithImageNamed:redPic_2];
    red_2_Label.name = @"red_2_LabelNode";
    red_2_Label.size = CGSizeMake(30*_screenChanger, 30*_screenChanger);
    red_2_Label.position = CGPointMake(0, 0);
    [_red_2_Holder addChild:red_2_Label];
    
    
    SKLabelNode *red_2_Description = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
    red_2_Description.fontColor = [UIColor whiteColor];
    red_2_Description.fontSize = 12*_screenChanger;
    red_2_Description.text = @"Points Per Touch";
    red_2_Description.position = CGPointMake(0, 45*_screenChanger);
    [red_2_Back addChild:red_2_Description];
    
    
    SKLabelNode *red_2_Cost = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
    red_2_Cost.fontColor = [UIColor whiteColor];
    red_2_Cost.name = @"red_2_CostNode";
    red_2_Cost.fontSize = 12*_screenChanger;
    NSString *red_2_CostString = [NSString stringWithFormat:@"Cost:%@", [self convertNumberToString:[[_touchPlusCostArray objectAtIndex:_touchPlusCostLevel] longLongValue]]];
    
    red_2_Cost.text = red_2_CostString;
    red_2_Cost.position = CGPointMake(0, 30*_screenChanger);
    [red_2_Back addChild:red_2_Cost];
    
    SKSpriteNode *red_2_buyBox = [SKSpriteNode spriteNodeWithImageNamed:@"buyBox.png"];
    red_2_buyBox.size = CGSizeMake(redBack.size.width*0.6, 30*_screenChanger);
    red_2_buyBox.position = CGPointMake(0, -42*_screenChanger);
    red_2_buyBox.name = @"red_2_buyBoxNode";
    [red_2_Back addChild:red_2_buyBox];

    
    
    [self addChild:_red_2_Holder];
    
    /*
    _red_2_Holder.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:red_2_Ball.size.width/2];
    _red_2_Holder.physicsBody.velocity = CGVectorMake(-80*_screenChanger, 80*_screenChanger);
    _red_2_Holder.physicsBody.linearDamping = 0;
    _red_2_Holder.physicsBody.friction = 0;
    */
    red_2_Back.alpha = 0.0;
    [_ballHolder addObject:_red_2_Holder];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    _blue_1_Holder = [SKNode node];
    _blue_1_Holder.position = CGPointMake(280*_screenChanger, 120*_screenChanger);


    SKSpriteNode *blue_1_Back = [SKSpriteNode spriteNodeWithImageNamed:@"ballBack.png"];
    blue_1_Back.size = CGSizeMake(120*_screenChanger, 140*_screenChanger);
    blue_1_Back.position = CGPointMake(0, 0);
    blue_1_Back.name = @"blue_1_BackName";
    [_blue_1_Holder addChild:blue_1_Back];
    
    SKSpriteNode *blue_1_Ball = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    blue_1_Ball.size = CGSizeMake(50*_screenChanger, 50*_screenChanger);
    blue_1_Ball.position = CGPointMake(0, 0);
    [_blue_1_Holder addChild:blue_1_Ball];
    
    NSString *bluePic_1 = [NSString stringWithFormat:@"timeMulti_%d", _timeCostLevel + 1];
    SKSpriteNode *blue_1_Label = [SKSpriteNode spriteNodeWithImageNamed:bluePic_1];
    blue_1_Label.name = @"blue_1_LabelNode";
    blue_1_Label.size = CGSizeMake(30*_screenChanger, 30*_screenChanger);
    blue_1_Label.position = CGPointMake(0, 0);
    [_blue_1_Holder addChild:blue_1_Label];
    
    
    SKLabelNode *blue_1_Description = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
    blue_1_Description.fontColor = [UIColor whiteColor];
    blue_1_Description.fontSize = 12*_screenChanger;
    blue_1_Description.text = @"Points Per Second";
    blue_1_Description.position = CGPointMake(0, 45*_screenChanger);
    [blue_1_Back addChild:blue_1_Description];
    
    
    SKLabelNode *blue_1_Cost = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
    blue_1_Cost.fontColor = [UIColor whiteColor];
    blue_1_Cost.fontSize = 12*_screenChanger;
    blue_1_Cost.name = @"blue_1_CostNode";
    NSString *blue_1_CostString = [NSString stringWithFormat:@"Cost:%@", [self convertNumberToString:[[_timeCostArray objectAtIndex:_timeCostLevel] longLongValue]]];
    blue_1_Cost.text = blue_1_CostString;
    blue_1_Cost.position = CGPointMake(0, 30*_screenChanger);
    [blue_1_Back addChild:blue_1_Cost];

    SKSpriteNode *blue_1_buyBox = [SKSpriteNode spriteNodeWithImageNamed:@"buyBox.png"];
    blue_1_buyBox.size = CGSizeMake(redBack.size.width*0.6, 30*_screenChanger);
    blue_1_buyBox.position = CGPointMake(0, -42*_screenChanger);
    [blue_1_Back addChild:blue_1_buyBox];
    
    

    
    [self addChild:_blue_1_Holder];
    /*
    _blue_1_Holder.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:blue_1_Ball.size.width/2];
    _blue_1_Holder.physicsBody.velocity = CGVectorMake(-50*_screenChanger, -80*_screenChanger);
    _blue_1_Holder.physicsBody.linearDamping = 0;
    _blue_1_Holder.physicsBody.friction = 0;
    */
    blue_1_Back.alpha = 0.0;
    [_ballHolder addObject:_blue_1_Holder];
    
    
    
    
    
    
    
    
    
    
    _blue_2_Holder = [SKNode node];
    _blue_2_Holder.position = CGPointMake(220*_screenChanger, 120*_screenChanger);
 
    SKSpriteNode *blue_2_Back = [SKSpriteNode spriteNodeWithImageNamed:@"ballBack.png"];
    blue_2_Back.size = CGSizeMake(120*_screenChanger, 140*_screenChanger);
    blue_2_Back.position = CGPointMake(0, 0);
    blue_2_Back.name = @"blue_2_BackName";
    [_blue_2_Holder addChild:blue_2_Back];
    
    SKSpriteNode *blue_2_Ball = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    blue_2_Ball.size = CGSizeMake(50*_screenChanger, 50*_screenChanger);
    blue_2_Ball.position = CGPointMake(0, 0);
    [_blue_2_Holder addChild:blue_2_Ball];
    
    NSString *bluePic_2 = [NSString stringWithFormat:@"touchPlus_%d", _timePlusCostLevel + 1];
    SKSpriteNode *blue_2_Label = [SKSpriteNode spriteNodeWithImageNamed:bluePic_2];
    blue_2_Label.name = @"blue_2_LabelNode";
    blue_2_Label.size = CGSizeMake(30*_screenChanger, 30*_screenChanger);
    blue_2_Label.position = CGPointMake(0, 0);
    [_blue_2_Holder addChild:blue_2_Label];
    
    
    SKLabelNode *blue_2_Description = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
    blue_2_Description.fontColor = [UIColor whiteColor];
    blue_2_Description.fontSize = 12*_screenChanger;
    blue_2_Description.text = @"Points Per Second";
    blue_2_Description.position = CGPointMake(0, 45*_screenChanger);
    [blue_2_Back addChild:blue_2_Description];
    
    
    SKLabelNode *blue_2_Cost = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
    blue_2_Cost.name = @"blue_2_CostNode";
    blue_2_Cost.fontColor = [UIColor whiteColor];
    blue_2_Cost.fontSize = 12*_screenChanger;
    NSString *blue_2_CostString = [NSString stringWithFormat:@"Cost:%@", [self convertNumberToString:[[_timePlusCostArray objectAtIndex:_timePlusCostLevel] longLongValue]]];
    blue_2_Cost.text = blue_2_CostString;
    blue_2_Cost.position = CGPointMake(0, 30*_screenChanger);
    [blue_2_Back addChild:blue_2_Cost];
    
    SKSpriteNode *blue_2_buyBox = [SKSpriteNode spriteNodeWithImageNamed:@"buyBox.png"];
    blue_2_buyBox.size = CGSizeMake(redBack.size.width*0.6, 30*_screenChanger);
    blue_2_buyBox.position = CGPointMake(0, -42*_screenChanger);
    [blue_2_Back addChild:blue_2_buyBox];
    

    
    
    [self addChild:_blue_2_Holder];
    /*
    _blue_2_Holder.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:blue_2_Ball.size.width/2];
    _blue_2_Holder.physicsBody.velocity = CGVectorMake(-150*_screenChanger, 100*_screenChanger);
    _blue_2_Holder.physicsBody.linearDamping = 0;
    _blue_2_Holder.physicsBody.friction = 0;
    */
    blue_2_Back.alpha = 0.0;
    [_ballHolder addObject:_blue_2_Holder];
    
    
    
    
    
    
    
    
    
    
    
    
    
    _facebook_ballHolder = [SKNode node];
    _facebook_ballHolder.position = CGPointMake(self.size.width/2 - 100*_screenChanger, 300*_screenChanger);

    SKSpriteNode *facebook_ballBack = [SKSpriteNode spriteNodeWithImageNamed:@"ballBack.png"];
    facebook_ballBack.size = CGSizeMake(120*_screenChanger, 140*_screenChanger);
    facebook_ballBack.position = CGPointMake(0, 0);
    facebook_ballBack.name = @"facebook_ballBackName";
    [_facebook_ballHolder addChild:facebook_ballBack];
    
    SKSpriteNode *facebook_ballBall = [SKSpriteNode spriteNodeWithImageNamed:@"facebook.png"];
    facebook_ballBall.size = CGSizeMake(50*_screenChanger, 50*_screenChanger);
    facebook_ballBall.position = CGPointMake(0, 0);
    [_facebook_ballHolder addChild:facebook_ballBall];
    
    /*
    SKSpriteNode *facebook_ballLabel = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(20*_screenChanger, 20*_screenChanger)];
    facebook_ballLabel.position = CGPointMake(0, 0);
    [_facebook_ballHolder addChild:facebook_ballLabel];
    */
    
    SKLabelNode *facebook_ballDescription = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
    facebook_ballDescription.fontColor = [UIColor whiteColor];
    facebook_ballDescription.fontSize = 12*_screenChanger;
    facebook_ballDescription.text = @"Double points!";
    facebook_ballDescription.position = CGPointMake(0, 45*_screenChanger);
    [facebook_ballBack addChild:facebook_ballDescription];
    
    
    SKLabelNode *facebook_ballCost = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
    facebook_ballCost.fontColor = [UIColor whiteColor];
    facebook_ballCost.fontSize = 12*_screenChanger;
    facebook_ballCost.text = @"Share on facebook";
    facebook_ballCost.position = CGPointMake(0, 30*_screenChanger);
    [facebook_ballBack addChild:facebook_ballCost];
    
    SKSpriteNode *facebook_ballbuyBox = [SKSpriteNode spriteNodeWithImageNamed:@"shareBox.png"];
    facebook_ballbuyBox.size = CGSizeMake(redBack.size.width*0.6, 30*_screenChanger);
    facebook_ballbuyBox.position = CGPointMake(0, -42*_screenChanger);
    [facebook_ballBack addChild:facebook_ballbuyBox];
    

    [self addChild:_facebook_ballHolder];
    /*
    _facebook_ballHolder.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:facebook_ballBall.size.width/2];
    _facebook_ballHolder.physicsBody.velocity = CGVectorMake(150*_screenChanger, 20*_screenChanger);
    _facebook_ballHolder.physicsBody.linearDamping = 0;
    _facebook_ballHolder.physicsBody.friction = 0;
    */
    facebook_ballBack.alpha = 0.0;
    [_ballHolder addObject:_facebook_ballHolder];
    

    
    
    
    
    
    
    
    
    
    _twitter_ballHolder = [SKNode node];
    _twitter_ballHolder.position = CGPointMake(self.size.width/2 + 100*_screenChanger, 250*_screenChanger);
 
    
    SKSpriteNode *twitter_ballBack = [SKSpriteNode spriteNodeWithImageNamed:@"ballBack.png"];
    twitter_ballBack.size = CGSizeMake(120*_screenChanger, 140*_screenChanger);
    twitter_ballBack.position = CGPointMake(0, 0);
    twitter_ballBack.name = @"twitter_ballBackName";
    [_twitter_ballHolder addChild:twitter_ballBack];
    
    
    SKSpriteNode *twitter_ballBall = [SKSpriteNode spriteNodeWithImageNamed:@"twitter.png"];
    twitter_ballBall.size = CGSizeMake(50*_screenChanger, 50*_screenChanger);
    twitter_ballBall.position = CGPointMake(0, 0);
    [_twitter_ballHolder addChild:twitter_ballBall];
    /*
    SKSpriteNode *twitter_ballLabel = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(20*_screenChanger, 20*_screenChanger)];
    twitter_ballLabel.position = CGPointMake(0, 0);
    [_twitter_ballHolder addChild:twitter_ballLabel];
    */
    SKLabelNode *twitter_ballDescription = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
    twitter_ballDescription.fontColor = [UIColor whiteColor];
    twitter_ballDescription.fontSize = 12*_screenChanger;
    twitter_ballDescription.text = @"Double points!";
    twitter_ballDescription.position = CGPointMake(0, 45*_screenChanger);
    [twitter_ballBack addChild:twitter_ballDescription];
    
    
    SKLabelNode *twitter_ballCost = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
    twitter_ballCost.fontColor = [UIColor whiteColor];
    twitter_ballCost.fontSize = 12*_screenChanger;
    twitter_ballCost.text = @"Post on twitter";
    twitter_ballCost.position = CGPointMake(0, 30*_screenChanger);
    [twitter_ballBack addChild:twitter_ballCost];
    
    SKSpriteNode *twitter_ballbuyBox = [SKSpriteNode spriteNodeWithImageNamed:@"tweetBox.png"];
    twitter_ballbuyBox.size = CGSizeMake(twitter_ballBack.size.width*0.6, 30*_screenChanger);
    twitter_ballbuyBox.position = CGPointMake(0, -42*_screenChanger);
    [twitter_ballBack addChild:twitter_ballbuyBox];
    

    
    
    [self addChild:_twitter_ballHolder];
    /*
    _twitter_ballHolder.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:twitter_ballBall.size.width/2];
    _twitter_ballHolder.physicsBody.velocity = CGVectorMake(100*_screenChanger, -120*_screenChanger);
    _twitter_ballHolder.physicsBody.linearDamping = 0;
    _twitter_ballHolder.physicsBody.friction = 0;
    */
    twitter_ballBack.alpha = 0.0;
    [_ballHolder addObject:_twitter_ballHolder];
    



    
    if(self.size.height == 568){
    _twitter_ballHolder.position = CGPointMake(self.size.width/2 + 100*_screenChanger, 250*_screenChanger);
    _facebook_ballHolder.position = CGPointMake(self.size.width/2 - 100*_screenChanger, 250*_screenChanger);
    _blue_2_Holder.position = CGPointMake(220*_screenChanger, 160*_screenChanger);
    _blue_1_Holder.position = CGPointMake(280*_screenChanger, 160*_screenChanger);
    _red_2_Holder.position = CGPointMake(220*_screenChanger, 65*_screenChanger);
    _redHolder.position = CGPointMake(280*_screenChanger, 65*_screenChanger);
    }
    else if(self.size.width == 320){
        
        _twitter_ballHolder.position = CGPointMake(self.size.width/2 + 100*_screenChanger, 205*_screenChanger);
        _facebook_ballHolder.position = CGPointMake(self.size.width/2 - 100*_screenChanger, 205*_screenChanger);
        _blue_2_Holder.position = CGPointMake(220*_screenChanger, 135*_screenChanger);
        _blue_1_Holder.position = CGPointMake(280*_screenChanger, 135*_screenChanger);
        _red_2_Holder.position = CGPointMake(220*_screenChanger, 50*_screenChanger);
        _redHolder.position = CGPointMake(280*_screenChanger, 50*_screenChanger);
        
    }
    

    
}


-(void)removeInstructions{
    _gameHasStarted = TRUE;
    
    SKSpriteNode *instructions = (SKSpriteNode *)[self childNodeWithName:@"instructionsNode"];
    SKAction *quickFade = [SKAction fadeAlphaTo:0 duration:0.1];
    
    [instructions runAction:quickFade completion:^{
        [instructions removeFromParent];
    }];
   // self.backgroundMusicPlayer.volume = 0.6;
    
    int ballSize = (50/2)*_screenChanger;
    
    for(int i = 0; i < _ballHolder.count; i++){
        
        float xVel = (arc4random()%10 - 5)*30*_screenChanger;
        if(xVel > 1000) xVel = 30*_screenChanger;
        float yVel = (arc4random()%10 - 5)*30*_screenChanger;
        if(yVel > 1000) yVel = 30*_screenChanger;

        SKNode *holderNode = [_ballHolder objectAtIndex:i];
        holderNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ballSize];
        holderNode.physicsBody.velocity = CGVectorMake(xVel, yVel);
        holderNode.physicsBody.linearDamping = 0;
        holderNode.physicsBody.friction = 0;
        
    }
    
    
}
    
-(void)checkTouchMulti{
    
    if(_touchMultiCostLevel < _touchMultiValueArray.count - 1 && _score >= [[_touchMultiCostArray objectAtIndex:_touchMultiCostLevel] longLongValue]){
    _score = _score - [[_touchMultiCostArray objectAtIndex:_touchMultiCostLevel] longLongValue];
        
    _touchMultiCostLevel = _touchMultiCostLevel + 1;
    
        [[NSUserDefaults standardUserDefaults] setInteger:_touchMultiCostLevel forKey:@"savedTouchMultiLevel"];

        
        
    SKSpriteNode *testBox = (SKSpriteNode *)[_redHolder childNodeWithName:@"redBackName"];

    SKLabelNode *testLabel = (SKLabelNode *)[testBox childNodeWithName:@"redCostNode"];
    NSLog(@"TEST LABEL RED = %d", [testLabel.text intValue]);
        NSString *testLabelString = [NSString stringWithFormat:@"Cost:%@", [self convertNumberToString:[[_touchMultiCostArray objectAtIndex:_touchMultiCostLevel] longLongValue]]];
    testLabel.text = testLabelString;
    
    NSString *redPic = [NSString stringWithFormat:@"touchMulti_%d", _touchMultiCostLevel + 1];
        
    SKSpriteNode *redLabel = (SKSpriteNode *)[_redHolder childNodeWithName:@"redLabelNode"];
    [redLabel setTexture:[SKTexture textureWithImage:[UIImage imageNamed:redPic]]];
        [self runAction:[SKAction playSoundFileNamed:@"purchaseCompleted.wav" waitForCompletion:NO]];

    }
    
    
}


-(void)checkTouchPlus{
    
    if(_touchPlusCostLevel < _touchPlusValueArray.count - 1 && _score >= [[_touchPlusCostArray objectAtIndex:_touchPlusCostLevel] longLongValue]){
        _score = _score - [[_touchPlusCostArray objectAtIndex:_touchPlusCostLevel] longLongValue];
        _touchPlusCostLevel = _touchPlusCostLevel + 1;
        
        [[NSUserDefaults standardUserDefaults] setInteger:_touchPlusCostLevel forKey:@"savedTouchPlusLevel"];
        
        
        SKSpriteNode *testBox = (SKSpriteNode *)[_red_2_Holder childNodeWithName:@"red_2_BackName"];
        
        SKLabelNode *testLabel = (SKLabelNode *)[testBox childNodeWithName:@"red_2_CostNode"];
        NSLog(@"TEST LABEL RED = %d", [testLabel.text intValue]);
                NSString *testLabelString = [NSString stringWithFormat:@"Cost:%@", [self convertNumberToString:[[_touchPlusCostArray objectAtIndex:_touchPlusCostLevel] longLongValue]]];
        testLabel.text = testLabelString;
        
        
        NSString *redPic = [NSString stringWithFormat:@"touchPlus_%d", _touchPlusCostLevel + 1];
        SKSpriteNode *redLabel = (SKSpriteNode *)[_red_2_Holder childNodeWithName:@"red_2_LabelNode"];
        [redLabel setTexture:[SKTexture textureWithImage:[UIImage imageNamed:redPic]]];
        [self runAction:[SKAction playSoundFileNamed:@"purchaseCompleted.wav" waitForCompletion:NO]];

    }
    
    
}


-(void)checkTimeMulti{
    
    if(_timeCostLevel < _timeValueArray.count - 1 && _score >= [[_timeCostArray objectAtIndex:_timeCostLevel] longLongValue]){
        _score = _score - [[_timeCostArray objectAtIndex:_timeCostLevel] longLongValue];
        _timeCostLevel = _timeCostLevel + 1;
        
        [[NSUserDefaults standardUserDefaults] setInteger:_timeCostLevel forKey:@"savedTimeMultiLevel"];
        
        
        SKSpriteNode *testBox = (SKSpriteNode *)[_blue_1_Holder childNodeWithName:@"blue_1_BackName"];
        
        SKLabelNode *testLabel = (SKLabelNode *)[testBox childNodeWithName:@"blue_1_CostNode"];
        NSLog(@"TEST LABEL RED = %d", [testLabel.text intValue]);
        NSString *testLabelString = [NSString stringWithFormat:@"Cost:%@", [self convertNumberToString:[[_timeCostArray objectAtIndex:_timeCostLevel] longLongValue]]];
        testLabel.text = testLabelString;
        
        
        NSString *redPic = [NSString stringWithFormat:@"timeMulti_%d", _timeCostLevel + 1];
        SKSpriteNode *redLabel = (SKSpriteNode *)[_blue_1_Holder childNodeWithName:@"blue_1_LabelNode"];
        [redLabel setTexture:[SKTexture textureWithImage:[UIImage imageNamed:redPic]]];
        [self runAction:[SKAction playSoundFileNamed:@"purchaseCompleted.wav" waitForCompletion:NO]];

    }
    
    
}

-(void)checkTimePlus{
    
    if(_timePlusCostLevel < _timePlusValueArray.count - 1 && _score >= [[_timePlusCostArray objectAtIndex:_timePlusCostLevel] longLongValue]){
        _score = _score - [[_timePlusCostArray objectAtIndex:_timePlusCostLevel] longLongValue];
        _timePlusCostLevel = _timePlusCostLevel + 1;
        
        
        [[NSUserDefaults standardUserDefaults] setInteger:_timePlusCostLevel forKey:@"savedTimePlusLevel"];

        
        
        
        SKSpriteNode *testBox = (SKSpriteNode *)[_blue_2_Holder childNodeWithName:@"blue_2_BackName"];
        
        SKLabelNode *testLabel = (SKLabelNode *)[testBox childNodeWithName:@"blue_2_CostNode"];
     //   NSLog(@"TEST LABEL RED = %d", [testLabel.text intValue]);
                NSString *testLabelString = [NSString stringWithFormat:@"Cost:%@", [self convertNumberToString:[[_timePlusCostArray objectAtIndex:_timePlusCostLevel] longLongValue]]];
        testLabel.text = testLabelString;
        
        
        NSString *redPic = [NSString stringWithFormat:@"touchPlus_%d", _timePlusCostLevel + 1];
        SKSpriteNode *redLabel = (SKSpriteNode *)[_blue_2_Holder childNodeWithName:@"blue_2_LabelNode"];
        [redLabel setTexture:[SKTexture textureWithImage:[UIImage imageNamed:redPic]]];
        [self runAction:[SKAction playSoundFileNamed:@"purchaseCompleted.wav" waitForCompletion:NO]];

    }
    
    
}


-(void)checkFacebook{
    [self facebook];
    [self runAction:[SKAction playSoundFileNamed:@"purchaseCompleted.wav" waitForCompletion:NO]];

    
}

-(void)checkTwitter{
    [self twitter];
    [self runAction:[SKAction playSoundFileNamed:@"purchaseCompleted.wav" waitForCompletion:NO]];

}



-(void)checkRevmob{
    
    _numberOfClicksSinceAd = _numberOfClicksSinceAd + 1;
    if(_numberOfClicksSinceAd >= 750){
        _numberOfClicksSinceAd = 0;
        [self revmob];
    }
}










-(void)revmob{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        //    [_gameOverOverlay removeFromParent];
        //    [self setupGame];
        
    } else {
        NSLog(@"There IS internet connection");
        
        
        RevMobFullscreen *ad = [[RevMobAds session] fullscreen]; // you must retain this object
        [ad loadWithSuccessHandler:^(RevMobFullscreen *fs) {
            [fs showAd];
            NSLog(@"Ad loaded");
            //   [self doVolumeFadeOut:_themePlayer];
            
        } andLoadFailHandler:^(RevMobFullscreen *fs, NSError *error) {
            NSLog(@"Ad error: %@",error);
            [adMobinterstitial_ loadRequest:request];
            
        } onClickHandler:^{
            NSLog(@"Ad clicked");
        } onCloseHandler:^{
            NSLog(@"Ad closed");
            //   [_gameOverOverlay removeFromParent];
            //   [self setupGame];
        }];
        
        
        //    [[RevMobAds session] showFullscreen];
        
        
    }
    
}


//Google admob


- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    
    
    
    [adMobinterstitial_ presentFromRootViewController:self.view.window.rootViewController];
    
    
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad{
    
    //  [_gameOverOverlay removeFromParent];
    //  [self setupGame];
    
    
    
}


-(void)interstitialWillPresentScreen:(GADInterstitial *)ad{
    
    
}
-(void)interstitialWillDismissScreen:(GADInterstitial *)ad{
    
}

-(void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{
    
    //  [self interstitialDidDismissScreen:ad];
}







-(void)facebook{
    /*
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker set:kGAIScreenName value:@"Endgame Screen"];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                          action:@"touch"
                                                           label:@"facebook"
                                                           value:nil] build]];
    [tracker set:kGAIScreenName value:nil];
    */
    
    NSLog(@"SHOW FACEBOOK");
    // Check if the Facebook app is installed and we can present the share dialog
    FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    params.picture = [NSURL URLWithString:@"http://www.imgur.com/J0vn5uK.png"];
    params.link = [NSURL URLWithString:@"https://itunes.apple.com/us/app/sqaures/id886925392?ls=1&mt=8"];
    params.caption = @"From Rowdy Panda Games";
    NSString *descriptString = [NSString stringWithFormat:@"Download Points! - Hours of Mindless Fun"];
    params.linkDescription = descriptString;
    params.name = @"Points!";
    
    NSURL *appUrl = [NSURL URLWithString:@"https://itunes.apple.com/us/app/sqaures/id886925392?ls=1&mt=8"];
    NSURL *picUrl = [NSURL URLWithString:@"http://www.imgur.com/J0vn5uK.png"];
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        // Present share dialog
        
        //    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
        /*
         [FBDialogs presentShareDialogWithLink:appUrl
         handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
         if(error) {
         // An error occurred, we need to handle the error
         // See: https://developers.facebook.com/docs/ios/errors
         NSLog(@"Error publishing story: %@", error.description);
         } else {
         // Success
         NSLog(@"result %@", results);
         }
         }];
         */
        NSDictionary *clientState = [NSDictionary dictionary];
        [FBDialogs presentShareDialogWithLink:appUrl name:params.name caption:params.caption description:descriptString picture:picUrl clientState:clientState handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
            if(error) {
                // An error occurred, we need to handle the error
                // See: https://developers.facebook.com/docs/ios/errors
                NSLog(@"Error publishing story: %@", error.description);
            } else {
                // Success
             //   if([self checkShareDate] == TRUE)[self increasePointMultipler];
                [self doublePoints];
                NSLog(@"result %@", results);
            }
        }];
        
        
        
    } else {
        
        // Present the feed dialog
        
        // Put together the dialog parameters
        NSString *descriptString = [NSString stringWithFormat:@"Get sqaures - the minimalist new hit!"];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Sqaures", @"name",
                                       @"From Rowdy Panda Games", @"caption",
                                       descriptString, @"description",
                                       @"https://itunes.apple.com/us/app/sqaures/id886925392?ls=1&mt=8", @"link",
                                       @"http://imgur.com/J0vn5uK", @"picture",
                                       nil];
        
        // Show the feed dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:params
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // An error occurred, we need to handle the error
                                                          // See: https://developers.facebook.com/docs/ios/errors
                                                          NSLog(@"Error publishing story: %@", error.description);
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              // User cancelled.
                                                              NSLog(@"User cancelled.");
                                                          } else {
                                                              // Handle the publish feed callback
                                                              NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                              
                                                              if (![urlParams valueForKey:@"post_id"]) {
                                                                  // User cancelled.
                                                                  NSLog(@"User cancelled.");
                                                                  
                                                              } else {
                                                                  // User clicked the Share button
                                                               //   if([self checkShareDate] == TRUE)[self increasePointMultipler];
                                                                  [self doublePoints];
                                                                  
                                                                  NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                  NSLog(@"result %@", result);
                                                              }
                                                          }
                                                      }
                                                  }];
        
        
    }
    
    
}

// A function for parsing URL parameters returned by the Feed Dialog.
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}




-(void)twitter{
    /*
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker set:kGAIScreenName value:@"Endgame Screen"];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                          action:@"touch"
                                                           label:@"twitter"
                                                           value:nil] build]];
    [tracker set:kGAIScreenName value:nil];
    
    */
    //  Create an instance of the Tweet Sheet
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:
                                           SLServiceTypeTwitter];
    
    // Sets the completion handler.  Note that we don't know which thread the
    // block will be called on, so we need to ensure that any required UI
    // updates occur on the main queue
    tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
        switch(result) {
                //  This means the user cancelled without sending the Tweet
            case SLComposeViewControllerResultCancelled:
                break;
                //  This means the user hit 'Send'
            case SLComposeViewControllerResultDone:
               // if([self checkShareDate] == TRUE)[self increasePointMultipler];
                [self doublePoints];
                break;
        }
    };
    
    //  Set the initial body of the Tweet
    int score = 10;
    NSString *initialTextString = [NSString stringWithFormat:@"I juust scored %@ in points; presented by @TheRowdyPanda", [self convertNumberToString:_score]];
    [tweetSheet setInitialText:initialTextString];
    
    //  Add an URL to the Tweet.  You can add multiple URLs.
    if (![tweetSheet addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/sqaures/id886925392?ls=1&mt=8"]]){
        NSLog(@"Unable to add the URL!");
    }
    
    //  Adds an image to the Tweet.  For demo purposes, assume we have an
    //  image named 'larry.png' that we wish to attach
    if (![tweetSheet addImage:[UIImage imageNamed:@"Icon.png"]]) {
        NSLog(@"Unable to add the image!");
    }
    
    
    
    //  Presents the Tweet Sheet to the user
    UIViewController *vc = self.view.window.rootViewController;
    
    [vc presentViewController:tweetSheet animated:NO completion:^{
        NSLog(@"Tweet sheet has been presented.");
    }];
    
}



-(void)doublePoints{
    
    [self updatePointLabel:_score];
}
















-(void)updatePointLabel:(unsigned long long)num{
    
    
    if(_score >= 5*pow(10, 11)){
        
        SKNode *testHolder = [self childNodeWithName:@"winGameHolder"];
        
        //  int previousNum = 0;
        if(testHolder == nil){
            
        }
        else{
            //        SKShapeNode *testShape = (SKShapeNode *)[testHolder childNodeWithName:@"pointBoxNode"];
            //        SKLabelNode *testLabel = (SKLabelNode *)[testShape childNodeWithName:@"pointLabelNode"];
            //        previousNum = [testLabel.text intValue];
            [testHolder removeFromParent];
        }
        
        
        SKNode *holder = [SKNode node];
        holder.name = @"winGameHolder";
        [self addChild:holder];
        holder.zPosition = 100;
        
        
        SKSpriteNode* backgroundImage;
        
        if(self.size.width > 320){
            backgroundImage = [SKSpriteNode spriteNodeWithImageNamed:@"winGame_75.png"];

        }
        if(self.size.width == 320 && self.size.height == 568){
            backgroundImage = [SKSpriteNode spriteNodeWithImageNamed:@"winGame_56.png"];

        }
        if(self.size.width == 320 && self.size.height == 480){
            backgroundImage = [SKSpriteNode spriteNodeWithImageNamed:@"winGame_66.png"];
        }
        backgroundImage = [SKSpriteNode spriteNodeWithImageNamed:@"winGame_75.png"];

        backgroundImage.size = self.size;
        [backgroundImage setPosition:CGPointMake(self.size.width/2, self.size.height/2)];

        backgroundImage.name = @"backgroundImageNode";

        backgroundImage.alpha = 0.6;
        
        [holder addChild:backgroundImage];
        
    
    }
    [self changeHue];
    int addScreenHeight = 0;
    if(self.size.height == 568) addScreenHeight = 75;
    else if(self.size.width == 320) addScreenHeight = 0;
    int cornerSize = 15*_screenChanger;
    
    _score = _score + num;
    
  //  [[NSUserDefaults standardUserDefaults] setInteger:_score forKey:@"savedScore"];

        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithUnsignedLongLong:_score] forKey:@"savedScore"];
   // NSLog(@"Formatted float: %@ ", [formatter stringFromNumber:number]);
    
    SKNode *testHolder = [self childNodeWithName:@"pointLabelHolder"];
    
  //  int previousNum = 0;
    if(testHolder == nil){
        
    }
    else{
//        SKShapeNode *testShape = (SKShapeNode *)[testHolder childNodeWithName:@"pointBoxNode"];
//        SKLabelNode *testLabel = (SKLabelNode *)[testShape childNodeWithName:@"pointLabelNode"];
//        previousNum = [testLabel.text intValue];
        [testHolder removeFromParent];
    }
    
    //previousNum = previousNum + num;
   // previousNum = arc4random()%10;
    
    NSNumber *number = [NSNumber numberWithUnsignedLongLong:_score];
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    
    SKNode *holder = [SKNode node];
    holder.name = @"pointLabelHolder";
    [self addChild:holder];
    holder.zPosition = 100;
    
    
    SKShapeNode* pointBox = [SKShapeNode node];
    CGPathRef pointBoxPath = CGPathCreateWithRoundedRect(CGRectMake(-cornerSize, -cornerSize, 200*_screenChanger, 80*_screenChanger), 4*_screenChanger, 4*_screenChanger, nil);
    [pointBox setPath:pointBoxPath];
    pointBox.name = @"pointBoxNode";
    pointBox.strokeColor = pointBox.fillColor = [UIColor grayColor];
    pointBox.position = CGPointMake(self.size.width/2 - pointBox.frame.size.width/2 + cornerSize, (400*_screenChanger + addScreenHeight));
    pointBox.alpha = 0.6;
    
    [holder addChild:pointBox];
    CGPathRelease(pointBoxPath);
    
    SKLabelNode *pointText = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
    pointText.text = @"POINTS!";
    pointText.fontColor = [UIColor whiteColor];
    pointText.fontSize = 20*_screenChanger;
    pointText.position = CGPointMake(pointBox.frame.size.width/2 - cornerSize, 20*_screenChanger);
    [pointBox addChild:pointText];
    
    
    SKLabelNode *pointLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
    pointLabel.text = [formatter stringFromNumber:number];
    pointLabel.name = @"pointLabelNode";
    pointLabel.fontColor = [UIColor whiteColor];
    pointLabel.fontSize = 20*_screenChanger;
    pointLabel.position = CGPointMake(pointBox.frame.size.width/2 - cornerSize, pointText.position.y - 20*_screenChanger);
    [pointBox addChild:pointLabel];
}


-(NSString *)convertNumberToString:(long long)num{
    
    double numDub;
    NSString *string;// = [NSString stringWithFormat:@"Cost:%d", num];
    if(num < 1000){
        string = [NSString stringWithFormat:@"%lld", num];
    }
    else if (num < pow(10, 6)){
        numDub = num/pow(10, 3);
        string = [NSString stringWithFormat:@"%.1f K",numDub];
    }
    else if (num < pow(10, 9)){
        numDub = num/pow(10, 6);
        string = [NSString stringWithFormat:@"%.1f M",numDub];
        
    }
    else if (num < pow(10, 12)){
        numDub = num/pow(10, 9);
        string = [NSString stringWithFormat:@"%.1f B",numDub];
    }
    else if (num < pow(10, 15)){
        numDub = num/pow(10, 12);
        string = [NSString stringWithFormat:@"%.1f KB",numDub];
    }
    else if (num < pow(10, 18)){
        numDub = num/pow(10, 15);
        string = [NSString stringWithFormat:@"%.1f MB",numDub];
    }
    else if (num < pow(10, 21)){
        numDub = num/pow(10, 18);
        string = [NSString stringWithFormat:@"%.1f BB",numDub];
    }
    if(num == 0) string = [NSString stringWithFormat:@"n/a"];
    
    return string;
    
    
}


-(void)addParticlesTouchwithPosition:(CGPoint)pos{
    
    if(_isClicking == false){
    
        _isClicking = true;
    [self checkRevmob];
    int multiNum = [[_touchMultiValueArray objectAtIndex:_touchMultiCostLevel] intValue];
    SKEmitterNode *test = [self addTouchEmitter];
    test.particleBirthRate = multiNum;
    test.position = pos;
    [self addChild:test];
    
    
    int num = ([[_touchPlusValueArray objectAtIndex:_touchPlusCostLevel] intValue]*multiNum);
    [self updatePointLabel:num];
    
    [self sayPoints];
    
    /*
    if(_isClicking == false){
        _isClicking = true;
    [self checkRevmob];
    int multiNum = [[_touchMultiValueArray objectAtIndex:_touchMultiCostLevel] intValue];
    for (int i = 0; i <multiNum ; i++) {
        NSString *picName = [NSString stringWithFormat:@"touchPlus_%d", _touchPlusCostLevel];
        
        SKSpriteNode *pointSprite = [SKSpriteNode spriteNodeWithImageNamed:picName];
        
        pointSprite.size = CGSizeMake(30*_screenChanger, 30*_screenChanger);
        
        pointSprite.position = pos;
        int xVel = (arc4random()%30 - 15)*8;
        int yVel = (arc4random()%30 - 15)*8;
        if(xVel == 0)xVel = 10;
        if(yVel == 0)yVel = 10;
        
        int xRandomization = arc4random()%20 - 10;
        int yRandomization = arc4random()%20 - 10;

        double duration = 0.15;
        double duration2 = 0.4;
        SKAction *moveOut = [SKAction moveBy:CGVectorMake(xVel*_screenChanger, yVel*_screenChanger) duration:duration];
        SKAction *moveToCenter = [SKAction moveTo:CGPointMake(self.size.width/2 + xRandomization*_screenChanger, self.size.height/2 + yRandomization*_screenChanger) duration:duration2];
     //   SKAction *sequence = [SKAction sequence:@[moveOut, moveToCenter]];
        
        [self addChild:pointSprite];

        [pointSprite runAction:moveOut completion:^{
            _isClicking = false;
            [pointSprite runAction:moveToCenter completion:^{
                
                int num = [[_touchPlusValueArray objectAtIndex:_touchPlusCostLevel] intValue];
                [self updatePointLabel:num];
                [pointSprite removeFromParent];
            }];
        }];
    }
        [self sayPoints];
    }
     */
        double duration = 0.3;
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (duration) * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
          ///  [self dismissNode:emitterSprite];
            _isClicking = false;
            
        });
    }
}






-(void)addParticlesTimewithPosition:(CGPoint)pos{
    
    [self checkRevmob];
    int multiNum = [[_timeValueArray objectAtIndex:_timeCostLevel] intValue];
    SKEmitterNode *test = [self addTimeEmitter];
    test.particleBirthRate = multiNum;
    test.position = pos;
    [self addChild:test];
    
    
    int num = ([[_timePlusValueArray objectAtIndex:_timePlusCostLevel] intValue]*multiNum);
    [self updatePointLabel:num];
    
    [self sayPoints];
}


-(SKEmitterNode *)addTouchEmitter{
    
    
    SKEmitterNode *emitterSprite = [[SKEmitterNode alloc] init];
    
	emitterSprite.name = @"coin_cell";
    NSString *picName = [NSString stringWithFormat:@"touchPlus_%d", _touchPlusCostLevel];
    
    emitterSprite.particleTexture = [SKTexture textureWithImage:[UIImage imageNamed:picName]];
    //emitterSprite = CGRectMake(100, 100, 100, 100);
    //emitterSprite.enabled = YES;
    
    //	emitterSprite.contents = (id)[[UIImage imageNamed:@"coin.png"] CGImage];
    //	emitterSprite.contentsRect = CGRectMake(0.00, 0.00, 1.00, 1.00);
    
	//emitterSprite.magnificationFilter = kCAFilterLinear;
	//emitterSprite.minificationFilter = kCAFilterLinear;
	//emitterSprite.minificationFilterBias = 0.00;
    
	emitterSprite.particleScale = 0.30;
	emitterSprite.particleScaleRange = 0.00;
	emitterSprite.particleScaleSpeed = 0.02;
    
	//emitterSprite.particleColor = (__bridge UIColor *)([[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00] CGColor]);
	emitterSprite.particleColorRedRange = 0.00;
	emitterSprite.particleColorGreenRange = 0.00;
	emitterSprite.particleColorBlueRange = 0.00;
	emitterSprite.particleColorAlphaRange = 0.00;
    
	emitterSprite.particleColorRedSpeed = 0.00;
	emitterSprite.particleColorBlueSpeed = 0.00;
	emitterSprite.particleColorGreenSpeed = 0.00;
	emitterSprite.particleColorAlphaSpeed = -0.2;
    
	emitterSprite.particleLifetime = 10.00;
	emitterSprite.particleLifetimeRange = 0.00;
	emitterSprite.particleBirthRate = 10;
	emitterSprite.particleSpeed = 0.00;
	emitterSprite.particleSpeedRange = 150.00;
	emitterSprite.xAcceleration = 0.00;
	emitterSprite.yAcceleration = 250.00;
	//emitterSprite.zAcceleration = 0.00;
    
	// these values are in radians, in the UI they are in degrees
	emitterSprite.particleRotation = 0.00;
	emitterSprite.particleRotationRange = 0.000;
	//emitterSprite.emissionLatitude = 0.000;
	//emitterSprite.emissionLongitude = 0.000;
	//emitterSprite.emissionAngle = 2.000;
    emitterSprite.emissionAngleRange = 360;
    //emitterSprite.emi
    
    /*
     emitterSprite.position = CGPointMake(_pandaSpriteHolder.position.x + self.size.width/2, _pandaSpriteHolder.position.y + 1*self.size.height/2);
     emitterSprite.zPosition = _pandaSpriteHolder.zPosition - 1;
     // [self addChild:emitterSprite];
     
     */
    
    
    double duration = 0.9;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (duration) * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self dismissNode:emitterSprite];
        
    });
    
    return emitterSprite;

    
}

-(SKEmitterNode *)addTimeEmitter{
    SKEmitterNode *emitterSprite = [[SKEmitterNode alloc] init];
    
	emitterSprite.name = @"coin_cell";
    NSString *picName = [NSString stringWithFormat:@"touchPlus_%d", _timePlusCostLevel];

    emitterSprite.particleTexture = [SKTexture textureWithImage:[UIImage imageNamed:picName]];
    //emitterSprite = CGRectMake(100, 100, 100, 100);
    //emitterSprite.enabled = YES;
    
    //	emitterSprite.contents = (id)[[UIImage imageNamed:@"coin.png"] CGImage];
    //	emitterSprite.contentsRect = CGRectMake(0.00, 0.00, 1.00, 1.00);
    
	//emitterSprite.magnificationFilter = kCAFilterLinear;
	//emitterSprite.minificationFilter = kCAFilterLinear;
	//emitterSprite.minificationFilterBias = 0.00;
    
	emitterSprite.particleScale = 0.30;
	emitterSprite.particleScaleRange = 0.00;
	emitterSprite.particleScaleSpeed = 0.02;
    
	//emitterSprite.particleColor = (__bridge UIColor *)([[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00] CGColor]);
	emitterSprite.particleColorRedRange = 0.00;
	emitterSprite.particleColorGreenRange = 0.00;
	emitterSprite.particleColorBlueRange = 0.00;
	emitterSprite.particleColorAlphaRange = 0.00;
    
	emitterSprite.particleColorRedSpeed = 0.00;
	emitterSprite.particleColorBlueSpeed = 0.00;
	emitterSprite.particleColorGreenSpeed = 0.00;
	emitterSprite.particleColorAlphaSpeed = -1.0;
    
	emitterSprite.particleLifetime = 5.00;
	emitterSprite.particleLifetimeRange = 0.00;
	emitterSprite.particleBirthRate = 10;
	emitterSprite.particleSpeed = 0.00;
	emitterSprite.particleSpeedRange = 250.00;
	emitterSprite.xAcceleration = 0.00;
	emitterSprite.yAcceleration = 0.00;
	//emitterSprite.zAcceleration = 0.00;
    
	// these values are in radians, in the UI they are in degrees
	emitterSprite.particleRotation = 0.00;
	emitterSprite.particleRotationRange = 0.000;
	//emitterSprite.emissionLatitude = 0.000;
	//emitterSprite.emissionLongitude = 0.000;
	//emitterSprite.emissionAngle = 2.000;
    emitterSprite.emissionAngleRange = 360;
    //emitterSprite.emi
    
    /*
    emitterSprite.position = CGPointMake(_pandaSpriteHolder.position.x + self.size.width/2, _pandaSpriteHolder.position.y + 1*self.size.height/2);
    emitterSprite.zPosition = _pandaSpriteHolder.zPosition - 1;
    // [self addChild:emitterSprite];
    
    */
    
    
    double duration = 1.0;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (duration) * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self dismissNode:emitterSprite];
        
    });
    
    return emitterSprite;
    
}



-(void)dismissNode:(SKNode *)node{
    
    double duration = 0.4;
    SKAction *fadeAction = [SKAction fadeAlphaTo:0 duration:duration];
    
    [node runAction:fadeAction completion:^{
        [node removeFromParent];
        
    }];
}



-(void)changeHue{
    
    double changer = 0.001*(11 - 10/(pow(_score, .08)));
    _hueValue = _hueValue + changer;
    NSString *showString = [NSString stringWithFormat:@"Hue Value %f", changer];
    NSLog(showString);
    if(_hueValue >= 1)_hueValue = 0;
    
    double duration = 0.1;
    self.backgroundColor = [UIColor colorWithHue:(_hueValue - 0.001) saturation:1.0 brightness:1.0 alpha:1.0];

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    self.backgroundColor = [UIColor colorWithHue:(_hueValue) saturation:1.0 brightness:1.0 alpha:1.0];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        NSLog(@"SHAKE IT BABY");
        
        for (int i = 0; i < _ballHolder.count; i++) {
            int xRand = (arc4random()%8-4)*30;
            if(xRand == 0) xRand = 30;
            int yRand = (arc4random()%8-4)*30;
            if(yRand == 0) yRand = 30;
            
            SKNode *testNode = [_ballHolder objectAtIndex:i];
            testNode.physicsBody.velocity = CGVectorMake(xRand, yRand);
        }
    }
}


-(void)sayPoints{
    
    int rand0 = arc4random()%3;
    
    if(rand0 == 1){
    int numOfSounds = 5;
    int i = arc4random()%numOfSounds + 1;
    NSString *soundName = [NSString stringWithFormat:@"points_%d.wav", i];
    [self runAction:[SKAction playSoundFileNamed:soundName waitForCompletion:NO]];

    }
    
}


//sets events to happen at a given time interval
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    
    self.lastBoundaryCheckTimeInterval += timeSinceLast;
    self.lastTimePointTimeInterval += timeSinceLast;

    NSLog(@"Time SInce Last %f", timeSinceLast);
    if(self.lastTimePointTimeInterval >= 1.0){
        self.lastTimePointTimeInterval = 0.0;

        int xPos = arc4random()%300 + 20;
        int yPos = arc4random()%500 + 20;
        //[self addParticlesWithValue:1 multiplyer:2 position:CGPointMake(xPos*_screenChanger, yPos*_screenChanger)];
        
        [self addParticlesTimewithPosition:CGPointMake(xPos*_screenChanger, yPos*_screenChanger)];
        
    }
    
    if(self.lastBoundaryCheckTimeInterval >= 0.1){//checks 10 times per second
        self.lastBoundaryCheckTimeInterval = 0.0;
        
        int difference = 40*_screenChanger;

        for (int i = 0; i < _ballHolder.count; i++) {
            SKNode *testNode = [_ballHolder objectAtIndex:i];
            
            
            int xPosRed = testNode.position.x;
            int yPosRed = testNode.position.y;
            double velocityX = testNode.physicsBody.velocity.dx;
            double velocityY = testNode.physicsBody.velocity.dy;
            
            if(xPosRed <= (0 + difference) && velocityX < 0){
                [self runAction:[SKAction playSoundFileNamed:@"ballHitWall2.wav" waitForCompletion:NO]];
                [testNode.physicsBody setVelocity:CGVectorMake(-1*testNode.physicsBody.velocity.dx, testNode.physicsBody.velocity.dy)];
            }
            if(xPosRed >= (self.size.width - difference) && velocityX > 0){
                [self runAction:[SKAction playSoundFileNamed:@"ballHitWall2.wav" waitForCompletion:NO]];
                [testNode.physicsBody setVelocity:CGVectorMake(-1*testNode.physicsBody.velocity.dx, testNode.physicsBody.velocity.dy)];
                
            }
            
            if(yPosRed <= (0 + difference) && velocityY < 0){
                [self runAction:[SKAction playSoundFileNamed:@"ballHitWall2.wav" waitForCompletion:NO]];
                [testNode.physicsBody setVelocity:CGVectorMake(testNode.physicsBody.velocity.dx, -1*testNode.physicsBody.velocity.dy)];
            }
            if(yPosRed >= ((self.size.height - 90*_screenChanger) - difference) && velocityY > 0){
                   [self runAction:[SKAction playSoundFileNamed:@"ballHitWall2.wav" waitForCompletion:NO]];
                [testNode.physicsBody setVelocity:CGVectorMake(testNode.physicsBody.velocity.dx, -1*testNode.physicsBody.velocity.dy)];
                
            }
            
            
        }
        
    }
    
    
}



-(void)update:(NSTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    
    if (_gameHasStarted == true) {
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    }
   
    
/*
    
    int num = arc4random()%60;
    
    if(num == 1){

    }
    
    
*/
    //
    //
    
}

@end
