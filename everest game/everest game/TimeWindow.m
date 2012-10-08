//
//  TimeWindow.m
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TimeWindow.h"

@interface TimeWindow (PrivateMethods)
-(void)display;
-(void)setup;
@end;

@implementation TimeWindow

static TimeWindow* classInstance;

-(id)init
{
    if(self = [super init])
    {
        classInstance = self;
        
        [self setup];
        [self display];
    }
    
    return self;
}

-(void)setup
{
    utils = [Utils current];
    climberManager = [ClimberManager current];
    timer = [Timer current];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"timewindow.plist"];
    timeBatch = [CCSpriteBatchNode batchNodeWithFile:@"boxes.png"];
}

-(void)display
{
    timeWindow = [CCSprite spriteWithSpriteFrameName:@"timewindow20.png"];
    timeWindow.position = [utils relativePointByCoordinates:926 ypos:685];
    [self addChild:timeWindow];
}

-(void)calculate
{
    //Formula: 30-3-(amount of days)-1/(condition highest positioned climber)= time window
}

+(TimeWindow*) current
{
    if (classInstance == nil)
    {
        classInstance = [[TimeWindow alloc] init];
    }
    
    return classInstance;
}

@end
