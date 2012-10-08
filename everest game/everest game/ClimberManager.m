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
#import "Routes.h"
#import "MaterialChoice.h"

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

static ClimberManager* current;

-(id)init
{
    if(self = [super init])
    {
        current = self;
        
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
    
    CGPoint campPos0 = [utils relativePointByCoordinates:375 ypos:30];
    CGPoint campPos1 = [utils relativePointByCoordinates:104 ypos:309];
    CGPoint campPos2 = [utils relativePointByCoordinates:575 ypos:435];
    CGPoint campPos3 = [utils relativePointByCoordinates:88 ypos:526];
    CGPoint campPos4 = [utils relativePointByCoordinates:485 ypos:601];
    
    int boxWidth = [utils relativeDistance:315 horizontal:YES];
    int boxHeight = [utils relativeDistance:54 horizontal:YES];
    
    panel0boundingBox = CGRectMake(campPos0.x, campPos0.y, boxWidth, boxHeight);
    panel1boundingBox = CGRectMake(campPos1.x, campPos1.y, boxWidth, boxHeight);
    panel2boundingBox = CGRectMake(campPos2.x, campPos2.y, boxWidth, boxHeight);
    panel3boundingBox = CGRectMake(campPos3.x, campPos3.y, boxWidth, boxHeight);
    panel4boundingBox = CGRectMake(campPos4.x, campPos4.y, boxWidth, boxHeight);
    
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
                           [NSValue valueWithCGRect:panel2boundingBox],
                           [NSValue valueWithCGRect:panel3boundingBox],
                           [NSValue valueWithCGRect:panel4boundingBox],
                           nil] retain];
    
    panelPositions = [[NSArray arrayWithObjects:[NSValue valueWithCGPoint:[utils relativePointByCoordinates:340 ypos:42]],
                       [NSValue valueWithCGPoint:[utils relativePointByCoordinates:438 ypos:168]],
                       [NSValue valueWithCGPoint:[utils relativePointByCoordinates:564 ypos:251]],
                       [NSValue valueWithCGPoint:[utils relativePointByCoordinates:555 ypos:324]],
                       [NSValue valueWithCGPoint:[utils relativePointByCoordinates:509 ypos:391]],
                       nil] retain];
    
    panelRights = [[NSArray arrayWithObjects:[NSNumber numberWithInteger:1],
                  [NSNumber numberWithInteger:-1],
                  [NSNumber numberWithInteger:1],
                  [NSNumber numberWithInteger:-1],
                  [NSNumber numberWithInteger:1],
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
    
    platform = [CCSprite spriteWithFile:@"drop-indicator.png"];
    [self addChild:platform];
    
    for(int i=0; i < count; i++)
    {
        Climber *climber = [[Climber alloc] initWithId:i campPositionId:i];
        int startPosX = boundingBox.origin.x + climber.radius;
        int startPosY = boundingBox.origin.y + climber.radius;
        
        CGPoint climberPosition = ccp(startPosX + (i * climberSpacing), startPosY);
        
        climber.position = climberPosition;
        climber.scaleX = climber.scaleY = .5;
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
        movingClimber.scaleX = movingClimber.scaleY = 1;
    }
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self selectSpriteForTouch:touch];
    return TRUE;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(movingClimber != nil)
    {
        //drag the climber
        CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
        CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
        oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
        oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
        CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
        [self panForTranslation:translation];
        

        CGPoint climberPos = movingClimber.position;
        CGRect climberRect = CGRectMake(climberPos.x - movingClimber.diameter, climberPos.y - movingClimber.diameter, 2 * movingClimber.diameter, 2 * movingClimber.diameter);


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
                    
                    //position only in camp when 1: climber is not in camp allready, 2: routes agrees 3: next camp is next to previous one.
                    if(movingClimber.isInArray == NO &&
                       [[Routes current] getPermissionToCrossCampFrom:movingClimber.campId campTo:currentPanelId ] &&
                       abs(currentPanelId - movingClimber.campId) <= 1)
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
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(movingClimber != nil)
    {
        //get the climber back in previous camp if touch ended outside a camp.
        if(movingClimber.isInArray == NO)
        {
            movingClimber.isInArray= YES;
            NSMutableArray *currentPanelClimbers = [panelClimbers objectAtIndex:movingClimber.campId];
            [currentPanelClimbers addObject:movingClimber];
        }
        else
        {
            if(movingClimber.campId != campLeftByClimber.campId)
            {
                [[MaterialChoice current] show];
            }
        }
        
        movingClimber.scaleX = movingClimber.scaleY = .5;
        
        int campId = movingClimber.campId;
        movingClimber = nil;
        [self positionClimbersInPanel:campId];
    }
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
    int plusMin = [[panelRights objectAtIndex:id] integerValue];
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

        
        if(climber == movingClimber)
        {
            platform.position = climberPosition;
        }
        else
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

+(ClimberManager*) current
{
    if (current == nil)
    {
        current = [[ClimberManager alloc] init];
    }
    
    return current;
}

-(void)dealloc
{
    [super dealloc];
    
    [climbers release];
    [panelBoundingBoxes release];
}

@end
