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
#import "Camp.h"
#import "CCSpriteCategory.h"

@interface ClimberManager (PrivateMethods)
-(void)display;
-(void)setup;
-(void) panForTranslation:(CGPoint)translation;
-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event;
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;
-(void)selectSpriteForTouch:(UITouch*)touch;
-(void)positionClimbersInPanel:(int)id;
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
    currentPanelId = 0;
    
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    
    utils = [Utils current];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"climbers.plist"];
    climberBatch = [CCSpriteBatchNode batchNodeWithFile:@"climbers.png"];
    climberSpacing = [utils relativeDistance:60 horizontal:YES];
    
    CGPoint campPos0 = [utils relativePointByCoordinates:310 ypos:15];
    CGPoint campPos1 = [utils relativePointByCoordinates:0 ypos:167];
    CGPoint campPos2 = [utils relativePointByCoordinates:200 ypos:14];
    CGPoint campPos3 = [utils relativePointByCoordinates:200 ypos:14];
    CGPoint campPos4 = [utils relativePointByCoordinates:200 ypos:14];
    
    NSLog(@"test: %f", campPos0.x);
    
    panel0boundingBox = CGRectMake(campPos0.x, campPos0.y, [utils relativeDistance:297 horizontal:YES], [utils relativeDistance:55 horizontal:YES]);
    panel1boundingBox = CGRectMake(campPos1.x, campPos1.y, [utils relativeDistance:256 horizontal:YES], [utils relativeDistance:55 horizontal:YES]);
    panel2boundingBox = CGRectMake(campPos2.x, campPos2.y, [utils relativeDistance:323 horizontal:YES], [utils relativeDistance:55 horizontal:YES]);
    panel3boundingBox = CGRectMake(campPos3.x, campPos3.y, [utils relativeDistance:323 horizontal:YES], [utils relativeDistance:55 horizontal:YES]);
    panel4boundingBox = CGRectMake(campPos4.x, campPos4.y, [utils relativeDistance:323 horizontal:YES], [utils relativeDistance:55 horizontal:YES]);
    
    /*
    panelBoundingBoxes = [[NSArray arrayWithObjects:[NSValue valueWithCGRect:panel0boundingBox],
                           [NSValue valueWithCGRect:panel1boundingBox],
                           [NSValue valueWithCGRect:panel2boundingBox],
                           [NSValue valueWithCGRect:panel3boundingBox],
                           [NSValue valueWithCGRect:panel4boundingBox],
                           nil] retain];
     */
    
    panelBoundingBoxes = [[NSArray arrayWithObjects:[NSValue valueWithCGRect:panel0boundingBox],
                           [NSValue valueWithCGRect:panel1boundingBox],
                           nil] retain];
    
    panelPositions = [[NSArray arrayWithObjects:[NSValue valueWithCGPoint:[utils relativePointByCoordinates:340 ypos:42]],
                       [NSValue valueWithCGPoint:[utils relativePointByCoordinates:438 ypos:168]],
                       [NSValue valueWithCGPoint:[utils relativePointByCoordinates:564 ypos:251]],
                       [NSValue valueWithCGPoint:[utils relativePointByCoordinates:555 ypos:324]],
                       [NSValue valueWithCGPoint:[utils relativePointByCoordinates:509 ypos:391]],
                       nil] retain];
    
    panelClimberCamp0 = [[NSMutableArray alloc] init];
    panelClimberCamp1 = [[NSMutableArray alloc] init];
    panelClimberCamp2 = [[NSMutableArray alloc] init];
    panelClimberCamp3 = [[NSMutableArray alloc] init];
    panelClimberCamp4 = [[NSMutableArray alloc] init];
    panelClimbers = [[NSArray arrayWithObjects:panelClimberCamp0, panelClimberCamp1, panelClimberCamp2, panelClimberCamp3, panelClimberCamp4, nil] retain];
    
}

-(void)display
{
    climbers = [[NSMutableArray alloc] init];
    NSArray *names = [NSArray arrayWithObjects:@"tom", @"peter", @"jeroen", @"job", @"luca", nil];
    CGRect boundingBox = [[panelBoundingBoxes objectAtIndex:0] CGRectValue];
    int count = [names count];
    
    for(int i=0; i < count; i++)
    {
        Climber *climber = [[Climber alloc] initWithId:i campPositionId:i];
        int startPosX = boundingBox.origin.x + climber.radius;
        int startPosY = boundingBox.origin.y + climber.radius;
        
        CGPoint climberPosition = ccp(startPosX + (i * climberSpacing), startPosY);
        
        
        climber.position = climberPosition;
        [self addChild:climber];
        [climbers addObject:climber];
        [panelClimberCamp0 addObject:climber];
    }

}

