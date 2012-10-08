//
//  TimeWindow.m
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ForeCast.h"

@interface ForeCast (PrivateMethods)
-(void)display;
-(void)setup;
@end;

@implementation ForeCast

-(id)init
{
    if(self = [super init])
    {
        [self setup];
        [self display];
    }
    
    return self;
}

-(void)setup
{
    utils = [Utils current];
    weather = [[NSArray arrayWithObjects:[NSNumber numberWithInteger:0],
                [NSNumber numberWithInteger:1],
                [NSNumber numberWithInteger:2],
                [NSNumber numberWithInteger:2],
                [NSNumber numberWithInteger:1],
                [NSNumber numberWithInteger:2],
                [NSNumber numberWithInteger:2],
                [NSNumber numberWithInteger:0],
                [NSNumber numberWithInteger:0],
                [NSNumber numberWithInteger:1],
                [NSNumber numberWithInteger:0],
                [NSNumber numberWithInteger:1],
                [NSNumber numberWithInteger:0],
                [NSNumber numberWithInteger:2],
                [NSNumber numberWithInteger:2],
                [NSNumber numberWithInteger:1],
                [NSNumber numberWithInteger:1],
                [NSNumber numberWithInteger:0],
                [NSNumber numberWithInteger:0],
                [NSNumber numberWithInteger:0],
                [NSNumber numberWithInteger:2],
                [NSNumber numberWithInteger:2],
                [NSNumber numberWithInteger:1],
                [NSNumber numberWithInteger:2],
                [NSNumber numberWithInteger:2],
                [NSNumber numberWithInteger:1],
                [NSNumber numberWithInteger:0],
                [NSNumber numberWithInteger:0],
                [NSNumber numberWithInteger:1],
                [NSNumber numberWithInteger:2],
                nil] retain];
    
    weatherTypes = [NSArray arrayWithObjects:@"bad.png", @"medium.png", @"good.png", nil];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"forcast.plist"];
    forCastBatch = [CCSpriteBatchNode batchNodeWithFile:@"forcast.png"];
    
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
    
    w = [utils relativeDistance:153 horizontal:YES];
    h = [utils relativeDistance:455 horizontal:YES];
    
    sliderMinPos = -[utils relativeDistance:416 horizontal:NO];
    sliderMaxPos = -[utils relativeDistance:116 horizontal:NO];
}

-(void)display
{
    sliderHolder = [CCSprite node];
    slider = [CCSprite node];
    background = [CCSprite spriteWithFile:@"forcastbg.png"];
    background.anchorPoint = ccp(0, 1);
    weatherHolder = [CCSprite node];
    
    int countMax = [weather count];
    int countPos = 3;
    int itemWidth = [utils relativeDistance:40 horizontal:YES];
    int itemHeight = [utils relativeDistance:60 horizontal:YES];
    int xPos = [utils relativeDistance:(itemWidth * countPos) horizontal:YES];
    int yPos = 0;
    
    for(int i=countMax -1; i > 0; i--)
    {
        CCSprite *weatherItem = [CCSprite node];
        CCSprite *img = [CCSprite spriteWithSpriteFrameName:[weatherTypes objectAtIndex:[[weather objectAtIndex:i] integerValue]]];
        weatherItem.position = ccp(xPos, yPos);
        
        [weatherItem addChild:img];
        [weatherHolder addChild:weatherItem];
        
        if(countPos == 3)
        {
            countPos = 0;
            xPos = 0;
            yPos += [utils relativeDistance:itemHeight horizontal:NO];
        }
        else
        {
            countPos += 1;
            xPos = [utils relativeDistance:(itemWidth * countPos) horizontal:YES];
        }
    }
    
    sliderHolder.position = ccp(itemWidth * .6, - itemHeight * .5);
    slider.position = ccp(0, sliderMinPos);
    
    [self addChild:background];
    [self addChild:sliderHolder];
    [sliderHolder addChild:slider];
    [slider addChild:weatherHolder];
    self.position = [utils relativePointByCoordinates:848 ypos:390];
}

-(void)selectSpriteForTouch:(UITouch*)touch
{
    CGRect boundingbox = CGRectMake(slider.position.x, slider.position.y, w, h);
    boundingbox.origin = CGPointZero;
    
    if(CGRectContainsPoint(boundingbox, [slider convertTouchToNodeSpace: touch]))
    {
        dragging = YES;
    }
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self selectSpriteForTouch:touch];
    return TRUE;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(dragging == YES)
    {
        //drag the climber
        CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
        CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
        oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
        oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
        CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
        CGPoint newPoint = ccp(slider.position.x, slider.position.y + translation.y);
        
        if(newPoint.y > sliderMinPos && newPoint.y < sliderMaxPos)
        {
            slider.position = newPoint;
        }
    }
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    dragging = NO;
}


-(void)updateTime:(int)time
{

}

-(void)updateTurn:(int)turn
{
}

@end
