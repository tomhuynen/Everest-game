//
//  HelloWorldLayer.m
//  everest game
//
//  Created by Tom Huynen on 9/21/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "GameScene.h"

@interface GameScene (PrivateMethods)
-(void) display;
@end

// HelloWorldLayer implementation
@implementation GameScene

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init])) {
		
        utils = [Utils node];
       // [director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
        [self display];
        
	}
    
	return self;
}

-(void) display
{
    background = [Background node];
    routes = [Routes node];
    campManager = [CampManager node];
    climberManager = [ClimberManager node];
    score = [Score node];
    timeWindow = [TimeWindow node];
    foreCast = [ForeCast node];
    timer = [Timer node];
    materialChoice = [MaterialChoice node];
    events = [Events node];
    
    [self addChild:background];
    [self addChild:routes];
    [self addChild:campManager];
    [self addChild:climberManager];
    [self addChild:score];
    [self addChild:timeWindow];
    [self addChild:foreCast];
    [self addChild:timer];
    [self addChild:materialChoice];
    [self addChild:events];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