-(void)selectSpriteForTouch:(UITouch*)touch
{
    Climber *newClimber = nil;
    
    for(Climber *climber in climbers)
    {
        CGRect boundingbox = [[climber image] boundingBox];
        boundingbox.origin = CGPointZero;
        
        if(CGRectContainsPoint(boundingbox, [[climber image] convertTouchToNodeSpace: touch]))
        {
            newClimber = climber;
            break;
        }
    }
    
    if(movingClimber != newClimber)
    {
        movingClimber = newClimber;
        currentPanelId = movingClimber.campId;
        movingClimber.startDragPosition = movingClimber.position;
        movingClimber.positionOnStartMove = newClimber.position;
        campLeftByClimber = [[CampManager current].camps objectAtIndex:movingClimber.campId];
    }
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self selectSpriteForTouch:touch];
    return TRUE;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    //drag the climber
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation:translation];
    
    
    CGPoint climberPos = movingClimber.position;
    CGRect climberRect = CGRectMake(climberPos.x - movingClimber.radius, climberPos.y - movingClimber.radius, movingClimber.diameter, movingClimber.diameter);
    
    
    //is the climber hitting a camp?
    int boxCount = [panelBoundingBoxes count];
    BOOL hitCamp = NO;
    
    for(int i=0; i < boxCount; i++)
    {
        CGRect boundingBox = [[panelBoundingBoxes objectAtIndex:i] CGRectValue];
        
        if(CGRectIntersectsRect(boundingBox, climberRect) == YES)
        {            
            hitCamp = YES;

            if(currentPanelId != i)
            {
                currentPanelId = i;
                
                if(movingClimber.isInArray == NO)
                {
                    movingClimber.isInArray = YES;
                    movingClimber.campId = currentPanelId;
                    NSMutableArray *currentPanelClimbers = [panelClimbers objectAtIndex:currentPanelId];
                    [currentPanelClimbers addObject:movingClimber];
                    [self positionClimbersInPanel:currentPanelId];
                    NSLog(@"add: %d", currentPanelId);
                }
            }
            
            break;
        }
    }
    
    if(hitCamp == NO)
    {
        if(movingClimber.isInArray == YES)
        {
            currentPanelId = -1;
            movingClimber.isInArray = NO;
            NSMutableArray *currentPanelClimbers = [panelClimbers objectAtIndex:movingClimber.campId];
            [currentPanelClimbers removeObject:movingClimber];
            [self positionClimbersInPanel:movingClimber.campId];
            NSLog(@"remove");
        }
    }
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    /*
    float diffX = abs(movingClimber.startDragPosition.x - movingClimber.position.x);
    float diffY = abs(movingClimber.startDragPosition.y - movingClimber.position.y);
    
    if(currentPanelId == -1 || (currentPanelId == movingClimber.campId && (diffX > movingClimber.diameter || diffY > movingClimber.diameter)))
    {
        currentPanelId = campLeftByClimber.campId;
        movingClimber.campId = currentPanelId;
        NSMutableArray *currentPanelClimbers = [panelClimbers objectAtIndex:currentPanelId];
        [currentPanelClimbers addObject:movingClimber];
    }
    else
    {
        movingClimber.campId = currentPanelId;    
    }

    movingClimber = nil;
    */
    
    int campId = movingClimber.campId;
    movingClimber = nil;
    [self positionClimbersInPanel:campId];
}

- (void) panForTranslation:(CGPoint)translation
{
    if(movingClimber)
    {
        CGPoint newPoint = ccpAdd(movingClimber.position, translation);
        movingClimber.position = newPoint;
    }
}

-(void)positionClimbersInPanel:(int)id
{
    NSMutableArray *currentPanelClimbers = [panelClimbers objectAtIndex:id];

    int count = [currentPanelClimbers count];
    int plusMin = [[[CampManager current].boxRights objectAtIndex:id] integerValue];
    CGRect boundingBox = [[panelBoundingBoxes objectAtIndex:id] CGRectValue];
    
    if(plusMin == 1)
    {
        [currentPanelClimbers sortUsingComparator:(NSComparator)^(Climber *climber1, Climber *climber2) {
            float x1 = climber1.position.x;
            float x2 = climber2.position.x;
            if (x1 < x2)
                return NSOrderedAscending;
            else if (x1 == x2)
                return NSOrderedSame;
            else
                return NSOrderedDescending;
        }];
    }
    else
    {
        [currentPanelClimbers sortUsingComparator:(NSComparator)^(Climber *climber1, Climber *climber2) {
            float x1 = climber1.position.x;
            float x2 = climber2.position.x;
            if (x1 < x2)
                return NSOrderedDescending;
            else if (x1 == x2)
                return NSOrderedSame;
            else
                return NSOrderedAscending;
        }];
    }
    
    
    for(int i=0; i < count; i++)
    {
        Climber *climber = [currentPanelClimbers objectAtIndex:i];
        
        int startPosX;
        int startPosY = boundingBox.origin.y + climber.radius;
        
        
        if(plusMin == 1)
        {
            startPosX = boundingBox.origin.x + climber.radius;
        }
        else
        {
            startPosX = boundingBox.origin.x + boundingBox.size.width - climber.radius;
        }
        
        CGPoint climberPosition = ccp(startPosX + (plusMin * i * climberSpacing), startPosY);

        
        if(climber != movingClimber)
        {
            climber.position = climberPosition;
        }
    }
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

-(void)dealloc
{
    [super dealloc];
    
    [climbers release];
    [panelBoundingBoxes release];
}

@end
