//
//  HelloWorldLayer.h
//  everest game
//
//  Created by Tom Huynen on 9/21/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Background.h"
#import "Routes.h"
#import "Utils.h"
#import "CampManager.h"
#import "ClimberManager.h"
#import "Score.h"
#import "TimeWindow.h"
#import "ForeCast.h"
#import "Timer.h"
#import "MaterialChoice.h"
#import "Events.h"

// HelloWorldLayer
@interface GameScene : CCLayer
{
    
    Utils *utils;
    Background *background;
    Routes *routes;
    CampManager *campManager;
    ClimberManager *climberManager;
    Score *score;
    TimeWindow *timeWindow;
    ForeCast *foreCast;
    Timer *timer;
    MaterialChoice *materialChoice;
    Events *events;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
