//
//  Routes.m
//  everest game
//
//  Created by Tom Huynen on 9/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Camp.h"
#import "Utils.h"

@interface Camp (PrivateMethods)
-(void) setup;
@end


@implementation Camp


-(id) initWithId:(int)i height:(int)h distance:(int)d boxRight:(int)br
{
    if( (self=[super init]))
    {
        utils = [Utils current];
        
        campId = i;
        height = h;
        distance = d;
        boxRight = br;
        
        [self display];
	}
	return self;
}

-(void)display
{
    imgHolder = [CCSprite node];
    imgNight = [CCSprite node];
    imgDay = [CCSprite spriteWithFile:[NSString stringWithFormat:@"camp%d.png", campId]];
    boxHolder = [CCSprite node];
    box = [CCSprite spriteWithFile:[NSString stringWithFormat:@"box%d.png", campId]];
    
    boxHolder.position = ccp(boxRight * [utils relativeDistance:60 horizontal:YES], 0);
    
    [self addChild:imgHolder];
    [imgHolder addChild:imgNight];
    [imgHolder addChild:imgDay];
    [imgHolder addChild:boxHolder];
    [boxHolder addChild:box];
}

- (void) setup
{
    
}

-(void) dealloc
{
    [super dealloc];
}

@end