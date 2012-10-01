//
//  Background.m
//  everest game
//
//  Created by Tom Huynen on 9/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CampManager.h"
#import "Utils.h"
#import "Camp.h"
#import "SummitCamp.h"

@interface CampManager (PrivateMethods)
-(void) setup;
-(void) display;
@end


@implementation CampManager

@synthesize positions;
@synthesize boxRights;
@synthesize camps;

static CampManager* sharedInstance;


-(id) init
{
	if( (self=[super init])) {
		
        sharedInstance = self;
        
        [self setup];
        [self display];
	}
	return self;
}

+(CampManager *)current;
{
    return sharedInstance;
}

-(void) setup
{
    utils = [Utils current];
    
    positions =  [NSArray arrayWithObjects:[NSValue valueWithCGPoint:[utils relativePointByCoordinates:224 ypos:42]],
                 [NSValue valueWithCGPoint:[utils relativePointByCoordinates:342 ypos:192]],
                 [NSValue valueWithCGPoint:[utils relativePointByCoordinates:449 ypos:261]],
                 [NSValue valueWithCGPoint:[utils relativePointByCoordinates:485 ypos:336]],
                 [NSValue valueWithCGPoint:[utils relativePointByCoordinates:444 ypos:405]],
                 nil];
    
    heights = [NSArray arrayWithObjects:[NSNumber numberWithInteger:1000],
               [NSNumber numberWithInteger:2000],
               [NSNumber numberWithInteger:3000],
               [NSNumber numberWithInteger:4000],
               [NSNumber numberWithInteger:5000],
               nil];
    
    distances = [NSArray arrayWithObjects:[NSNumber numberWithInteger:1000],
                 [NSNumber numberWithInteger:2000],
                 [NSNumber numberWithInteger:3000],
                 [NSNumber numberWithInteger:4000],
                 [NSNumber numberWithInteger:5000],
                 nil];
    
    boxRights = [[NSArray arrayWithObjects:[NSNumber numberWithInteger:1],
                 [NSNumber numberWithInteger:-1],
                 [NSNumber numberWithInteger:1],
                 [NSNumber numberWithInteger:-1],
                 [NSNumber numberWithInteger:-1],
                 nil] retain];
    
    camps = [[NSMutableArray alloc] init];
}

-(void)display
{
    int count = [positions count];
    
    for(int i=0; i < count; i++)
    {
        if(i == count - 1)
        {
            SummitCamp *camp = [[SummitCamp alloc] initWithId:i height:[[heights objectAtIndex:i] integerValue]
                                         distance:[[distances objectAtIndex:i] integerValue]
                                         boxRight:[[boxRights objectAtIndex:i] integerValue]];
            
            camp.position = [[positions objectAtIndex:i] CGPointValue];
            [self addChild:camp];
            [camps addObject:camp];
        }
        else
        {
            Camp *camp = [[Camp alloc] initWithId:i height:[[heights objectAtIndex:i] integerValue]
                                         distance:[[distances objectAtIndex:i] integerValue]
                                         boxRight:[[boxRights objectAtIndex:i] integerValue]];
            
            camp.position = [[positions objectAtIndex:i] CGPointValue];
            [self addChild:camp];
            [camps addObject:camp];
        }
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
}

@end