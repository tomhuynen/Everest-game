//
//  ClimberManager.m
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ClimberManager.h"
#import "Climber.h"
#import "CampManager.h"
#import "CCSpriteCategory.h"

@interface ClimberManager (PrivateMethods)
-(void)display;
-(void)setup;
-(void) panForTranslation:(CGPoint)translation;
-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event;
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) selectSpriteForTouch:(UITouch*)touch;
@end

@implementation ClimberManager

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
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    
    utils = [Utils current];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"climbers.plist"];
    climberBatch = [CCSpriteBatchNode batchNodeWithFile:@"climbers.png"];
    climberSpacing = [utils relativeDistance:60 horizontal:YES];
}

-(void)display
{
    climbers = [[NSMutableArray alloc] init];
    NSArray *names = [NSArray arrayWithObjects:@"tom", @"peter", @"jeroen", @"job", @"luca", nil];
    CGPoint panelPositionOner = [[[CampManager current].panelPositions objectAtIndex:0] CGPointValue];
    int count = [names count];

    for(int i=0; i < count; i++)
    {
        
        CGPoint climberPosition = ccp(panelPositionOner.x + (i * climberSpacing), panelPositionOner.y);
        
        Climber *climber = [[Climber alloc] initWithId:i];
        climber.position = climberPosition;
        [self addChild:climber];
        [climbers addObject:climber];
    }
}

-(void) selectSpriteForTouch:(UITouch*)touch
{
    Climber *newClimber = nil;
    
    for(Climber *climber in climbers)
    {
        if([climber containsTouchLocation:touch])
        {
            newClimber = climber;
            break;
        }
    }
    
    if(movingClimber != newClimber)
    {
        movingClimber = newClimber;
    }
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self selectSpriteForTouch:touch];
    return TRUE;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation:translation];
}

- (void) panForTranslation:(CGPoint)translation
{
    if(movingClimber)
    {
        CGPoint newPoint = ccpAdd(movingClimber.position, translation);
        movingClimber.position = newPoint;
    }
}



-(void)positionInCamp:(int)id
{

}

-(void)makeRoomInCamp:(int)id
{

}

-(void)calculateCondition:(int)id
{

}

-(void)summitAttempt
{

}

-(void)removeClimber:(int)id
{

}

-(void)updateTime:(int)time
{

}

-(void)updateTurn:(int)turn
{

}

@end
