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
		
        utils = [Utils current];
        
        [self display];
        [self setup];
	}
	return self;
}

-(void)display
{
    NSArray *positions = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:[utils relativePointByCoordinates:0 ypos:0]],
                         [NSValue valueWithCGPoint:[utils relativePointByCoordinates:234 ypos:592]],
                         [NSValue valueWithCGPoint:[utils relativePointByCoordinates:383 ypos:526]],
                         [NSValue valueWithCGPoint:[utils relativePointByCoordinates:480 ypos:443]],
                         [NSValue valueWithCGPoint:[utils relativePointByCoordinates:457 ypos:385]],
                         [NSValue valueWithCGPoint:[utils relativePointByCoordinates:337 ypos:285]],
                          nil];

    NSArray *images = [NSArray arrayWithObjects:@"path0.png", @"path1.png", @"path2.png", @"path3.png", @"path4.png", @"path5.png", nil];
    
    
    routesHolder = [CCSprite node];
    blockHolder = [CCSprite node];
    
    [self addChild:routesHolder];
    [self addChild:blockHolder];
    
    int count = [positions count] - 1;
    
    for(int i=0; i < count; i++)
    {
        CCSprite *route = [CCSprite spriteWithFile:[images objectAtIndex:i]];
        route.anchorPoint = ccp(0, 0);
        route.position = [[positions objectAtIndex:i] CGPointValue];
        [self addChild:route];
    }

}

- (void) setup
{

}

@end

















