//
//  Routes.m
//  everest game
//
//  Created by Tom Huynen on 9/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Routes.h"
#import "Utils.h"

@interface Routes (PrivateMethods)
-(void) display;
-(void) setup;
@end


@implementation Routes

static Routes* current;

-(id) init
{
	if( (self=[super init])) {
        
        blockedRoutes = [[[NSMutableArray alloc] init] retain];
        utils = [Utils current];
        
        [self setup];
        [self display];
	}
	return self;
}

-(void)display
{
    NSArray *positions = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:[utils relativePointByCoordinates:220 ypos:320]],
                         [NSValue valueWithCGPoint:[utils relativePointByCoordinates:483 ypos:429]],
                         [NSValue valueWithCGPoint:[utils relativePointByCoordinates:490 ypos:520]],
                         [NSValue valueWithCGPoint:[utils relativePointByCoordinates:450 ypos:605]],
                         [NSValue valueWithCGPoint:[utils relativePointByCoordinates:219 ypos:750]],
                          nil];
    
    routesHolder = [CCSprite node];
    blockHolder = [CCSprite node];
    
    [self addChild:routesHolder];
    [self addChild:blockHolder];
    
    int count = [positions count];
    
    for(int i=0; i < count; i++)
    {
        NSString *imagepath = [NSString stringWithFormat:@"route%d.png", i];
        NSString *imagepathBlocked = [NSString stringWithFormat:@"route%d-blocked.png", i];
        
        CCSprite *route = [CCSprite spriteWithSpriteFrameName:imagepath];
        route.anchorPoint = ccp(0, 1);
        route.position = [[positions objectAtIndex:i] CGPointValue];
        [routesHolder addChild:route];
        
        CCSprite *routeBlocked = [CCSprite spriteWithSpriteFrameName:imagepathBlocked];
        routeBlocked.anchorPoint = ccp(0, 1);
        routeBlocked.position = [[positions objectAtIndex:i] CGPointValue];
        routeBlocked.visible = 0;
        [blockHolder addChild:routeBlocked];
        
        [blockedRoutes addObject:routeBlocked];
    }
}

- (void) setup
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"routes.plist"];
    routesBatch = [CCSpriteBatchNode batchNodeWithFile:@"routes.png"];
    current = self;
    blockedIndex = -1;
}

-(void)blockRoute:(int)index
{
    blockedIndex = index;
    
    int count = [blockedRoutes count];
    
    for(int i=0; i < count; i++)
    {
        CCSprite *route = [blockedRoutes objectAtIndex:i];
        
        if(i == index)
        {
            route.visible = 1;
        }
        else
        {
            route.visible = 0;
        }
    }
}

-(BOOL)getPermissionToCrossCampFrom:(int)cf campTo:(int)ct
{
    //targetCamp lower then startCamp
    if(ct < cf)
    {
        if(ct == blockedIndex)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else if(ct > cf)
    {
        //target camp higher then startCamp
        if(cf == blockedIndex)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return YES;
    }
}

-(void)updateTime:(int)time
{

}

-(void)updateTurn:(int)turn
{

}

+(Routes*) current
{
    if (current == nil)
    {
        current = [[Routes alloc] init];
    }
    
    return current;
}

-(void) dealloc
{
    [super dealloc];
    [blockedRoutes release];
}

@end