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

-(id) init
{
	if( (self=[super init])) {
        
        blockedRoutes = [[[NSMutableArray alloc] init] retain];
        utils = [Utils current];
        
        [self display];
        [self setup];
	}
	return self;
}

-(void)display
{
    NSArray *positions = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:[utils relativePointByCoordinates:229 ypos:166]],
                         [NSValue valueWithCGPoint:[utils relativePointByCoordinates:368 ypos:240]],
                         [NSValue valueWithCGPoint:[utils relativePointByCoordinates:471 ypos:308]],
                         [NSValue valueWithCGPoint:[utils relativePointByCoordinates:459 ypos:381]],
                         [NSValue valueWithCGPoint:[utils relativePointByCoordinates:336 ypos:501]],
                          nil];
    
    routesHolder = [CCSprite node];
    blockHolder = [CCSprite node];
    
    [self addChild:routesHolder];
    [self addChild:blockHolder];
    
    int count = [positions count];
    
    for(int i=0; i < count; i++)
    {
        NSString *imagepath = [NSString stringWithFormat:@"path%d.png", i];
        NSString *imagepathBlocked = [NSString stringWithFormat:@"path%dBlocked.png", i];
        
        CCSprite *route = [CCSprite spriteWithFile:imagepath];
        route.anchorPoint = ccp(0, 1);
        route.position = [[positions objectAtIndex:i] CGPointValue];
        [routesHolder addChild:route];
        
        CCSprite *routeBlocked = [CCSprite spriteWithFile:imagepathBlocked];
        routeBlocked.anchorPoint = ccp(0, 1);
        routeBlocked.position = [[positions objectAtIndex:i] CGPointValue];
        routeBlocked.visible = 0;
        [blockHolder addChild:routeBlocked];
        
        [blockedRoutes addObject:routeBlocked];
    }
}

- (void) setup
{
    
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

-(BOOL)getPermissionToCross:(int)route
{
    if(route == blockedIndex)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)updateTime:(int)time
{

}

-(void)updateTurn:(int)turn
{

}

-(void) dealloc
{
    [super dealloc];
    [blockedRoutes release];
}

@end