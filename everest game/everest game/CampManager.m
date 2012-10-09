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
@synthesize campBatch;
@synthesize spaceCampToBox;

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

-(void) setup
{
    utils = [Utils current];
    
    positions =  [NSArray arrayWithObjects:[NSValue valueWithCGPoint:[utils relativePointByCoordinates:227 ypos:58]],
                 [NSValue valueWithCGPoint:[utils relativePointByCoordinates:469 ypos:335]],
                 [NSValue valueWithCGPoint:[utils relativePointByCoordinates:477 ypos:450]],
                 [NSValue valueWithCGPoint:[utils relativePointByCoordinates:489 ypos:543]],
                 [NSValue valueWithCGPoint:[utils relativePointByCoordinates:454 ypos:617]],
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
                 [NSNumber numberWithInteger:1],
                 [NSNumber numberWithInteger:1],
                 [NSNumber numberWithInteger:-1],
                 [NSNumber numberWithInteger:-1],
                 nil] retain];
    
    spaceCampToBox = [[NSArray arrayWithObjects:[NSNumber numberWithInteger:[utils relativeDistance:90 horizontal:YES]],
                     [NSNumber numberWithInteger:[utils relativeDistance:70 horizontal:YES]],
                     [NSNumber numberWithInteger:[utils relativeDistance:70 horizontal:YES]],
                     [NSNumber numberWithInteger:[utils relativeDistance:80 horizontal:YES]],
                     [NSNumber numberWithInteger:[utils relativeDistance:75 horizontal:YES]],
                     nil] retain];
    
    camps = [[NSMutableArray alloc] init];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"camps.plist"];
    campBatch = [CCSpriteBatchNode batchNodeWithFile:@"camps.png"];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"boxes.plist"];
    boxBatch = [CCSpriteBatchNode batchNodeWithFile:@"boxes.png"];
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
            [camp addMaterial:250];
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

-(void) addMaterial: (int)amount camp:(int)id
{
    Camp *camp = [camps objectAtIndex:id];
    [camp addMaterial:amount];
}

-(void)removeMaterial:(int)amount camp:(int)id
{
    Camp *camp = [camps objectAtIndex:id];
    [camp removeMaterial:amount];
}

-(void)updateTime:(int)time
{
    
}

-(void)updateTurn:(int)turn
{

}

+(CampManager *)current;
{
    return sharedInstance;
}

-(void) dealloc
{
    [super dealloc];
}

@end