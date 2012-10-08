//
//  Background.m
//  everest game
//
//  Created by Tom Huynen on 9/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Background.h"
#import "Utils.h"

@interface Background (PrivateMethods)
-(void) display;
-(void) setup;
@end


@implementation Background


-(id) init
{
	if( (self=[super init])) {
		
        utils = [Utils current];
        
        [self setup];
        [self display];
        [self scheduleUpdate];
	}
	return self;
}

-(void)setup
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"weather-background.plist"];
    batchBackground = [CCSpriteBatchNode batchNodeWithFile:@"weather-background.png"];
    
    maxLeftPos = -[utils relativeDistance:1400 horizontal:YES];
}

-(void)display
{
    bgHolder = [CCSprite node];
    fgHolder = [CCSprite node];
    bgDay = [CCSprite spriteWithFile:@"good-weather.png"];
    bgNight = [CCSprite spriteWithFile:@"night-weather.png"];
    
    bgDay.anchorPoint = ccp(0, 0);
    bgNight.anchorPoint = ccp(0, 0);
    bgNight.opacity = 0;
    
    CCSprite *test1 = [CCSprite spriteWithSpriteFrameName:@"good-weather.jpg"];
    test1.anchorPoint = ccp(0, 1);
    test1.position = ccp(0, 0);
    [bgHolder addChild:test1];
    
    CCSprite *test2 = [CCSprite spriteWithSpriteFrameName:@"good-weather.jpg"];
    test2.anchorPoint = ccp(0, 1);
    test2.position = ccp([utils relativeDistance:1400 horizontal:YES], 0);
    [bgHolder addChild:test2];
    
    bgHolder.position = ccp(0, [utils relativeDistance:768 horizontal:NO]);
    
    nightFade = [CCSprite spriteWithFile:@"fade.jpg"];
    nightFade.anchorPoint = ccp(0, 0);
    nightFade.opacity = 30;
    
    [fgHolder addChild: bgDay];
    [fgHolder addChild: bgNight];
    [self addChild:bgHolder];
    [self addChild:fgHolder];
    [self addChild:nightFade];
}

-(void) update:(ccTime)delta
{
    float xPos = bgHolder.position.x;
    float yPos = bgHolder.position.y;
    
    xPos -= 1;
    
    if(xPos <= maxLeftPos)
    {
        xPos = 0;
    }
    
    bgHolder.position = ccp(xPos, yPos);
}

-(void)updateTime:(int)time
{

}

-(void)updateTurn:(int)turn
{

}

@end
