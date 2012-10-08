//
//  TimeWindow.h
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Utils.h"
#import "ClimberManager.h"
#import "Timer.h"
#import "Utils.h"

@interface TimeWindow : CCLayer
{
    int value;
    Utils *utils;
    ClimberManager *climberManager;
    Timer *timer;
    
    CCSpriteBatchNode *timeBatch;
    CCSprite *timeWindow;
}

-(void)calculate;

@end
